-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`

local lspconfig = require "lspconfig"

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    -- Configuration table of features provided by AstroLSP
    features = {
      autoformat = true, -- enable or disable auto formatting on start
      codelens = true, -- enable/disable codelens refresh on start
      inlay_hints = false, -- enable/disable inlay hints on start
      semantic_tokens = true, -- enable/disable semantic token highlighting
    },
    -- customize lsp formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true, -- enable or disable format on save globally
        allow_filetypes = {}, -- enable format on save for specified filetypes only
        ignore_filetypes = { -- disable format on save for specified filetypes
          "crates.nvim",
          "markdown",
          "python",
          "toml",
          "fish",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        "fish",
      },
      timeout_ms = 1000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- enable servers that you already have installed without mason
    servers = {
      "cairo",
      "fish",
      "gleam",
      "quint",
      "flix",
      "rhai",
      "sourcekit",
    },
    -- customize language server configuration options passed to `lspconfig`
    ---@diagnostic disable: missing-fields
    config = {
      -- Rust
      rust_analyzer = {
        settings = {
          ["rust-analyzer"] = {
            cargo = {
              autoreload = true,
              extraEnv = { CARGO_PROFILE_RUST_ANALYZER_INHERITS = "dev" },
              extraArgs = { "--profile", "rust-analyzer" },
              features = "all",
              buildScripts = {
                enable = true,
              },
              check = {
                command = "clippy",
                allTargets = true,
              },
            },
            completion = {
              postfix = {
                enable = true,
              },
            },
            procMacro = {
              enable = true,
            },
            imports = {
              granularity = {
                group = "module",
              },
            },
            diagnostics = {
              disabled = { "unresolved-proc-macro" },
            },
          },
        },
      },

      -- Quint
      quint = {
        cmd = { "quint-language-server", "--stdio" },
        filetypes = { "quint" },
        root_dir = function(_) return vim.fn.getcwd() end,
      },

      -- Rhai
      rhai = {
        cmd = { "rhai", "lsp", "stdio" },
        filetypes = { "rhai" },
        root_dir = function(_) return vim.fn.getcwd() end,
      },

      -- Cairo
      cairo = {
        cmd = { "scarb", "cairo-language-server" },
        filetypes = { "cairo" },
        root_dir = function(_) return vim.fn.getcwd() end,
      },

      -- Fish
      fish = {
        cmd = { "fish-lsp", "start" },
        filetypes = { "fish" },
        root_dir = function(_) return vim.fn.getcwd() end,
      },

      -- Flix
      flix = {
        cmd = { "flix", "lsp", "10435" },
        filetypes = { "flix" },
        root_dir = lspconfig.util.root_pattern "flix.toml" or vim.fs.dirname,
      },
    },

    -- customize how language servers are attached
    handlers = {
      -- a function without a key is simply the default handler, functions take two parameters, the server name and the configured options table for that server
      -- function(server, opts) require("lspconfig")[server].setup(opts) end

      -- the key is the server that is being setup with `lspconfig`
      -- rust_analyzer = false, -- setting a handler to false will disable the set up of that language server
      -- pyright = function(_, opts) require("lspconfig").pyright.setup(opts) end -- or a custom handler function can be passed
    },
    -- Configure buffer local auto commands to add when attaching a language server
    autocmds = {
      -- first key is the `augroup` to add the auto commands to (:h augroup)
      lsp_document_highlight = {
        -- Optional condition to create/delete auto command group
        -- can either be a string of a client capability or a function of `fun(client, bufnr): boolean`
        -- condition will be resolved for each client on each execution and if it ever fails for all clients,
        -- the auto commands will be deleted for that buffer
        cond = "textDocument/documentHighlight",
        -- cond = function(client, bufnr) return client.name == "lua_ls" end,
        -- list of auto commands to set
        {
          -- events to trigger
          event = { "CursorHold", "CursorHoldI" },
          -- the rest of the autocmd options (:h nvim_create_autocmd)
          desc = "Document Highlighting",
          callback = function() vim.lsp.buf.document_highlight() end,
        },
        {
          event = { "CursorMoved", "CursorMovedI", "BufLeave" },
          desc = "Document Highlighting Clear",
          callback = function() vim.lsp.buf.clear_references() end,
        },
      },
    },

    -- Configure buffer local user commands to add when attaching a language server
    commands = {
      Format = {
        function() vim.lsp.buf.format() end,
        cond = "textDocument/formatting",
        desc = "Format file with LSP",
      },
    },

    -- Configure default capabilities for language servers (`:h vim.lsp.protocol.make_client.capabilities()`)
    capabilities = require("blink.cmp").get_lsp_capabilities(),

    -- Configuration of mappings added when attaching a language server during the core `on_attach` function
    mappings = {
      n = {
        gl = { function() vim.diagnostic.open_float() end, desc = "Hover diagnostics" },
        -- a `cond` key can provided as the string of a server capability to be required to attach, or a function with `client` and `bufnr` parameters from the `on_attach` that returns a boolean
        -- gD = {
        --   function() vim.lsp.buf.declaration() end,
        --   desc = "Declaration of current symbol",
        --   cond = "textDocument/declaration",
        -- },
        -- ["<Leader>uY"] = {
        --   function() require("astrolsp.toggles").buffer_semantic_tokens() end,
        --   desc = "Toggle LSP semantic highlight (buffer)",
        --   cond = function(client) return client.server_capabilities.semanticTokensProvider and vim.lsp.semantic_tokens end,
        -- },
      },
    },
    -- A custom `on_attach` function to be run after the default `on_attach` function
    -- takes two parameters `client` and `bufnr`  (`:h lspconfig-setup`)
    on_attach = function(client, bufnr)
      -- this would disable semanticTokensProvider for all clients
      -- client.server_capabilities.semanticTokensProvider = nil
    end,
  },
}
