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
    "rhysd/vim-wasm",
    enabled = true,
    init = function()
      vim.api.nvim_create_autocmd({
        "BufNewFile",
        "BufRead",
      }, {
        pattern = "*.wat",
        callback = function()
          local buf = vim.api.nvim_get_current_buf()
          vim.api.nvim_buf_set_option(buf, "filetype", "wast")
        end,
      })
    end,
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
  {
    "pocco81/true-zen.nvim",
    enabled = true,
    cmd = { "TZNarrow", "TZFocus", "TZMinimalist", "TZAtaraxis" },
    opts = {
      modes = {
        ataraxis = {
          minimum_writing_area = { -- minimum size of main window
            width = 120,
            height = 80,
          },
        },
        minimalist = {
          options = {
            wrap = true,
          },
        },
      },
    },
  },
}
