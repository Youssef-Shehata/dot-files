vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8", -- ✅ Using a stable release
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				run = "make", -- ✅ Needed to compile fzf for better performance
			},
		},
		config = function()
			local telescope = require("telescope")

			telescope.setup({
				defaults = {
					file_ignore_patterns = { "node_modules", ".git" }, -- optional optimization
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
				extensions = {
					fzf = {
						fuzzy = true, -- enable fuzzy search
						override_generic_sorter = true, -- override default sorter
						override_file_sorter = true, -- faster file sorting
						case_mode = "smart_case", -- smart case sensitivity
					},
				},
			})

			-- ✅ Load the fzf extension
			pcall(telescope.load_extension, "fzf")
		end,
	})
	use("simrat39/rust-tools.nvim")
	use("nvim-treesitter/nvim-treesitter", { run = "TSUpdate" })
	use("theprimeagen/harpoon")
	use("mbbill/undotree")
	use({ "Orange-OpenSource/hurl", ft = "hurl" })
	use({
		"laytan/cloak.nvim",
		config = function()
			require("cloak").setup({
				enabled = true,
				cloak_character = "•",
				highlight_group = "Comment",
				patterns = {
					{ file_pattern = ".*%.env.*", cloak_pattern = "=.+" }, -- hide everything after =
				},
			})
		end,
	})

	use({
		"folke/tokyonight.nvim",
		config = function()
			require("tokyonight").setup({
				transparent = true,
				styles = {
					sidebars = "transparent",
					floats = "transparent",
				},
			})
		end,
	})
	use({
		"folke/ts-comments.nvim",
		config = function()
			require("ts-comments").setup()
		end,
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	})
	use({ "VonHeikemen/lsp-zero.nvim", branch = "v4.x" })
	use({ "neovim/nvim-lspconfig" })
	use({ "hrsh7th/nvim-cmp" })
	use({ "hrsh7th/cmp-nvim-lsp" })
	use({ "williamboman/mason.nvim" })
	use({ "williamboman/mason-lspconfig.nvim" })

	use({ "hrsh7th/cmp-buffer" })
	use({ "hrsh7th/cmp-path" })
	use({ "hrsh7th/cmp-cmdline" })
	use({ "L3MON4D3/LuaSnip" })
	use({ "saadparwaiz1/cmp_luasnip" })
	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "┃" }, -- default: '│'
					change = { text = "┃" }, -- default: '│'
					delete = { text = "" }, -- default: '_'
					topdelete = { text = "‾" }, -- default: '‾'
					changedelete = { text = "~" }, -- default: '~'
					untracked = { text = "┆" }, -- optional
				},
				signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
			})
		end,
	})

	use({
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		config = function()
			require("typescript-tools").setup({})
		end,
	})
	use({
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup({})
		end,
	})

	use({
		"supermaven-inc/supermaven-nvim",
		config = function()
			require("supermaven-nvim").setup({
				keymaps = {
					accept_suggestion = "<TAB>",
					clear_suggestion = "<C-c>",
					accept_word = "<C-b>",
				},
				ignore_filetypes = { cpp = true }, -- or { "cpp", }
				color = {
					suggestion_color = "#accccc",
					cterm = 244,
				},
				log_level = "info", -- set to "off" to disable logging completely
				disable_inline_completion = true, -- disables inline completion for use with cmp
				disable_keymaps = true, -- disables built in keymaps for more manual control
				condition = function()
					return false
				end, -- condition to check for stopping supermaven, `true` means to stop supermaven when the condition is true.
			})
		end,
	})
end)
