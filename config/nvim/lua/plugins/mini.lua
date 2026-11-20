return {
  {
    "nvim-mini/mini.nvim",
    version = false,
    config = function()
      require("mini.ai").setup()
      require("mini.animate").setup()
      require("mini.comment").setup()
      require("mini.hipatterns").setup()
      require("mini.icons").setup()
      require("mini.indentscope").setup()
      require("mini.pairs").setup()
    end,
  },
}
