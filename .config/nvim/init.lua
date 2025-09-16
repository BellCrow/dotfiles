require("util")

-- first things first
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.leader = " "
vim.g.maplocalleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end

vim.opt.rtp:prepend(lazypath)

-- now lazy is installed. we can start adding plugins now

-- i have a custom folder structure for my language specific things, that goes like this:
--------------------------------
-- lua/
-- 	languages/
-- 		<languageName>
-- 			lsp/
-- 			  ..stuff to make the lsp work (needs to be called like "require(modulePaht)")
-- 			plugins/
-- 			  ..plugins specific to the language, that need to be loaded with lazy.nvim
-- 	editing/
-- 	 ..everything language agnostic goes here (treesitter, bindings, diagnostics etc.)
--------------------------------
--
-- 	 that means, that i have to programatically collect all the plugin folders from
-- 	 all the languages folders, that need to be loaded.

local config_lua_dir = vim.fn.stdpath("config") .. "/lua/"

-- in the lua folder there are 2 subfolders, that need be handled
-- the languages folder has multiple subfolders, that each contain
-- zero or more lua files, that need to be used with "require(xyz)"
-- and one folder called plugins, that need to be loaded with lazy
--
-- the editing folder behaves in the same way as the one of the
-- subfolders of the language folder
local folder_spec = Generate_folder_spec(config_lua_dir .. "editing")

local languages_folder = Get_directories_in_path(config_lua_dir .. "languages")

-- collecting the important infos for each found folder
for _, language_folder in ipairs(languages_folder) do
	local language_folder_spec = Generate_folder_spec(language_folder)
	Add_spec_to_other_spec(folder_spec, language_folder_spec)
end

-- we have to convert the spec from the form, where
-- all specs are in one big table to one, that
-- has one subtable per plugins folder
local folder_lazy_spec = {}
for _, spec in ipairs(folder_spec.import) do
	table.insert(folder_lazy_spec, { import = spec })
end

-- here we tell lazy what plugins to load
-- and we also require all the collected lua files
require("lazy").setup({
	spec = folder_lazy_spec,
})
for _, to_require in ipairs(folder_spec.requires) do
	require(to_require)
end
