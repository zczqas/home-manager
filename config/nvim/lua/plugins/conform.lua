return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "ruff_format", "ruff_organize_import" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        ["*"] = { "trim_whitespace" },
      },
    },
  },
}
