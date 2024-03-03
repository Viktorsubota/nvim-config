-- Function to check if a file exists
local function file_exists(file_path)
	local file = io.open(file_path, "r")
	if file then
		io.close(file)
		return true
	else
		return false
	end
end

-- Function to find .pylintrc in Git root
local function find_pylintrc_in_git_root()
	local git_root_cmd = vim.fn.systemlist("git rev-parse --show-toplevel")[1]

	if git_root_cmd ~= "" then
		local git_root = vim.fn.trim(git_root_cmd)
		local pylintrc_path = git_root .. "/.pylintrc"

		return file_exists(pylintrc_path) and pylintrc_path or nil
	else
		return nil
	end
end

