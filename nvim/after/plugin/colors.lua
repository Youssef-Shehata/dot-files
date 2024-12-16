function rose(color)
    color = color or "rose-pine"
    vim.cmd.colorscheme(color)
end

--rose()

function tokio()
    vim.cmd.colorscheme 'tokyonight-night'

    -- You can configure highlights by doing something like:
    vim.cmd.hi 'Comment gui=none'
    vim.api.nvim_set_hl(0, 'CursorLine', { bg = '#000033' })
    -- Set a specific highlight group color
    vim.api.nvim_set_hl(0, 'Visual', { bg = '#000000' })  -- Example for 'Visual' mode

    -- Example for changing color of 'Search' highlighting
    vim.api.nvim_set_hl(0, 'Search', { bg = '#075122' })
end

tokio()
