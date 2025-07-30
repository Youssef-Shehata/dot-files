vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
-- Move selected lines down in visual mode
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")

-- Move selected lines up in visual mode
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- Save the current file
vim.keymap.set('n', '<leader>i', ":w<CR>")

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')



-- dont move cursor when using J
vim.keymap.set("n", "J", "mzJ'z")
--keep cursor in the middle of the screen when ztrl u and d
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")


--keep cursor in the middle when navigating through searches
vim.keymap.set("n", "n", "nzzzv")
--move the highlighted word into the void and keep your yanked word in
vim.keymap.set("x", "<leader>p", "\"_dP")

vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")


vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

--quickfix nav
vim.keymap.set("n", "<M-j>", "<cmd>cnext<CR>")
vim.keymap.set("n", "<M-k>", "<cmd>cprev<CR>")

--sourcing
vim.keymap.set("n", "<leader>x", "<cmd>source %<CR>")
vim.keymap.set("v", "<leader>x", ":lua<CR>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<leader>f", function()
  vim.lsp.buf.format()
end)




--highlihgting when yankin
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = "highlight on yank",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.hurl",
  callback = function()
    vim.bo.filetype = "hurl"
  end,
})


vim.api.nvim_create_autocmd('TermOpen', {
  group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end,
})

--run tests
vim.keymap.set("n", "<leader>st", function()
  -- Save the current buffer number (original buffer)
  local original_buf = vim.api.nvim_get_current_buf()
  local original_filetype = vim.bo[original_buf].filetype

  -- Create a new vertical split and open a terminal
  vim.cmd.vnew()
  vim.cmd.term()

  -- Wait for the terminal to initialize (optional, but recommended)
  vim.defer_fn(function()
    -- Get the terminal buffer number and channel
    local term_buf = vim.api.nvim_get_current_buf()
    local term_channel = vim.b[term_buf].terminal

    -- Send the appropriate command based on the original buffer's filetype
    if original_filetype == "go" then
      vim.fn.chansend(vim.bo.channel, { "go test\r\n" })
    elseif original_filetype == "rust" then
      vim.fn.chansend(vim.bo.channel, { "cargo test\r\n" })
    else
      print("Unsupported filetype for running tests: " .. original_filetype)
    end
  end, 100) -- Delay of 100ms to ensure the terminal is ready

  -- Move the terminal window to the right
  vim.cmd.wincmd("L")
end)



--rust check
vim.keymap.set("n", "<leader>sc", function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd("L")
  vim.fn.chansend(vim.bo.channel, { "cargo check\r\n" })
end)

--run git status
vim.keymap.set("n", "<leader>sg", function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd("L")
  vim.fn.chansend(vim.bo.channel, { "git status\r\n" })
end)
