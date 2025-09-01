local lsp_zero = require('lsp-zero')

-- Capabilities for completion
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Default on_attach from lsp-zero
lsp_zero.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr }

    vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
    })

    -- Standard LSP keymaps
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

    vim.api.nvim_create_autocmd('FileType',
        {
            pattern = 'qf',
            callback = function()
                vim.keymap.set('n', '<CR>', '<CR>:cclose<CR>', { buffer = true, silent = true })
                vim.keymap.set('n', '<2-LeftMouse>', '<2-LeftMouse>:cclose<CR>', { buffer = true, silent = true })
            end,
        })
end)

-- Mason Setup
require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {
        "rust_analyzer",
        "clangd",
        "lua_ls",
        "pyright",
    },
    handlers = {
        lsp_zero.default_setup,
    },
})

-- TypeScript Tools Setup (REPLACES tsserver)
require("typescript-tools").setup({
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        lsp_zero.on_attach(client, bufnr)

        -- Disable built-in formatting (Prettier handles it)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false

        local opts = { buffer = bufnr, noremap = true, silent = true }
        vim.keymap.set("n", "<leader>oi", ":TSToolsOrganizeImports<CR>", opts)
        vim.keymap.set("n", "<leader>ai", ":TSToolsAddMissingImports<CR>", opts)
        vim.keymap.set("n", "<leader>ru", ":TSToolsRemoveUnused<CR>", opts)
        vim.keymap.set("n", "<leader>rf", ":TSToolsRenameFile<CR>", opts)
    end,
    oot_dir = require("lspconfig.util").root_pattern("tsconfig.json", ".git"),
    single_file_support = true,

    -- Optimize performance
    settings = {
        publish_diagnostic_on = "insert_leave",
        complete_function_calls = false,
        separate_diagnostic_server = true,
        tsserver_file_preferences = {
            includeInlayParameterNameHints = "all",
            includeInlayVariableTypeHints = true,
            includeInlayFunctionParameterTypeHints = true,
        },
        tsserver_max_memory = 6144,
        tsserver_enable_imports_autocomplete = true,
        tsserver_experimental_enable_project_diagnostics = false,
    },
})

-- Lua LS Setup (Fix annoying diagnostics)
require("lspconfig").lua_ls.setup({
    capabilities = capabilities,
    settings = {
        Lua = {
            completion = { callSnippet = "Replace" },
            diagnostics = { globals = { "vim" } },
        },
    },
})

-- Rust Tools Setup
require('rust-tools').setup({
    server = {
        capabilities = capabilities,
        on_attach = lsp_zero.on_attach,
    }
})
