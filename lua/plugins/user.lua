-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {

  -- customize alpha options
  {
    "goolord/alpha-nvim",
    enabled = false,
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {}
      return opts
    end,
  },

  {
    "chrisgrieser/nvim-rip-substitute",
    keys = {
      {
        "<leader>fs",
        function() require("rip-substitute").sub() end,
        mode = { "n", "x" },
        desc = "Search & replace in buffer",
      },
    },
  },

  {
    "rhaiscript/vim-rhai",
    ft = "rhai",
  },

  {
    "romac/openingh.nvim",
    cmd = { "OpenInGHRepo", "OpenInGHFile", "OpenInGHFileLines" },
    keys = {
      {
        "<leader>gh",
        function() vim.cmd "OpenInGHFile" end,
        mode = { "n", "x" },
        desc = "Open file in GitHub",
      },
    },
  },

  {
    "cormacrelf/dark-notify",
    event = "ColorScheme",
    config = function() require("dark_notify").run() end,
  },

  {
    "folke/todo-comments.nvim",
    opts = {
      highlight = {
        pattern = { ".*<(KEYWORDS)?\\s*[:-]", ".*<(KEYWORDS)\\(\\w*\\)\\s*[:-]" },
        keyword = "fg",
      },
      search = {
        pattern = "\\b(KEYWORDS)(\\(\\w*\\))?\\s*[:-]",
      },
    },
  },

  {
    "mei28/instant_rename.nvim",
    event = { "ModeChanged", "CmdlineChanged" }, -- for lazy loading
    config = function() require "instant_rename" end,
  },

  {
    "florentc/vim-tla",
    ft = "tla",
  },
}
