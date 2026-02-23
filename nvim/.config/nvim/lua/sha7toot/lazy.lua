vim.g.mapleader = " "
vim.g.maplocalleader = " "
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { "wbthomason/packer.nvim" },
    {
        "nvim-telescope/telescope.nvim",
        lazy = false,
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },
        },
        config = function()
            local telescope = require("telescope")
            local telescopeConfig = require("telescope.config")

            local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

            table.insert(vimgrep_arguments, "--hidden")
            table.insert(vimgrep_arguments, "--glob")
            table.insert(vimgrep_arguments, "!**/.git/*")
            table.insert(vimgrep_arguments, "--glob")
            table.insert(vimgrep_arguments, "!node_modules/**")
            telescope.setup({
                defaults = {
                    vimgrep_arguments = vimgrep_arguments,
                    sorting_strategy = "descending",
                    borderchars = {
                        prompt = { "─", "│", "_", "│", "╭", "╮", "│", "│" },
                        results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
                        preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
                    },
                    path_displays = "smart",
                    layout_strategy = "horizontal",
                    layout_config = {
                        horizontal = {
                            preview_width = 0.6,
                        },
                        height = 100,
                        width = 400,
                        preview_cutoff = 40,
                    },
                },
                pickers = {
                    find_files = {
                        hidden = true,
                        find_command = {
                            "rg",
                            "--files",
                            "--hidden",
                            "--glob",
                            "!**/.git/*",
                            "--glob",
                            "!node_modules/**",
                        },
                    },
                },
                extensions = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case",
                    },
                },
            })

            pcall(telescope.load_extension, "fzf")

            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<C-p>", builtin.git_files, {})
            vim.keymap.set("n", "<leader>tr", builtin.treesitter, {})
            vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Telescope live grep" })
            vim.keymap.set("n", "<leader>g", builtin.live_grep, { desc = "Telescope live grep" })
            vim.keymap.set("n", "<leader>si", builtin.grep_string, { desc = "Telescope live string" })
            vim.keymap.set("n", "<leader>so", builtin.oldfiles, { desc = "Telescope buffers" })
            vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "Telescope buffers" })
            vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "Telescope help tags" })
            vim.keymap.set("n", "<leader>sm", builtin.man_pages, { desc = "Telescope man pages" })
            vim.keymap.set("n", "<leader>sr", builtin.lsp_references, { desc = "Telescope tags" })
            vim.keymap.set("n", "<leader>st", builtin.builtin, { desc = "Telescope tags" })
            vim.keymap.set("n", "<leader>s", builtin.git_status, { desc = "Telescope tags" })
            vim.keymap.set("n", "<leader>sd", builtin.registers, { desc = "Telescope tags" })
            vim.keymap.set("n", "<leader>sc", builtin.colorscheme, { desc = "Telescope tags" })
            vim.keymap.set("n", "<leader>se", "<cmd>Telescope env<cr>", { desc = "Telescope tags" })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.config").setup({
                ensure_installed = {
                    "javascript",
                    "typescript",
                    "go",
                    "rust",
                    "c",
                    "lua",
                    "vim",
                    "vimdoc",
                    "query",
                    "markdown",
                    "markdown_inline",
                    "hurl",
                },
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    disable = { "yaml" },
                    additional_vim_regex_highlighting = false,
                },
            })
        end,
    },
    {
        "theprimeagen/harpoon",
        lazy = false,
        config = function()
            vim.keymap.set("n", "<leader>a", function() require("harpoon.mark").add_file() end)
            vim.keymap.set("n", "<C-e>", function() require("harpoon.ui").toggle_quick_menu() end)
            vim.keymap.set("n", "<C-h>", function() require("harpoon.ui").nav_file(1) end)
            vim.keymap.set("n", "<C-j>", function() require("harpoon.ui").nav_file(2) end)
            vim.keymap.set("n", "<C-k>", function() require("harpoon.ui").nav_file(3) end)
            vim.keymap.set("n", "<C-l>", function() require("harpoon.ui").nav_file(4) end)
        end
    },
    { "mbbill/undotree",       lazy = false },
    {
        "laytan/cloak.nvim",
        lazy = false,
        config = function()
            require("cloak").setup({
                enabled = true,
                cloak_character = "•",
                highlight_group = "Comment",
                patterns = {
                    { file_pattern = ".*%.env.*", cloak_pattern = "=.+" },
                },
            })
        end,
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        config = function()
            require("tokyonight").setup({
                transparent = true,
                styles = {
                    sidebars = "transparent",
                    floats = "transparent",
                },
            })

            vim.cmd.colorscheme("tokyonight-night")

            vim.cmd([[
            highlight Normal guibg=NONE ctermbg=NONE
            highlight NormalNC guibg=NONE ctermbg=NONE
            highlight NormalFloat guibg=NONE ctermbg=NONE
            highlight EndOfBuffer guibg=NONE ctermbg=NONE
            ]])
            vim.cmd.hi("Comment gui=none")
            vim.api.nvim_set_hl(0, "Visual", { bg = "#000b1d" })
            vim.api.nvim_set_hl(0, "Search", { bg = "#075122" })
        end,
    },
    { "neovim/nvim-lspconfig",             lazy = false },
    {
        "hrsh7th/nvim-cmp",
        lazy = false,
        config = function()
            local cmp = require("cmp")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"] = cmp.mapping.select_next_item(),
                    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "path" },
                }),
                completion = {
                    completeopt = "menu,menuone,noinsert",
                },
                experimental = {
                    ghost_text = false,
                },
            })
        end,
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
        },
    },
    { "williamboman/mason.nvim",           cmd = "Mason" },
    { "williamboman/mason-lspconfig.nvim", lazy = false },
    {
        "lewis6991/gitsigns.nvim",
        lazy = false,
        config = function()
            require("gitsigns").setup({
                signs = {
                    add = { text = "┃" },
                    change = { text = "┃" },
                    delete = { text = "" },
                    topdelete = { text = "‾" },
                    changedelete = { text = "~" },
                    untracked = { text = "┆" },
                },
                signcolumn = true,
            })
        end,
    },
    {
        "stevearc/conform.nvim",
        lazy = false,
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    javascript = { "prettierd", "prettier" },
                    javascriptreact = { "prettierd", "prettier" },
                    typescript = { "prettierd", "prettier" },
                    typescriptreact = { "prettierd", "prettier" },
                    json = { "prettierd", "prettier" },
                    markdown = { "prettierd", "prettier" },
                    yaml = { "prettierd", "prettier" },
                    html = { "prettierd", "prettier" },
                    css = { "prettierd", "prettier" },
                    scss = { "prettierd", "prettier" },
                    lua = { "stylua" },
                },
                format_on_save = {
                    timeout_ms = 3000,
                    lsp_fallback = true,
                },
                formatters = {
                    prettierd = {
                        command = function()
                            local local_bin = "./node_modules/.bin/prettierd"
                            return vim.fn.filereadable(local_bin) == 1 and local_bin or "prettierd"
                        end,
                    },
                },
            })
        end,
    },
    -- { "tpope/vim-fugitive", cmd = "Git" },
})

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
