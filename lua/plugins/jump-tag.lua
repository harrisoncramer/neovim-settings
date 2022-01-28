return {
	setup = function()
		local jump = require("jump-tag")
		vim.keymap.set("n", "<leader>55", jump.jumpParent)
		vim.keymap.set("n", "<leader>5n", jump.jumpNextSibling)
		vim.keymap.set("n", "<leader>5p", jump.jumpPrevSibling)
		vim.keymap.set("n", "<leader>5c", jump.jumpChild)
	end,
}
