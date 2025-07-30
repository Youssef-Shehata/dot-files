function rose(color)
  color = color or "rose-pine"
  vim.cmd.colorscheme(color)
end

--rose()

function tokio()
  vim.cmd.colorscheme 'tokyonight-night'

  vim.cmd([[
  highlight Normal guibg=NONE ctermbg=NONE
  highlight NormalNC guibg=NONE ctermbg=NONE
  highlight NormalFloat guibg=NONE ctermbg=NONE
  highlight EndOfBuffer guibg=NONE ctermbg=NONE
]])
  -- You can configure highlights by doing something like:
  vim.cmd.hi 'Comment gui=none'
  -- Set a specific highlight group color
  vim.api.nvim_set_hl(0, 'Visual', { bg = '#000b1d' }) -- Example for 'Visual' mode

  -- Example for changing color of 'Search' highlighting
  vim.api.nvim_set_hl(0, 'Search', { bg = '#075122' })
end

tokio()
