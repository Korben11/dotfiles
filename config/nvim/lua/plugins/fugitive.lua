return {
  "tpope/vim-fugitive",
  -- Real "vim" plugin, no setup() needed; lazy-load on its commands/keys.
  cmd = { "G", "Git", "Gdiffsplit", "Gvdiffsplit", "Gread", "Gwrite", "Ggrep", "GMove", "GDelete", "GBrowse", "Gedit" },
  keys = {
    { "<leader>gv", "<cmd>Git<cr>", desc = "Git Status (Fugitive)" },
    { "<leader>gV", "<cmd>Gvdiffsplit<cr>", desc = "Git Diff Split (Fugitive)" },
  },
}
