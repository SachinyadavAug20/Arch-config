-- =========================================================
-- 1. DOCUMENT HIGHLIGHT FUNCTION
-- =========================================================
local function on_attach(client, bufnr)
    if client.server_capabilities.documentHighlightProvider then
        local group = vim.api.nvim_create_augroup("LspDocumentHighlight_" .. bufnr, { clear = true })

        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            group = group,
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.document_highlight()
            end,
        })

        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            group = group,
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.clear_references()
            end,
        })
    end
end

-- =========================================================
-- 2. RETURN PLUGIN TABLE
-- =========================================================
return {

    on_attach = on_attach,

    -- Mason
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },

    -- Mason LSP bridge
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "clangd",
                    "jdtls",
                    "html",
                    "ts_ls",       -- UPDATED
                    "pyright",
                    "cssls",
                    "tailwindcss",
                },
            })
        end,
    },

    -- Neovim LSP
    {
        "neovim/nvim-lspconfig",
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            ----------------------------------------------------------
            -- LUA
            ----------------------------------------------------------
            vim.lsp.config.lua_ls.setup({
                capabilities = capabilities,
                on_attach = function(client, bufnr)
                    if client.name == "lua_ls" then
                        client.server_capabilities.documentFormattingProvider = false
                        client.server_capabilities.documentRangeFormattingProvider = false
                    end
                    on_attach(client, bufnr)
                end,
            })

            ----------------------------------------------------------
            -- TAILWINDCSS
            ----------------------------------------------------------
            vim.lsp.config.tailwindcss.setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })

            ----------------------------------------------------------
            -- TYPESCRIPT (new name: ts_ls)
            ----------------------------------------------------------
            vim.lsp.config.ts_ls.setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })

            ----------------------------------------------------------
            -- OTHER SERVERS
            ----------------------------------------------------------
            vim.lsp.config.clangd.setup({ capabilities = capabilities, on_attach = on_attach })
            vim.lsp.config.jdtls.setup({ capabilities = capabilities, on_attach = on_attach })
            vim.lsp.config.html.setup({ capabilities = capabilities, on_attach = on_attach })
            vim.lsp.config.pyright.setup({ capabilities = capabilities, on_attach = on_attach })
            vim.lsp.config.cssls.setup({ capabilities = capabilities, on_attach = on_attach })

            ----------------------------------------------------------
            -- GENERAL LSP KEYMAPS
            ----------------------------------------------------------
            vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
            vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
            vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
        end,
    },
}

