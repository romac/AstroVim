return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    -- ensure_installed = { "lua" },

    rainbow = {
      enable = true,
      extended_mode = false,
      max_file_lines = nil
    }
  },
  dependencies = {
    'p00f/nvim-ts-rainbow',
  }
}
