# Neovim Configuration

![The editor with tmux enabled](/screenshot.png?raw=true)

# Quickstart

1. `git clone https://github.com/harrisoncramer/neovim-settings.git ~/.config/nvim`
2. `:PackerSync`

You will see errors on initial startup–this is to be expected, because we don't have the plugins installed yet. You may need to run PackerSync a couple of times.

# About

This repository contains my configurations, including key mappings, plugins, and other settings for Neovim. I'm primarily working day-to-day with Javascript, Typescript, React, Vue, Clojure, and Lua.

# Features

- Native LSP w/ <a href="https://github.com/nvim-treesitter/nvim-treesitter">treesitter</a>
- LSPs via <a href="https://github.com/williamboman/nvim-lsp-installer">lsp-installer</a> and configured w/ <a href="https://github.com/neovim/nvim-lspconfig">lspconfig</a>
- <a href="https://github.com/numToStr/FTerm.nvim">fterm</a> for terminal integration
- <a href="https://github.com/nvim-telescope/telescope.nvim/issues">telescope</a>
- <a href="https://github.com/sindrets/diffview.nvim">diffview</a> integrated w/ telescope for git history/diffs
- <a href="https://github.com/samoshkin/vim-mergetool">vim-mergetool</a> for merges
- Tim Pope's <a href="https://github.com/tpope/vim-fugitive">fugitive</a> for commits (and his other plugins)
- <a href="https://github.com/akinsho/bufferline.nvim">bufferline</a> for buffer views
- <a href="https://github.com/nvim-lualine/lualine.nvim">lualine</a>
- <a href="https://github.com/fsouza/prettierd">prettierd</a> and <a href="https://github.com/mantoni/eslint_d.js">eslintd</a>for formatting, via npm
- <a href="https://github.com/ellisonleao/gruvbox.nvim">gruvbox</a> colors scheme

# Dependencies

1. <a href="https://github.com/BurntSushi/ripgrep">ripgrep</a>
2. <a href="https://github.com/junegunn/fzf">fzf</a>
3. <a href="https://github.com/neovim/pynvim">pynvim</a>
4. Node (I'd recommend using <a href="https://github.com/Schniz/fnm">fnm</a>)
5. The <a href="https://github.com/johnsoncodehk/volar">volar</a> language server uses a global installation of Typescript, rather than a local one. This is to allow Volar to work with vanilla Javascript/Vue files. During startup, pass an environment variable telling the LSP where to look for the language server. For instance, inside my `.zshrc`, I have the following:

```
function v() {
  TS_SERVER='/Users/harrisoncramer/.fnm/node-versions/v16.13.0/installation/lib/node_modules/typescript/lib/tsserverlibrary.js' nvim
}
```
