-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

local function set_transparency()
  vim.cmd([[
    hi Normal guibg=NONE ctermbg=NONE
    hi NormalNC guibg=NONE ctermbg=NONE
    hi SignColumn guibg=NONE ctermbg=NONE
    hi StatusLine guibg=NONE ctermbg=NONE
    hi StatusLineNC guibg=NONE ctermbg=NONE
    hi VertSplit guibg=NONE ctermbg=NONE
    hi TabLine guibg=NONE ctermbg=NONE
    hi TabLineFill guibg=NONE ctermbg=NONE
    hi TabLineSel guibg=NONE ctermbg=NONE
    hi Pmenu guibg=NONE ctermbg=NONE
    hi PmenuSel guibg=NONE ctermbg=NONE
    hi NeoTreeNormal guibg=NONE ctermbg=NONE
    hi NeoTreeNormalNC guibg=NONE ctermbg=NONE
    hi NeoTreeWinSeparator guibg=NONE ctermbg=NONE
    hi NeoTreeEndOfBuffer guibg=NONE ctermbg=NONE
    hi EndOfBuffer guibg=NONE ctermbg=NONE
  ]])
end

-- Apply once on startup
set_transparency()

-- Reapply Whenever you enter a buffer (to retain transparency)
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = set_transparency,
})
vim.filetype.add({
  pattern = {
    [".*/hypr/.*%.conf"] = "hyprlang",
  },
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "hyprlang",
  callback = function()
    vim.bo.shiftwidth = 4
    vim.bo.tabstop = 4
    vim.bo.expandtab = true
  end,
})
vim.cmd("filetype plugin indent on")

