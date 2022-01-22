local f = require("functions")

local toggleStatus = function()
	local ft = vim.bo.filetype
	if ft == "fugitive" then
		vim.api.nvim_command("bd")
	else
		vim.api.nvim_command("Git")
	end
end

local gitPush = function()
	local isSubmodule = vim.fn.trim(vim.fn.system("git rev-parse --show-superproject-working-tree"))
	if isSubmodule == "" then
		if f.getOS() == "Linux" then
			vim.api.nvim_command("Git push")
		else
			vim.api.nvim_command("! git push")
		end
	else
		vim.fn.confirm("Push to origin/main branch for submodule?")
		vim.api.nvim_command("! git push origin HEAD:main")
	end
end

local gitOpen = function()
	vim.api.nvim_command("! git open")
end

return {
	setup = function(remap)
		remap({ "n", "<leader>gs", ":lua require('plugins.fugitive').toggleStatus()<CR>" })
		remap({ "n", "<leader>gP", ":lua require('plugins.fugitive').gitPush()<CR>" })
		remap({ "n", "<leader>go", ":lua require('plugins.fugitive').gitOpen()<CR>" })
	end,
	gitPush = gitPush,
	gitOpen = gitOpen,
	toggleStatus = toggleStatus,
}
