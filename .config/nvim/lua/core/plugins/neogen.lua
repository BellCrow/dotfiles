vim.pack.add({ "https://github.com/danymat/neogen" })

-- Lazy loader for neogen: only require/setup when first used
local neogen_instance = nil
local function get_neogen()
	if not neogen_instance then
		neogen_instance = require("neogen")
		neogen_instance.setup()
	end
	-- docstyle
	-- make neogen use the xmldoc style for csharp (it seems like roslyn cannot parse doxygen, which is the default)
	require("neogen").configuration.languages.cs.template.annotation_convention = "xmldoc"
	return neogen_instance
end

vim.keymap.set("n", "<leader>cd", function()
	get_neogen().generate()
end)
