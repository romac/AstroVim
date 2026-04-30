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
  -- { import = "astrocommunity.pack.go" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.nix" },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.scala" },
  { import = "astrocommunity.pack.swift" },
  { import = "astrocommunity.pack.typescript" },

  -- Copilot
  { import = "astrocommunity.completion.copilot-lua-cmp" },
  -- {
  --   "copilotlsp-nvim/copilot-lsp",
  --   init = function()
  --     vim.g.copilot_nes_debounce = 500
  --     vim.lsp.enable "copilot_ls"
  --     -- vim.keymap.set("n", "<tab>", function()
  --     --   local bufnr = vim.api.nvim_get_current_buf()
  --     --   local state = vim.b[bufnr].nes_state
  --     --   if state then
  --     --     -- Try to jump to the start of the suggestion edit.
  --     --     -- If already at the start, then apply the pending suggestion and jump to the end of the edit.
  --     --     local _ = require("copilot-lsp.nes").walk_cursor_start_edit()
  --     --       or (require("copilot-lsp.nes").apply_pending_nes() and require("copilot-lsp.nes").walk_cursor_end_edit())
  --     --     return nil
  --     --   else
  --     --     -- Resolving the terminal's inability to distinguish between `TAB` and `<C-i>` in normal mode
  --     --     return "<C-i>"
  --     --   end
  --     -- end, { desc = "Accept Copilot NES suggestion", expr = true })
  --   end,
  -- },
  {
    "zbirenbaum/copilot.lua",
    enabled = true,
    dependencies = {
      -- "copilotlsp-nvim/copilot-lsp",
    },
    opts = {
      -- copilot_model = "claude-4.5-opus",
      filetypes = {
        ["*"] = true,
        help = false,
        sh = function()
          if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), "^%.env.*") then
            -- disable for .env files
            return false
          end
          return true
        end,
      },
      nes = {
        enabled = false,
        auto_trigger = true,
        keymap = {
          accept_and_goto = "<Tab>",
          accept = false,
          dismiss = "<Esc>",
        },
      },
    },
  },

  -- Avante
  -- { import = "astrocommunity.completion.avante-nvim" },

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
