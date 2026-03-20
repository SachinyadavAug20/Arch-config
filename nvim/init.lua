vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        vim.o.updatetime = 300
    end,
})

-- Bootstrap lazy.nvim
-- Disable arrow keys in all modes
local opts = { noremap = true, silent = true }

vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")
vim.keymap.set({'n', 'i', 'v'}, '<Up>', '<Nop>', opts)
vim.keymap.set({'n', 'i', 'v'}, '<Down>', '<Nop>', opts)
vim.keymap.set({'n', 'i', 'v'}, '<Left>', '<Nop>', opts)
vim.keymap.set({'n', 'i', 'v'}, '<Right>', '<Nop>', opts)


vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
        vim.api.nvim_set_hl(0, "LspReferenceText",  { bg = "#3b4252" })
        vim.api.nvim_set_hl(0, "LspReferenceRead",  { bg = "#3b4252" })
        vim.api.nvim_set_hl(0, "LspReferenceWrite", { bg = "#3b4252" })
    end,
})
vim.g.mapleader = " "   -- makes <leader> = Space

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

local opts ={}

require("lazy").setup("plugins")
local builtin = require("telescope.builtin")

vim.keymap.set('n','<C-p>', builtin.find_files, {})
vim.keymap.set('n','<C-g>', builtin.live_grep, {})
vim.keymap.set('n','<C-f>',':Neotree filesystem reveal left<CR>',{})
-- Open new tab
vim.keymap.set('n', '<leader>tn', ':tabnew<CR>', { desc = 'New Tab' })

-- Close current tab
vim.keymap.set('n', '<leader>tc', ':tabclose<CR>', { desc = 'Close Tab' })

-- Move to next / previous tab
vim.keymap.set('n', '<leader>tl', ':tabnext<CR>', { desc = 'Next Tab' })
vim.keymap.set('n', '<leader>th', ':tabprevious<CR>', { desc = 'Previous Tab' })

-- Switch tabs with Ctrl+Tab and Ctrl+Shift+Tab
vim.keymap.set('n', '<C-Tab>', ':tabnext<CR>', { silent = true })
vim.keymap.set('n', '<C-S-Tab>', ':tabprevious<CR>', { silent = true })

require("catppuccin").setup()

vim.cmd.colorscheme "catppuccin"


vim.diagnostic.config({
    virtual_text = true,  -- shows error/warning inline
    signs = true,         -- shows symbols in the gutter
    underline = true,     -- underlines the code with errors
    update_in_insert = true,  -- show diagnostics even while typing
    severity_sort = true,
})

-- Optional: show floating window on cursor hover
vim.cmd([[
  autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focus = false })
]])

-- Remember cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end
})

-- show line numbers
vim.wo.number = true

-- show relative line numbers
vim.wo.relativenumber = true

vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("GeminiRetab", { clear = true }),
  callback = function() 
    if vim.opt_local.expandtab:get() then
      vim.cmd [[retab]]
    end
  end,
})

vim.keymap.set('n', '<leader>rt', function()
  vim.cmd [[retab]]
  vim.cmd [[w]]
end, { desc = 'Retab and Save' })


vim.opt.tabstop = 4        -- number of visual spaces per TAB
vim.opt.shiftwidth = 4     -- number of spaces used for autoindent
vim.opt.softtabstop = 4    -- number of spaces a <Tab> counts for while editing
vim.opt.expandtab = true   -- convert tabs to spaces

vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", italic = true })

