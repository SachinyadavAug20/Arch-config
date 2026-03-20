return {
  "Exafunction/codeium.nvim",
  event = "InsertEnter",
  config = function()
    require("codeium").setup({
      enable_chat = false,
      enable_cmp_source = false, -- you already use nvim-cmp
    })
  end,
}

