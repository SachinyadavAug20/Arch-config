return {
  "pocco81/auto-save.nvim",
  event = { "InsertLeave", "TextChanged" },
  config = function()
    require("auto-save").setup({
      enabled = true,
      execution_message = {
        message = function()
          return ("AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"))
        end,
      },
      trigger_events = { "InsertLeave" },
      condition = function(buf)
        local fn = vim.fn
        local utils = require("auto-save.utils.data")
        if fn.getbufvar(buf, "&modifiable") == 1 and
           utils.not_in(fn.expand('%:t'), { "README.md" }) then
          return true
        end
        return false
      end,
      write_all_buffers = false,
      debounce_delay = 500,
    })
  end
}
