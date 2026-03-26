return {
  "nvimtools/none-ls.nvim",
  event = { "VeryLazy" },
  config = function()
    local null_ls = require("null-ls")
    local sources = {
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.prettierd,
    }
    null_ls.setup({ sources = sources })

    vim.keymap.set("n", "<leader>gf", function()
      vim.lsp.buf.format({ async = true })
    end, { desc = "Format buffer" })
  end,
}
