-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",

  -- Themes
  { import = "astrocommunity.colorscheme.catppuccin" },
  {
    "catppuccin",
    opts = {
      no_italic = true,
    },
  },

  -- {
  --   "folke/tokyonight.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   opts = {},
  -- },

  -- LuaSnip
  {
    "L3MON4D3/LuaSnip",
    enabled = true,
    specs = { { "Saghen/blink.cmp", opts = { snippets = { preset = "luasnip" } } } },
  },

  -- Blink completion
  { import = "astrocommunity.completion.blink-cmp" },
  {
    "Saghen/blink.cmp",
    opts = {
      completion = {
        list = { selection = { preselect = true, auto_insert = true } },
      },
    },
  },

  -- Rainbow
  { import = "astrocommunity.editing-support.rainbow-delimiters-nvim" },

  -- Snippets
  -- { import = "astrocommunity.snippet.nvim-snippets" },

  -- Packs
  { import = "astrocommunity.pack.go" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.nix" },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.scala" },
  { import = "astrocommunity.pack.swift" },
  { import = "astrocommunity.pack.typescript" },

  -- Copilot
  { import = "astrocommunity.completion.copilot-lua-cmp" },

  -- Easy align
  { import = "astrocommunity.syntax.vim-easy-align" },
  {
    "junegunn/vim-easy-align",
    enabled = true,
    keys = {
      { "ga", "<plug>(EasyAlign)", mode = "x" },
      { "ga", "<plug>(EasyAlign)", mode = "n" },
    },
  },

  -- Search & Replace
  { import = "astrocommunity.search.grug-far-nvim" },

  -- Zen Mode
  { import = "astrocommunity.editing-support.true-zen-nvim" },
}
