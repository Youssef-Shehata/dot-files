local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})

local function on_attach(client, bufnr)
    local opts = { buffer = bufnr }

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

    vim.api.nvim_create_autocmd("FileType", {
        pattern = "qf",
        callback = function()
            vim.keymap.set("n", "<CR>", "<CR>:cclose<CR>", { buffer = true, silent = true })
            vim.keymap.set("n", "<2-LeftMouse>", "<2-LeftMouse>:cclose<CR>", { buffer = true, silent = true })
        end,
    })
end

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "rust_analyzer",
        "clangd",
        "lua_ls",
        "pyright",
        "ts_ls",
        "prismals",
    },
    handlers = {
        ["lua_ls"] = function()
            vim.lsp.start({
                name = "lua_ls",
                cmd = { "lua-language-server" },
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                    Lua = {
                        completion = { callSnippet = "Replace" },
                        diagnostics = { globals = { "vim" } },
                        hint = { enable = true },
                        telemetry = { enable = false },
                        workspace = {
                            checkThirdParty = false,
                            library = vim.api.nvim_get_runtime_file("", true),
                        },
                    },
                },
            })
        end,
        ["ts_ls"] = function()
            vim.lsp.start({
                name = "ts_ls",
                cmd = { vim.fn.exepath("ts_ls"), "--stdio" },
                capabilities = capabilities,
                on_attach = function(client, bufnr)
                    on_attach(client, bufnr)
                    client.server_capabilities.documentFormattingProvider = false
                    client.server_capabilities.documentRangeFormattingProvider = false
                    local opts = { buffer = bufnr, noremap = true, silent = true }
                    vim.keymap.set("n", "<leader>oi", ":OrganizeImports<CR>", opts)
                    vim.keymap.set("n", "<leader>ai", ":AddMissingImports<CR>", opts)
                    vim.keymap.set("n", "<leader>ru", ":RemoveUnused<CR>", opts)
                end,
                root_dir = function(fname)
                    return vim.fs.root(fname, { "tsconfig.json", "package.json", ".git" })
                end,
                settings = {
                    typescript = {
                        inlayHints = {
                            includeInlayParameterNameHints = "none",
                            includeInlayVariableTypeHints = false,
                            includeInlayFunctionParameterTypeHints = false,
                        },
                    },
                    javascript = {
                        inlayHints = {
                            includeInlayParameterNameHints = "none",
                            includeInlayVariableTypeHints = false,
                            includeInlayFunctionParameterTypeHints = false,
                        },
                    },
                },
            })
        end,
        ["prismals"] = function()
            vim.lsp.start({
                name = "prismals",
                cmd = { "prisma-language-server", "--stdio" },
                capabilities = capabilities,
                on_attach = on_attach,
            })
        end,
    },
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        on_attach(client, args.buf)
    end,
})
