local function on_attach(client, bufnr)
    if client.server_capabilities.documentHighlightProvider then
        local group = vim.api.nvim_create_augroup("LspDocumentHighlight_" .. bufnr, { clear = true })
        vim.api.nvim_create_autocmd("CursorHold", {
            group = group,
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd("CursorMoved", {
            group = group,
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
        })
    end

    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
    vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr })
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr })
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr })
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr })
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config.lua_ls = {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        if client.name == "lua_ls" then
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
        end
        on_attach(client, bufnr)
    end,
}

vim.lsp.config.tailwindcss = {
    capabilities = capabilities,
    on_attach = on_attach,
}

vim.lsp.config.ts_ls = {
    capabilities = capabilities,
    on_attach = on_attach,
}

vim.lsp.config.clangd = {
    capabilities = capabilities,
    on_attach = on_attach,
}

vim.lsp.config.html = {
    capabilities = capabilities,
    on_attach = on_attach,
}

vim.lsp.config.pyright = {
    capabilities = capabilities,
    on_attach = on_attach,
}

vim.lsp.config.cssls = {
    capabilities = capabilities,
    on_attach = on_attach,
}

return {
    on_attach = on_attach,

    {
        "williamboman/mason.nvim",
        cmd = { "Mason", "MasonInstall", "MasonUpdate", "MasonLog" },
    },

    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        cmd = { "LspInfo", "LspInstall", "LspUninstall" },
    },

    {
        "neovim/nvim-lspconfig",
        dependencies = { "williamboman/mason-lspconfig.nvim" },
    },
}
