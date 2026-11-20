return {
  {
    "LazyVim/LazyVim",
    opts = {
      -- Nvim's runtime ships an opaque colors/catppuccin.vim. Requiring the
      -- plugin first puts it on 'runtimepath' so plugin file wins.
      colorscheme = function()
        require("catppuccin").load()
      end,
    },
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha",
      transparent_background = true,
      float = { transparent = true, solid = true },
    },
  },
}
