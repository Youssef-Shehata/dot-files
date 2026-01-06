local telescope = require("telescope")
local telescopeConfig = require("telescope.config")

local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

-- I want to search in hidden/dot files.
table.insert(vimgrep_arguments, "--hidden")
-- I don't want to search in the `.git` directory.
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!**/.git/*")
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!node_modules/**")
telescope.setup({
	defaults = {
		-- `hidden = true` is not supported in text grep commands.
		vimgrep_arguments = vimgrep_arguments,
	},
	pickers = {
		-- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
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
})

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<C-p>", builtin.git_files, {})
-- vim.keymap.set('n', '<leader>ps', function()
--     builtin.grep_string({ search = vim.fn.input("Grep > ") });
-- end)
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
--vim.keymap.set("n", "<leader>sa", require("actions-preview").code_actions)
