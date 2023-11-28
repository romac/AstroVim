return {
  {
    "maxbane/vim-asm_ca65",
    enabled = true,
  },
  {
    "rhysd/vim-llvm",
    enabled = true,
  },
  {
    "folke/todo-comments.nvim",
    enabled = true,
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "TodoTelescope" },
    opts = {},
    init = function()
      vim.api.nvim_create_user_command("TodoEnable", function() require("todo-comments").enable() end, { nargs = 0 })
      vim.api.nvim_create_user_command("TodoDisable", function() require("todo-comments").disable() end, { nargs = 0 })
      vim.api.nvim_create_user_command(
        "Todo",
        function() require("todo-comments.search").setloclist() end,
        { nargs = 0 }
      )
    end,
  },
}
