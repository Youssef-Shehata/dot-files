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

	-- Enable format-on-save
	format_on_save = {
		timeout_ms = 3000,
		lsp_fallback = true,
	},

	-- Customize how prettierd is resolved
	formatters = {
		prettierd = {
			command = function()
				-- Prefer local prettierd if available
				local local_bin = "./node_modules/.bin/prettierd"
				return vim.fn.filereadable(local_bin) == 1 and local_bin or "prettierd"
			end,
		},
	},
})
