return {
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        theme = "auto",
        globalstatus = true,
        component_separators = "",
        section_separators = "",
      },

      sections = {
        lualine_a = {
          {
            "mode",
            fmt = function()
              return vim.fn.mode() == "n" and "NORMAL" or vim.fn.mode():upper()
            end,
          },
        },

        lualine_b = {
          {
            "branch",
            icon = "",
          },
        },

        lualine_c = {
          {
            "filename",
            path = 0,
          },

          {
            "diff",
            symbols = {
              added = "+",
              modified = "~",
              removed = "-",
            },
          },
        },

        lualine_x = {
          "encoding",
          {
            "filetype",
            icon = true,
          },
        },

        lualine_y = {
          function()
            local clients = vim.lsp.get_clients({ bufnr = 0 })
            if #clients == 0 then
              return ""
            end

            return "󰒋 "
              .. table.concat(
                vim.tbl_map(function(client)
                  return client.name
                end, clients),
                ", "
              )
          end,
        },

        lualine_z = {
          "location",
        },
      },
    },
  },
}
