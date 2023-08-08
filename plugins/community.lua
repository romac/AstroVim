return {
  -- Add the community repository of plugin specifications
  "AstroNvim/astrocommunity",

  -- Themes
  { import = "astrocommunity.colorscheme.catppuccin",    enabled = true },
  {
    "catppuccin",
    opts = {
      no_italic = true,
      integrations = {
        ts_rainbow2 = true,
      }
    }
  },

  -- Language packs
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.go" },

  -- Copilot
  { import = "astrocommunity.completion.copilot-lua-cmp" },

  -- Easy align
  { import = "astrocommunity.syntax.vim-easy-align", enabled = true },
  {
    "junegunn/vim-easy-align",
    enabled = true,
    keys = {
      { "ga", "<plug>(EasyAlign)", mode = "x" },
      { "ga", "<plug>(EasyAlign)", mode = "n" },
    },
  }
}
