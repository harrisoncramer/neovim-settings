vim.cmd([[ :hi NonText guifg=bg ]])

local kanagawa_ok, kanagawa = pcall(require, "kanagawa")
if not kanagawa_ok then
  print("Kanagawa is not installed.")
  return
end

kanagawa.setup({
  undercurl = true, -- enable undercurls
  commentStyle = {
    italic = true,
  },
  functionStyle = {},
  keywordStyle = {
    italic = true,
  },
  statementStyle = {},
  typeStyle = {},
  variablebuiltinStyle = {
    italic = true,
  },
  specialReturn = true, -- special highlight for the return keyword
  specialException = true, -- special highlight for exception handling keywords
  transparent = false, -- do not set background color
  colors = {},
  overrides = {},
})

vim.cmd('colorscheme kanagawa')

-- Custom overrides of treesitter capture groups (:TSHighlightCapturesUnderCursor) for Kanagawa theme
vim.api.nvim_set_hl(0, "@tag", { fg = "#A3D4D5" })
vim.api.nvim_set_hl(0, "@tag.delimiter", { fg = "#A3D4D5" })
vim.api.nvim_set_hl(0, "@tag.attribute", { fg = "#D27E99" })

return {
  sumiInk3      = "#363646",
  sumiInk4      = "#54546D",
  waveBlue1     = "#223249",
  waveBlue2     = "#2D4F67",
  winterGreen   = "#2B3328",
  winterYellow  = "#49443C",
  winterRed     = "#43242B",
  winterBlue    = "#252535",
  autumnGreen   = "#76946A",
  autumnRed     = "#C34043",
  autumnYellow  = "#DCA561",
  samuraiRed    = "#E82424",
  roninYellow   = "#FF9E3B",
  waveAqua1     = "#6A9589",
  dragonBlue    = "#658594",
  fujiGray      = "#727169",
  springViolet1 = "#938AA9",
  oniViolet     = "#957FB8",
  crystalBlue   = "#7E9CD8",
  springViolet2 = "#9CABCA",
  springBlue    = "#7FB4CA",
  lightBlue     = "#A3D4D5",
  waveAqua2     = "#7AA89F",
  springGreen   = "#98BB6C",
  boatYellow1   = "#938056",
  boatYellow2   = "#C0A36E",
  carpYellow    = "#E6C384",
  sakuraPink    = "#D27E99",
  waveRed       = "#E46876",
  peachRed      = "#FF5D62",
  surimiOrange  = "#FFA066",
}
