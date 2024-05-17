-- Customize None-ls sources

---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  opts = function(_, config)
    -- config variable is the default configuration table for the setup function call
    local null_ls = require "null-ls"

    -- Check supported formatters and linters
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    config.sources = {
      -- Lua
      null_ls.builtins.formatting.stylua,

      -- Nix
      null_ls.builtins.formatting.alejandra,

      -- Swift: https://github.com/nicklockwood/SwiftFormat
      null_ls.builtins.formatting.swiftformat,

      -- JavaScript
      null_ls.builtins.formatting.prettier,
    }
    return config -- return final config table
  end,
}
