return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls", -- Lua
					"clangd", -- C and C++
					"jdtls", -- Java
					"html", -- HTML
                    "ts_ls", -- JavaScript & TypeScript (Node.js / Next.js)
					"pyright", -- Python
					"tsserver",
                    "cssls",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			vim.lsp.config.lua_ls.setup({
				capabilities = capabilities,
			})
			vim.lsp.config.tsserver.setup({
				capabilities = capabilities,
			})
			vim.lsp.config.clangd.setup({
				capabilities = capabilities,
			})
			vim.lsp.config.jdtls.setup({
				capabilities = capabilities,
			})
			vim.lsp.config.html.setup({
				capabilities = capabilities,
			})
			vim.lsp.config.ts_ls.setup({
				capabilities = capabilities,
			})
			vim.lsp.config.pyright.setup({
				capabilities = capabilities,
			})
            vim.lsp.config.cssls.setup({
                capabilities = capabilities,
            })

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}
