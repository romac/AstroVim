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
    'HiPhish/nvim-ts-rainbow2',
  }
}
