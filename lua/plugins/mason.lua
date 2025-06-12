-- Customize Mason

---@type LazySpec
return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- overrides `require("mason-tool-installer").setup(...)`
    opts = {
      -- Make sure to use the names found in `:Mason`
      ensure_installed = {
        -- Lua
        "lua-language-server",
        "stylua",

        -- Rust
        "rust-analyzer",

        -- Haskell
        "haskell-language-server",
        "fourmolu",

        -- install formatters
        -- JavaScript/TypeScript
        "prettier",

        -- Other
        "tree-sitter-cli",
        "typos-lsp",
      },
    },
  },
}
