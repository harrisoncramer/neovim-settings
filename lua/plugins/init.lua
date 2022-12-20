local u = require("functions.utils")

-- Require the plugin, and instead of calling it's setup method,
-- require another module at the given path and call THAT module's
-- setup function. Used to customize the plugin.
local custom = function(remote, config)
  if remote == nil then
    local local_config_ok = pcall(require, config)
    if not local_config_ok then
      print(config .. " configuration file not found.")
    end
  else
    local status = pcall(require, remote)
    if not status then
      print(remote .. " is not downloaded.")
      return
    end
    local local_config_ok = pcall(require, config)
    if not local_config_ok then
      print(remote .. " is not configured.")
    end
  end
end

-- Simply requires the module and calls it's setup method, if it exists
local default = function(mod)
  local status, m = pcall(require, mod)
  if not status then
    print(mod .. " is not downloaded.")
    return
  else
    if type(m.setup) == "function" then
      m.setup()
    end
  end
end

local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
  print("Packer installed, please exit NVIM and re-open, then run :PackerInstall")
  return
end

local packer = require("packer")

local os = u.get_os() == "Darwin" and "mac" or "linux"
local packer_options = {
  snapshot_path = vim.fn.stdpath("config") .. "/lockfiles/" .. os .. "/packer_snapshots",
}

if u.get_os() == "Darwin" then
  packer_options.max_jobs = 4
end

packer.init(packer_options)

packer.startup(function(use)
  use({ "wbthomason/packer.nvim" })
  use({ "neovim/nvim-lspconfig" })
  use({ "williamboman/mason-lspconfig.nvim" })
  use({ "harrisoncramer/mason-nvim-dap.nvim" })
  use({ "williamboman/mason.nvim", default("mason") })
  use({ "onsails/lspkind-nvim" })
  use({ "hrsh7th/nvim-cmp" })
  use({ "hrsh7th/cmp-nvim-lsp-signature-help" })
  use({ "hrsh7th/cmp-nvim-lua", ft = { "lua" } })
  use({ "hrsh7th/cmp-nvim-lsp" })
  use({ "folke/neodev.nvim" })
  use({ "hrsh7th/cmp-buffer" })
  use({ "hrsh7th/cmp-path" })
  use({ "nvim-lua/plenary.nvim" })
  use({ "rebelot/kanagawa.nvim" }) -- In colors.lua file
  use({ "quangnguyen30192/cmp-nvim-ultisnips", config = custom(nil, "plugins.ultisnips") })
  use({ "Olical/conjure", config = custom(nil, "plugins.conjure") })
  use({ "lukas-reineke/lsp-format.nvim" })
  use({
    "nvim-telescope/telescope.nvim",
    requires = { "nvim-lua/plenary.nvim", "junegunn/fzf" },
    config = custom("telescope", "plugins.telescope"),
  })
  use({ "nvim-telescope/telescope-file-browser.nvim", requires = "nvim-telescope/telescope.nvim" })
  use({
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
    requires = "nvim-telescope/telescope.nvim"
  })
  use({ "junegunn/fzf", run = function() vim.fn["fzf#install"]() end })
  use({ "kevinhwang91/nvim-bqf", requires = "junegunn/fzf.vim", config = custom("bqf", "plugins.bqf") })
  use({ "tpope/vim-dispatch" })
  use({ "tpope/vim-repeat" })
  use({ "tpope/vim-surround" })
  use({ "tpope/vim-unimpaired" })
  use({ "tpope/vim-rhubarb" })
  use({ "tpope/vim-eunuch" })
  use({ "tpope/vim-obsession" })
  use({ "tpope/vim-sexp-mappings-for-regular-people", ft = { "clojure" } })
  use({ "guns/vim-sexp", ft = { "clojure" } })
  use({ "numToStr/Comment.nvim", config = default("Comment") })
  use({ "numToStr/FTerm.nvim", config = custom("FTerm", "plugins.fterm") })
  use({ "romainl/vim-cool" })
  use({ "SirVer/ultisnips" })
  use({ "tpope/vim-fugitive", config = custom(nil, "plugins.fugitive") })
  use({ "windwp/nvim-autopairs", config = custom("nvim-autopairs", "plugins.autopairs") })
  use({
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
    config = custom("lualine", "plugins.lualine"),
  })
  use({
    "alvarosevilla95/luatab.nvim",
    config = custom("plugins/luatab", "luatab"),
    requires = "kyazdani42/nvim-web-devicons",
  })
  use({
    "lewis6991/gitsigns.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = custom("gitsigns", "plugins.gitsigns"),
  })
  use({ "gelguy/wilder.nvim", config = custom("wilder", "plugins.wilder") })
  use({
    "nvim-treesitter/nvim-treesitter",
    config = custom("plugins.treesitter", "nvim-treesitter"),
  })
  use({ "p00f/nvim-ts-rainbow", requires = "nvim-treesitter/nvim-treesitter" })
  use("andymass/vim-matchup")
  use({
    "nvim-treesitter/nvim-treesitter-context",
    requires = "nvim-treesitter/nvim-treesitter",
    confg = custom("treesitter-context", "plugins.treesitter-context"),
  })
  use({ "kyazdani42/nvim-web-devicons", default("nvim-web-devicons") })
  use({
    "sindrets/diffview.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = custom("diffview", "plugins.diffview"),
  })
  use({ "petertriho/nvim-scrollbar", config = custom("scrollbar", "plugins.scrollbar") })
  use({ "harrisoncramer/jump-tag", config = custom("jump-tag", "plugins.jump-tag") })
  use({ "lambdalisue/glyph-palette.vim" })
  use({ "posva/vim-vue", ft = { "vue" } })
  use({ "AndrewRadev/tagalong.vim" })
  use({ "windwp/nvim-ts-autotag" })
  use({ "rcarriga/nvim-notify", config = custom("notify", "plugins.notify") })
  use({ "AckslD/messages.nvim", config = custom("messages", "plugins.messages") })
  use({ 'djoshea/vim-autoread' })
  use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" }, config = custom("dap", "plugins.dap") }) -- Visual Studio Code Debugger Requires Special Installation
  use({ "mxsdev/nvim-dap-vscode-js", requires = { "mfussenegger/nvim-dap" } })
  use({
    "nvim-neotest/neotest",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "marilari88/neotest-vitest",
      "nvim-neotest/neotest-go",
    },
    custom("neotest", "plugins.neotest")
  })
  use({ 'ggandor/leap.nvim', custom("leap", "plugins.leap") })
end)
