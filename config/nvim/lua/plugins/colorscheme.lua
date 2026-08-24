return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  opts = {
    flavour = "mocha",
    transparent_background = true,
    float = {
      transparent = true,
      solid = true,
    },

    integrations = {
      telescope = true,
      snacks = true,
      cmp = true,
      treesitter = true,
      native_lsp = {
        enabled = true,
      },
    },
  },

  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin")
  end,
}
