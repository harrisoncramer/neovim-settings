local u = require("functions.utils")
local git = require("git-helpers")

local function get_git_head()
  local head = vim.fn.FugitiveHead()
  if head == "" or head == nil then
    return "DETATCHED "
  end
  if string.len(head) > 20 then
    head = ".." .. head:sub(15)
  end
  return " " .. head
end

local filename = function()
  local git_root = git.get_root_git_dir()
  local modified = vim.api.nvim_buf_get_option(0, 'modified')
  local readonly = vim.api.nvim_buf_get_option(0, 'readonly')
  if git_root == nil then
    local base_file = u.basename(vim.api.nvim_buf_get_name(0))
    return base_file .. (modified and '  ' or '') .. (readonly and ' [-]' or '')
  end
  local full_file_path = vim.fn.expand('%:p')
  local escaped_git_root = git_root:gsub("[%^%$%(%)%%%.%[%]%*%+%-%?]", "%%%1")
  return full_file_path:gsub(escaped_git_root, "", 1) .. (modified and '  ' or '') .. (readonly and ' [-]' or '')
end

local mr_info = ""
local is_gitlab_mr = nil
local get_mr_info = function()
  if is_gitlab_mr == nil then
    is_gitlab_mr = require("git-helpers").is_gitlab_mr()
  end

  if not is_gitlab_mr then
    return ""
  end

  require("gitlab").data({ resources = {}, refresh = false }, function(data)
    mr_info = string.format("  '%s' by %s", data.info.title, data.info.author.username)
  end)
  return mr_info
end

local diagnostics = {
  'diagnostics',
  symbols = { error = "✘ ", warn = " ", hint = " ", info = " " },
}

local disabled_filetypes = { 'gitlab', 'DiffviewFiles', "oil" }

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "kyazdani42/nvim-web-devicons", opt = true },
  config = function()
    local colorscheme = require("colorscheme")
    local custom_kanagawa = require('lualine.themes.kanagawa')
    custom_kanagawa.normal.c.fg = colorscheme.surimiOrange

    require("lualine").setup({
      options = {
        disabled_filetypes = {
          winbar = disabled_filetypes,
          statusline = disabled_filetypes,
        },
        component_separators = { right = "" },
        section_separators = { left = "", right = "" },
        theme = custom_kanagawa,
        globalstatus = true,
      },
      sections = {
        lualine_a = { get_git_head },
        lualine_b = {
          filename,
          require("recorder").recordingStatus
        },
        lualine_c = { diagnostics, get_mr_info },
        lualine_x = { 'diff' },
        lualine_y = { 'encoding', 'filetype', },
      },
      inactive_winbar = {
        lualine_a = {},
        lualine_b = { filename },
      },
      winbar = {
        lualine_a = { filename },
        lualine_b = {},
        lualine_c = { diagnostics },
        lualine_x = { 'diff' },
        lualine_y = { 'progress', 'location' }
      },
    })
  end
}
