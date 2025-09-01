local null_ls = require("null-ls")

-- Create a dedicated augroup for formatting (prevents duplicate autocmds)
local format_group = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
    sources = {
        -- Prettier for formatting
        null_ls.builtins.formatting.prettierd.with({
            prefer_local = "node_modules/.bin",
        }),
    },

    on_attach = function(client, bufnr)
        -- Use the new API for checking formatting support
        if client.server_capabilities.documentFormattingProvider then
            vim.api.nvim_clear_autocmds({ group = format_group, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = format_group,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({
                        bufnr = bufnr,
                        filter = function(c)
                            return c.name == "null-ls" -- Force Prettier
                        end,
                    })
                end,
            })
        end
    end,
})

