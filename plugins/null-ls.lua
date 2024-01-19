return {
  "jose-elias-alvarez/null-ls.nvim",
  opts = function(_, config)
    -- config variable is the default configuration table for the setup function call
    local null_ls = require "null-ls"

    -- Check supported formatters and linters
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    config.sources = {
      -- Set a formatter

      -- Lua
      -- null_ls.builtins.formatting.stylua,

      -- JavaScript
      -- null_ls.builtins.formatting.prettier,

      -- Nix
      null_ls.builtins.formatting.alejandra,

      -- Swift: https://github.com/nicklockwood/SwiftFormat
      null_ls.builtins.formatting.swiftformat,
    }
    return config -- return final config table
  end,
}
