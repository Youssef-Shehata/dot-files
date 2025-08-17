--NEWSHIT
vim.opt.timeoutlen = 300
vim.opt.ttimeoutlen = 10





--NEWSHIT


vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.relativenumber = true


vim.opt.colorcolumn = "80"


vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4

vim.opt.smartindent = true
vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.nvim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50
--vim.opt.colorcolumn= "100"

vim.opt.showmode = false
--vim.opt.clipboard = 'unnamedplus'
vim.opt.breakindent = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.cursorline = false

vim.g.have_nerd_font = true
