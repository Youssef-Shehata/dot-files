vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.timeoutlen = 300
vim.opt.ttimeoutlen = 10
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
vim.opt.showmode = false
vim.opt.breakindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.cursorline = false
vim.g.have_nerd_font = true
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<leader>i", ":w<CR>")
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "J", "mzJ'z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("x", "<leader>p", '"_dP')
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')
vim.keymap.set("n", "<leader>d", '"_d')
vim.keymap.set("v", "<leader>d", '"_d')
vim.keymap.set("n", "<M-j>", "<cmd>cnext<CR>")
vim.keymap.set("n", "<M-k>", "<cmd>cprev<CR>")
vim.keymap.set("n", "<leader>x", "<cmd>source %<CR>")
vim.keymap.set("v", "<leader>x", ":lua<CR>")
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format()
end)
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "highlight on yank",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})
-- LAZY
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob=none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)


require("lazy").setup({
    spec = {
        {
            "nvim-telescope/telescope.nvim",
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
            branch = "master",
            build = ":TSUpdate",
            lazy = false,
            config = function()
                require("nvim-treesitter.configs").setup({
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
                    highlight = {
                        enable = true,
                    },
                })
            end,
        },
        {
            "theprimeagen/harpoon",
            config = function()
                vim.keymap.set("n", "<leader>a", function() require("harpoon.mark").add_file() end)
                vim.keymap.set("n", "<C-e>", function() require("harpoon.ui").toggle_quick_menu() end)
                vim.keymap.set("n", "<C-h>", function() require("harpoon.ui").nav_file(1) end)
                vim.keymap.set("n", "<C-j>", function() require("harpoon.ui").nav_file(2) end)
                vim.keymap.set("n", "<C-k>", function() require("harpoon.ui").nav_file(3) end)
                vim.keymap.set("n", "<C-l>", function() require("harpoon.ui").nav_file(4) end)
            end
        },
        { "mbbill/undotree" },
        {
            "laytan/cloak.nvim",
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
        { "neovim/nvim-lspconfig" },
        {
            "hrsh7th/nvim-cmp",
            dependencies = {
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
                "hrsh7th/cmp-cmdline",
                "L3MON4D3/LuaSnip",
                "saadparwaiz1/cmp_luasnip",
            },
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
        },
        { "williamboman/mason.nvim",          cmd = "Mason" },
        { "williamboman/mason-lspconfig.nvim" },
        {
            "lewis6991/gitsigns.nvim",
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
        {
            "pmizio/typescript-tools.nvim",
            -- capabilities = capabilities,
            dependencies = {
                "nvim-lua/plenary.nvim",
                "neovim/nvim-lspconfig",
                "hrsh7th/cmp-nvim-lsp", -- IMPORTANT
            },
            config = function()
                local capabilities = require("cmp_nvim_lsp").default_capabilities()
                require("typescript-tools").setup({
                    on_attach = function(client, bufnr)
                        local opts = { buffer = bufnr }

                        vim.diagnostic.config({
                            virtual_text = true,
                            signs = true,
                            underline = true,
                            update_in_insert = false,
                            severity_sort = true,
                        })

                        -- Standard keymaps
                        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
                        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
                        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

                        client.server_capabilities.semanticTokensProvider = nil
                        -- Disable ts formatting (since you use Prettier)
                        client.server_capabilities.documentFormattingProvider = false
                        client.server_capabilities.documentRangeFormattingProvider = false

                        local opts = { buffer = bufnr, silent = true }
                        vim.keymap.set("n", "<leader>oi", ":TSToolsOrganizeImports<CR>", opts)
                        vim.keymap.set("n", "<leader>ai", ":TSToolsAddMissingImports<CR>", opts)
                        vim.keymap.set("n", "<leader>ru", ":TSToolsRemoveUnused<CR>", opts)
                        vim.keymap.set("n", "<leader>rf", ":TSToolsRenameFile<CR>", opts)
                    end,


                    single_file_support = false,
                    capabilities = capabilities,
                    settings = {
                        -- spawn additional tsserver instance to calculate diagnostics on it
                        separate_diagnostic_server = true,
                        -- "change"|"insert_leave" determine when the client asks the server about diagnostic
                        publish_diagnostic_on = "insert_leave",
                        -- array of strings("fix_all"|"add_missing_imports"|"remove_unused"|
                        -- "remove_unused_imports"|"organize_imports") -- or string "all"
                        -- to include all supported code actions
                        -- specify commands exposed as code_actions
                        -- string|nil - specify a custom path to `tsserver.js` file, if this is nil or file under path
                        -- not exists then standard path resolution strategy is applied
                        tsserver_path = nil,
                        -- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
                        -- (see 💅 `styled-components` support section)
                        tsserver_plugins = {},
                        expose_as_code_action = "all",
                        -- this value is passed to: https://nodejs.org/api/cli.html#--max-old-space-sizesize-in-megabytes
                        -- memory limit in megabytes or "auto"(basically no limit)
                        tsserver_max_memory = "auto",
                        -- described below
                        tsserver_file_preferences = {},
                        -- locale of all tsserver messages, supported locales you can find here:
                        -- https://github.com/microsoft/TypeScript/blob/3c221fc086be52b19801f6e8d82596d04607ede6/src/compiler/utilitiesPublic.ts#L620
                        tsserver_locale = "en",
                        tsserver_format_options = nil,
                        -- mirror of VSCode's `typescript.suggest.completeFunctionCalls`
                        complete_function_calls = false,
                        include_completions_with_insert_text = true,
                        -- CodeLens
                        -- WARNING: Experimental feature also in VSCode, because it might hit performance of server.
                        -- possible values: ("off"|"all"|"implementations_only"|"references_only")
                        code_lens = "off",
                        -- by default code lenses are displayed on all referencable values and for some of you it can
                        -- be too much this option reduce count of them by removing member references from lenses
                        disable_member_code_lens = true,
                        -- JSXCloseTag
                        -- WARNING: it is disabled by default (maybe you configuration or distro already uses nvim-ts-autotag,
                        -- that maybe have a conflict if enable this feature. )
                        jsx_close_tag = {
                            enable = false,
                            filetypes = { "javascriptreact", "typescriptreact" },
                        }
                    },
                })
            end,
        }
    }
})

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
