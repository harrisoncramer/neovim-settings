local colors = require("colorscheme")
local cmp_status_ok, cmp = pcall(require, "cmp")
local lspkind_status_ok, lspkind = pcall(require, "lspkind")

if not (cmp_status_ok and lspkind_status_ok) then
  vim.api.nvim_err_writeln("CMP dependencies not yet installed!")
  return
end

-- Setup completion engine
if cmp_status_ok then
  cmp.setup({
    preselect = cmp.PreselectMode.None, -- Don't automatically chose from a list
    snippet = {
      expand = function(args)
        vim.fn["UltiSnips#Anon"](args.body)
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = {
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
      ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
      ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
      ["<C-Space>"] = cmp.mapping(cmp.mapping.complete({}), { "i", "c" }),
      ["<S-Down>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ["<S-Up>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    },
    sources = cmp.config.sources({
      { name = "nvim_lsp",               max_item_count = 5 },
      { name = "nvim_lua",               max_item_count = 5 },
      { name = "ultisnips",              max_item_count = 5 },
      { name = "buffer",                 max_item_count = 5 },
      { name = "nvim_lsp_signature_help" },
    }),
  })

  -- Do not use buffer text for Go
  cmp.setup.filetype('go', {
    sources = cmp.config.sources({
      { name = "nvim_lsp",               max_item_count = 5 },
      { name = "nvim_lua",               max_item_count = 5 },
      { name = "ultisnips",              max_item_count = 5 },
      { name = "nvim_lsp_signature_help" },
    }),
  })
end
