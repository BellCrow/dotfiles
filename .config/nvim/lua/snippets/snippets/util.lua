local ls = require("luasnip")
--- Clears all given snippets for a language
---@param lang string
function clear_snippets(lang)
	require("luasnip.session.snippet_collection").clear_snippets(lang)
end
