vim.g.mapleader = " "
vim.o.updatetime = 1000

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"

vim.wo.number = true
vim.wo.relativenumber = true

vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
        vim.api.nvim_set_hl(0, "LspReferenceText",  { bg = "#3b4252" })
        vim.api.nvim_set_hl(0, "LspReferenceRead",  { bg = "#3b4252" })
        vim.api.nvim_set_hl(0, "LspReferenceWrite", { bg = "#3b4252" })
    end,
})

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})

vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")
vim.keymap.set({ "n", "i", "v" }, "<Up>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set({ "n", "i", "v" }, "<Down>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set({ "n", "i", "v" }, "<Left>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set({ "n", "i", "v" }, "<Right>", "<Nop>", { noremap = true, silent = true })

vim.keymap.set("n", "Z", ":only<CR>", { silent = true, noremap = true })

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

require("lazy").setup("plugins")

vim.keymap.set("n", "<C-p>", function()
    require("telescope.builtin").find_files()
end, { desc = "Find files" })

vim.keymap.set("n", "<C-g>", function()
    require("telescope.builtin").live_grep()
end, { desc = "Live grep" })

vim.keymap.set("n", "<C-f>", ":Neotree filesystem reveal left<CR>", { desc = "Toggle Neotree" })

vim.keymap.set("n", "<leader>tn", ":tabnew<CR>", { desc = "New Tab" })
vim.keymap.set("n", "<leader>tc", ":tabclose<CR>", { desc = "Close Tab" })
vim.keymap.set("n", "<leader>tl", ":tabnext<CR>", { desc = "Next Tab" })
vim.keymap.set("n", "<leader>th", ":tabprevious<CR>", { desc = "Previous Tab" })
vim.keymap.set("n", "<C-Tab>", ":tabnext<CR>", { silent = true })
vim.keymap.set("n", "<C-S-Tab>", ":tabprevious<CR>", { silent = true })

vim.keymap.set("n", "<leader>e", function()
    vim.diagnostic.open_float(nil, { focus = false })
end, { desc = "Show diagnostic" })

vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "*",
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("Retab", { clear = true }),
    callback = function()
        if vim.opt_local.expandtab:get() then
            vim.cmd([[retab]])
        end
    end,
})

vim.keymap.set("n", "<leader>rt", function()
    vim.cmd([[retab]])
    vim.cmd([[w]])
end, { desc = "Retab and Save" })
