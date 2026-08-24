return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.options = {
        component_separators = "",
        section_separators = "",
      }

      opts.sections = {
        lualine_a = {},
        lualine_b = {},

        lualine_c = {
          {
            "filename",
            path = 0,
            symbols = {
              modified = " ●",
              readonly = " 󰌾",
              unnamed = "[No Name]",
            },
          },
          {
            "branch",
            icon = "",
          },
          {
            "diff",
            symbols = {
              added = " ",
              modified = " ",
              removed = " ",
            },
          },
          {
            "diagnostics",
            sources = { "nvim_diagnostic" },
            symbols = {
              error = " ",
              warn = " ",
              info = " ",
            },
          },

          "%=",
        },

        lualine_x = {
          "location",
          "encoding",
          "filetype",
        },

        lualine_y = {},
        lualine_z = {},
      }
    end,
  },
}
