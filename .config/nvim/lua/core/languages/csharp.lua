-- Formatting
local conform = require("conform")

conform.formatters.my_csharp = {
	command = "dotnet format",
	args = {
		"--include",
		"$FILENAME",
	},
	stdin = false,
}
conform.formatters_by_ft.cs = { "my_csharp" }


-- lsp
vim.lsp.config("roslyn_ls", {
	settings = {
		-- better performance
		-- according to mr ramboe
		-- from whom i have taken this :D
		["csharp|background_analysis"] = {
			dotnet_analyzer_diagnostics_scope = "openFiles",
			dotnet_compiler_diagnostics_scope = "openFiles",
		},
	},
})

vim.lsp.enable("roslyn_ls")

-- dap
vim.pack.add({ "https://github.com/NicholasMata/nvim-dap-cs" })
require("dap-cs").setup()

-- build
local function find_possible_build_targets(start_file_path, stop_marker)
	local start_directory = start_file_path
	if vim.fn.isdirectory(start_directory) then
		start_directory = vim.fs.dirname(start_file_path)
	end

	-- i might have to expand the root identifier
	-- to be a bit more sophisticated
	local solution_file_paths = Collect_files_upwards(start_directory, "%.sln$", stop_marker)
	local project_file_paths = Collect_files_upwards(start_directory, "%.csproj$", stop_marker)

	local possible_build_targets = {}
	for _, solution in pairs(solution_file_paths) do
		table.insert(possible_build_targets, solution)
	end
	for _, project in pairs(project_file_paths) do
		table.insert(possible_build_targets, project)
	end
	return possible_build_targets
end

-- build

local build_target_hint = nil

local function build_target(build_target_arg, clean)
	local make_command = "dotnet build --nologo -v q --property WarningLevel=0 /clp:ErrorsOnly"

	if clean then
		vim.print("Clean build")
		make_command = make_command .. " --no-incremental"
	end

	make_command = make_command .. " " .. build_target_arg
	vim.o.makeprg = make_command
	vim.notify("Building target: " .. build_target_arg .. " Log output in register c\n", vim.log.levels.INFO)
	vim.print("Building command: " .. make_command)
	vim.cmd("compiler dotnet")
	vim.cmd("let dotnet_errors_only = v:true")
	vim.cmd("let dotnet_show_project_file = v:false")
	vim.cmd("redir @c")
	vim.cmd("silent make " .. build_target_arg)
	vim.cmd("redir END")
	if not Is_quickfix_open() and 0 < #vim.fn.getqflist() then
		-- vim.cmd("cope")
	else
		vim.notify("No errors during build", vim.log.levels.INFO)
	end
end

local function build(clean)
	require("core/util")

	if build_target_hint ~= nil and File_exists(build_target_hint) then
		build_target(build_target_hint, clean)
		return
	end

	local current_file_path = vim.fn.expand("%:p")

	local possible_build_targets = find_possible_build_targets(current_file_path, ".git")

	if #possible_build_targets == 0 then
		vim.notify("No .net target to build found", vim.log.levels.ERROR)
		return
	end

	if #possible_build_targets == 1 then
		build_target_hint = possible_build_targets[1]
		build_target(build_target_hint, clean)
		return
	end

	if 1 < #possible_build_targets then
		vim.ui.select(possible_build_targets, { prompt = "Select the target to build: " }, function(selection)
			if selection == nil then
				return
			end
			build_target_hint = selection
			-- have to duplicate this, as this
			-- is being called as the callback
			-- of the picker
			build_target(build_target_hint, clean)
		end)
	end
end

vim.api.nvim_create_autocmd("BufEnter", {
	desc = "Setup dotnet build if we are in a csharp file",
	pattern = "*.cs",
	callback = function()
		vim.keymap.set("n", "<leader>bb", function()
			build(false)
		end)
		vim.keymap.set("n", "<leader>bB", function()
			build(true)
		end)
	end,
})
