return {
  -- Add the community repository of plugin specifications
  "AstroNvim/astrocommunity",
  -- example of imporing a plugin, comment out to use it or add your own
  -- available plugins can be found at https://github.com/AstroNvim/astrocommunity

  { import = "astrocommunity.colorscheme.catppuccin" },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.completion.copilot-lua-cmp" },
  { import = "astrocommunity.syntax.vim-easy-align" },
  {
    "junegunn/vim-easy-align",
    keys = {
      { "ga", "<plug>(EasyAlign)", mode = "x" },
      { "ga", "<plug>(EasyAlign)", mode = "n" },
    },
  }
}
