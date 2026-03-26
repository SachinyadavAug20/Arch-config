return {
    "nvim-lualine/lualine.nvim",
    event = { "VeryLazy" },
    config = function()
        require('lualine').setup({
            options = {
                theme = 'dracula',
                globalstatus = true,
                disabled_filetypes = { statusline = { "dashboard", "alpha", "neo-tree" } },
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff' },
                lualine_c = { 'diagnostics' },
                lualine_x = { 'filetype' },
                lualine_y = { 'progress' },
                lualine_z = { 'location' },
            },
        })
    end
}
