return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		local sources = {
			null_ls.builtins.formatting.stylua.with({
				extra_args = { "--indent-width", "2", "--indent-type", "Spaces" },
			}),
			null_ls.builtins.diagnostics.eslint_d,
			null_ls.builtins.formatting.prettierd.with({ extra_args = { "--tab-width", "2" } }),
		}
		null_ls.setup({ sources = sources })

		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
