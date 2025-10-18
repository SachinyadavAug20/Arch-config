-- Bootstrap lazy.nvim
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
local config = require("nvim-treesitter.configs")
config.setup({
    ensure_installed = {"lua","javascript","c","html"},
    highlight={enable=true},
    indent={enable=true},

})

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
require("vim-options")
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
-- ==========================
-- 📑 Custom Tabline
-- ==========================
vim.o.showtabline = 2  -- always show tabline

vim.o.tabline = [[%!v:lua.MyTabLine()]]

function MyTabLine()
  local s = ''
  for i = 1, vim.fn.tabpagenr('$') do
    -- select the right highlight group
    if i == vim.fn.tabpagenr() then
      s = s .. '%#TabLineSel#'
    else
      s = s .. '%#TabLine#'
    end

    -- tab number
    s = s .. ' ' .. i .. ':'

    -- get buffer name in the tab
    local buflist = vim.fn.tabpagebuflist(i)
    local winnr = vim.fn.tabpagewinnr(i)
    local name = vim.fn.fnamemodify(vim.fn.bufname(buflist[winnr]), ':t')

    if name == '' then
      name = '[No Name]'
    end

    s = s .. ' ' .. name .. ' '
  end

  s = s .. '%#TabLineFill#'
  return s
end

-- ==========================
-- 🎨 Highlight Colors (Optional)
-- ==========================
vim.cmd [[
  highlight TabLineSel guifg=#ffffff guibg=#444444 gui=bold
  highlight TabLine guifg=#aaaaaa guibg=#222222
  highlight TabLineFill guibg=#111111
]]


