return {
  "guysherman/pg.nvim",
  enabled = false,
  cmd = {
    "PGRunQuery",
    "PGConnectBuffer",
  },
  keys = {
    { "<leader>qq", '<c-u>exec "PGRunQuery"<cr>', mode = "v" },
    { "<leader>qc", "PGConnectBuffer<cr>", mode = "n" },
  },
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
  },
}
