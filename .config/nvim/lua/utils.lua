--returns true if vim was started with a single folder as its argument
function IsSingleFolderLoaded()
	if vim.fn.argc() ~= 1 then
		return false, nil
	end
	local argument = vim.fn.argv(0)
	local absolute_path = vim.fn.fnamemodify(argument, ":p")
	local is_directory = vim.fn.isdirectory(absolute_path) ~= 0
	if not is_directory then
		absolute_path = nil
	end
	return is_directory, absolute_path
end
