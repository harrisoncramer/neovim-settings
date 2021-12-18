local M = {}
M.setup = function(remap)
    vim.g.UltiSnipsSnippetsDir = "~/.config/nvim/my-snippets"
    vim.cmd [[ let g:UltiSnipsSnippetDirectories = ['snippets'] ]]

    vim.g.UltiSnipsExpandTrigger = "<C-o>"
    vim.g.UltiSnipsJumpForwardTrigger = '<c-j>'
    vim.g.UltiSnipsJumpBackwardTrigger = '<c-l>'

    -- Turn on Ultisnips in Javascript file for javascriptreact files
    vim.cmd [[ autocmd FileType javascriptreact UltiSnipsAddFiletypes javascript ]]
end
return M
