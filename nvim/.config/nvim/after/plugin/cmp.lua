local cmp = require("cmp")

cmp.setup({
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(),            -- Manually trigger completion
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirm suggestion
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" }, -- <-- this enables LSP completions (dot completions)
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
    }),
    completion = {
        completeopt = "menu,menuone,noinsert",
    },
    experimental = {
        ghost_text = true, -- shows inline preview of completion
    },
})
