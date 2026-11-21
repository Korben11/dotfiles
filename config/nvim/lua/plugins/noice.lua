return {
  "folke/noice.nvim",
  opts = {
    cmdline = { view = "cmdline" }, -- classic bottom cmdline instead of the floating popup
    presets = {
      bottom_search = true, -- / and ? at the bottom too
      long_message_to_split = true, -- long command output opens in a split
    },
  },
}
