---@type LazySpec
return {
  "yetone/avante.nvim",
  build = ":AvanteBuild",
  cmd = {
    "AvanteAsk",
    "AvanteBuild",
    "AvanteEdit",
    "AvanteRefresh",
    "AvanteSwitchProvider",
    "AvanteChat",
    "AvanteToggle",
    "AvanteClear",
  },
  dependencies = {
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = assert(opts.mappings)
        local prefix = "<Leader>a"

        maps.n[prefix] = { desc = " Avante" }

        maps.v[prefix .. "r"] = { function() require("avante.api").refresh() end, desc = "Refresh Avante" }

        maps.n[prefix .. "a"] = { function() require("avante.api").ask() end, desc = "Ask Avante" }
        maps.v[prefix .. "a"] = { function() require("avante.api").ask() end, desc = "Ask Avante" }

        maps.n[prefix .. "e"] = { function() require("avante.api").edit() end, desc = "Edit with Avante" }
        maps.v[prefix .. "e"] = { function() require("avante.api").edit() end, desc = "Edit with Avante" }

        -- -- the following key bindings do not have an official api implementation
        -- maps.n.co = { "<Plug>(AvanteConflictOurs)", desc = "Choose ours", expr = true }
        -- maps.v.co = { "<Plug>(AvanteConflictOurs)", desc = "Choose ours", expr = true }
        --
        -- maps.n.ct = { "<Plug>(AvanteConflictTheirs)", desc = "Choose theirs", expr = true }
        -- maps.v.ct = { "<Plug>(AvanteConflictTheirs)", desc = "Choose theirs", expr = true }
        --
        -- maps.n.ca = { "<Plug>(AvanteConflictAllTheirs)", desc = "Choose all theirs", expr = true }
        -- maps.v.ca = { "<Plug>(AvanteConflictAllTheirs)", desc = "Choose all theirs", expr = true }
        --
        -- maps.n.cb = { "<Plug>(AvanteConflictBoth)", desc = "Choose both", expr = true }
        -- maps.v.cb = { "<Plug>(AvanteConflictBoth)", desc = "Choose both", expr = true }
        --
        -- maps.n.cc = { "<Plug>(AvanteConflictCursor)", desc = "Choose cursor", expr = true }
        -- maps.v.cc = { "<Plug>(AvanteConflictCursor)", desc = "Choose cursor", expr = true }
        --
        -- maps.n["]x"] = { "<Plug>(AvanteConflictPrevConflict)", desc = "Move to previous conflict", expr = true }
        -- maps.n["[x"] = { "<Plug>(AvanteConflictNextConflict)", desc = "Move to next conflict", expr = true }
      end,
    },
  },
  opts = {
    provider = "copilotclaude",
    hints = { enabled = false },
    vendors = {
      copilotclaude = {
        __inherited_from = "copilot",
        api_key_name = "GITHUB_TOKEN",
        model = "claude-3.5-sonnet",
        max_tokens = 4096,
      },
    },
  },
  specs = { -- configure optional plugins
    {
      -- make sure `Avante` is added as a filetype
      "MeanderingProgrammer/render-markdown.nvim",
      optional = true,
      opts = function(_, opts)
        if not opts.file_types then opts.filetypes = { "markdown" } end
        opts.file_types = require("astrocore").list_insert_unique(opts.file_types, { "Avante" })
      end,
    },
    {
      -- make sure `Avante` is added as a filetype
      "OXY2DEV/markview.nvim",
      optional = true,
      opts = function(_, opts)
        if not opts.filetypes then opts.filetypes = { "markdown", "quarto", "rmd" } end
        opts.filetypes = require("astrocore").list_insert_unique(opts.filetypes, { "Avante" })
      end,
    },
  },
}
