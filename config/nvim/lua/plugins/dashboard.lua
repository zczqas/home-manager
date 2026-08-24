return {
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        width = 60,
        sections = {
          {
            pane = 1,
            { section = "keys", gap = 1, padding = 1 },
            { section = "startup" },
          },
        },
      },
    },
  },
}
