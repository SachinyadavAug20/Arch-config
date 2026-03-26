return {
  {
    "tpope/vim-dadbod",
    cmd = { "DB", "DBUI", "DBSelect" },
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      "tpope/vim-dadbod",
    },
    cmd = { "DBUI", "DBSelect" },
  },
}
