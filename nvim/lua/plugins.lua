 return {
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
         "nvim-treesitter/nvim-treesitter",build=":TSUpdate",
         config =function ()
             local config=require("nvim-treesitter.configs")
            config.setup({
             auto_install=true,
             highlight ={enable = true},
             indent ={enable = true},
         })
         end
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-tree/nvim-web-devicons",
                    },
    },
    {
	     "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local telescope = require("telescope")
            telescope.setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({})
                    },
                },
            })
            telescope.load_extension("ui-select")
        	end,
   	 },
    {
 	   "nvim-telescope/telescope-ui-select.nvim",
   	}
}

