-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

local configs = require "lspconfig.configs"

-- 1. Register Custom Servers BEFORE the return statement
-- This "teaches" lspconfig about servers it doesn't know by default.
local custom_configs = {
  effed = {
    cmd = { "java", "-jar", "/Users/romac/Code/effed/out/assembly.dest/out.jar", "lsp" },
    -- cmd = { "/Users/romac/Code/effed/out/nativeImage.dest/native-executable", "lsp" },
    -- cmd = {
    --   "java",
    --   "-agentlib:native-image-agent=config-merge-dir=/tmp/graalvm",
    --   "-jar",
    --   "/Users/romac/Code/effed/out/assembly.dest/out.jar",
    --   "lsp",
    -- },
    filetypes = { "effed" },
  },
  quint = { cmd = { "quint-language-server", "--stdio" }, filetypes = { "quint" } },
  rhai = { cmd = { "rhai", "lsp", "stdio" }, filetypes = { "rhai" } },
  flix = { cmd = { "flix", "lsp", "10435" }, filetypes = { "flix" } },
  ty = { cmd = { "ty", "server" }, filetypes = { "python" } },
}

for name, config in pairs(custom_configs) do
  if not configs[name] then
    configs[name] = {
      default_config = {
        cmd = config.cmd,
        filetypes = config.filetypes,
        root_dir = function(_) return vim.fn.getcwd() end,
      },
    }
  end
end

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    -- Configuration table of features provided by AstroLSP
    features = {
      codelens = true, -- enable/disable codelens refresh on start
      inlay_hints = true, -- enable/disable inlay hints on start
      semantic_tokens = true, -- enable/disable semantic token highlighting
    },
    -- customize lsp formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true, -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "go",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          "crates.nvim",
          "markdown",
          "toml",
          "fish",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- disable lua_ls formatting capability if you want to use StyLua to format your lua code
        "fish",
      },
      timeout_ms = 1000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- enable servers that you already have installed without mason
    servers = {
      "effed",
      "fish_lsp",
      "gleam",
      -- "pyrefly",
      "quint",
      "rhai",
      "sourcekit",
      "ty",
    },
    -- customize language server configuration options passed to `lspconfig`
    ---@diagnostic disable: missing-fields
    config = {
      clangd = { capabilities = { offsetEncoding = "utf-8" } },

      effed = {
        -- root_dir = lspconfig.util.root_pattern("project.eff", ".git"),
        single_file_support = true,
      },

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
            },
            check = {
              command = "clippy",
              allTargets = true,
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
            inlayHints = {
              typeHints = {
                enable = false,
              },
              parameterHints = {
                enable = true,
              },
              chainingHints = {
                enable = true,
              },
              closureReturnTypeHints = {
                enable = "with_block",
              },
              implicitDrops = {
                enable = false,
              },
            },
          },
        },
      },

      -- -- Quint
      -- quint = {
      --   cmd = { "quint-language-server", "--stdio" },
      --   filetypes = { "quint" },
      --   root_dir = function(_) return vim.fn.getcwd() end,
      -- },

      -- -- Rhai
      -- rhai = {
      --   cmd = { "rhai", "lsp", "stdio" },
      --   filetypes = { "rhai" },
      --   root_dir = function(_) return vim.fn.getcwd() end,
      -- },

      -- -- Flix
      -- flix = {
      --   cmd = { "flix", "lsp", "10435" },
      --   filetypes = { "flix" },
      --   root_dir = lspconfig.util.root_pattern "flix.toml",
      -- },

      -- -- Ty
      -- ty = {
      --   cmd = { "ty", "server" },
      --   filetypes = { "python" },
      --   root_dir = lspconfig.util.root_pattern(
      --     "ty.toml",
      --     "pyproject.toml",
      --     "setup.py",
      --     "setup.cfg",
      --     "requirements.txt",
      --     ".git"
      --   ),
      -- },
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
      lsp_codelens_refresh = {
        -- Optional condition to create/delete auto command group
        -- can either be a string of a client capability or a function of `fun(client, bufnr): boolean`
        -- condition will be resolved for each client on each execution and if it ever fails for all clients,
        -- the auto commands will be deleted for that buffer
        cond = "textDocument/codeLens",
        -- cond = function(client, bufnr) return client.name == "lua_ls" end,
        -- list of auto commands to set
        {
          -- events to trigger
          event = { "InsertLeave", "BufEnter" },
          -- the rest of the autocmd options (:h nvim_create_autocmd)
          desc = "Refresh codelens (buffer)",
          callback = function(args)
            if require("astrolsp").config.features.codelens then vim.lsp.codelens.refresh { bufnr = args.buf } end
          end,
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

    -- mappings to be set up on attaching of a language server
    mappings = {
      n = {
        -- a `cond` key can provided as the string of a server capability to be required to attach, or a function with `client` and `bufnr` parameters from the `on_attach` that returns a boolean
        gD = {
          function() vim.lsp.buf.declaration() end,
          desc = "Declaration of current symbol",
          cond = "textDocument/declaration",
        },
        ["<Leader>uY"] = {
          function() require("astrolsp.toggles").buffer_semantic_tokens() end,
          desc = "Toggle LSP semantic highlight (buffer)",
          cond = function(client)
            return client:supports_method "textDocument/semanticTokens/full" and vim.lsp.semantic_tokens ~= nil
          end,
        },

        -- Metals commands (only when metals LSP is active)
        ["<Leader>M"] = { desc = "Metals", cond = function(client) return client.name == "metals" end },

        -- Build
        ["<Leader>Mi"] = {
          function() require("metals").import_build() end,
          desc = "Import build",
          cond = function(client) return client.name == "metals" end,
        },
        ["<Leader>Mc"] = {
          function() require("metals").connect_build() end,
          desc = "Connect build",
          cond = function(client) return client.name == "metals" end,
        },
        ["<Leader>Md"] = {
          function() require("metals").disconnect_build() end,
          desc = "Disconnect build",
          cond = function(client) return client.name == "metals" end,
        },
        ["<Leader>Mr"] = {
          function() require("metals").restart_build_server() end,
          desc = "Restart build server",
          cond = function(client) return client.name == "metals" end,
        },
        ["<Leader>Mb"] = {
          function() require("metals").generate_bsp_config() end,
          desc = "Generate BSP config",
          cond = function(client) return client.name == "metals" end,
        },
        ["<Leader>MS"] = {
          function() require("metals").switch_bsp() end,
          desc = "Switch BSP server",
          cond = function(client) return client.name == "metals" end,
        },

        -- Compile
        ["<Leader>Mk"] = {
          function() require("metals").compile_cascade() end,
          desc = "Compile cascade",
          cond = function(client) return client.name == "metals" end,
        },
        ["<Leader>MK"] = {
          function() require("metals").compile_clean() end,
          desc = "Compile clean",
          cond = function(client) return client.name == "metals" end,
        },
        ["<Leader>Mx"] = {
          function() require("metals").compile_cancel() end,
          desc = "Cancel compilation",
          cond = function(client) return client.name == "metals" end,
        },

        -- Code actions
        ["<Leader>Mo"] = {
          function() require("metals").organize_imports() end,
          desc = "Organize imports",
          cond = function(client) return client.name == "metals" end,
        },
        ["<Leader>Ms"] = {
          function() require("metals").goto_super_method() end,
          desc = "Goto super method",
          cond = function(client) return client.name == "metals" end,
        },
        ["<Leader>Mh"] = {
          function() require("metals").super_method_hierarchy() end,
          desc = "Super method hierarchy",
          cond = function(client) return client.name == "metals" end,
        },

        -- Scalafix
        ["<Leader>Mf"] = {
          function() require("metals").run_scalafix() end,
          desc = "Run Scalafix",
          cond = function(client) return client.name == "metals" end,
        },
        ["<Leader>MF"] = {
          function() require("metals").run_single_scalafix() end,
          desc = "Run single Scalafix rule",
          cond = function(client) return client.name == "metals" end,
        },

        -- New files/projects
        ["<Leader>Mn"] = {
          function() require("metals").new_scala_file() end,
          desc = "New Scala file",
          cond = function(client) return client.name == "metals" end,
        },
        ["<Leader>MN"] = {
          function() require("metals").new_java_file() end,
          desc = "New Java file",
          cond = function(client) return client.name == "metals" end,
        },
        ["<Leader>Mp"] = {
          function() require("metals").new_scala_project() end,
          desc = "New Scala project",
          cond = function(client) return client.name == "metals" end,
        },

        -- Worksheets
        ["<Leader>Mw"] = {
          function() require("metals").quick_worksheet() end,
          desc = "Quick worksheet",
          cond = function(client) return client.name == "metals" end,
        },
        ["<Leader>MW"] = {
          function() require("metals").copy_worksheet_output() end,
          desc = "Copy worksheet output",
          cond = function(client) return client.name == "metals" end,
        },

        -- Diagnostics & info
        ["<Leader>MD"] = {
          function() require("metals").run_doctor() end,
          desc = "Run doctor",
          cond = function(client) return client.name == "metals" end,
        },
        ["<Leader>MI"] = {
          function() require("metals").info() end,
          desc = "Metals info",
          cond = function(client) return client.name == "metals" end,
        },
        ["<Leader>Mt"] = {
          function() require("metals").toggle_logs() end,
          desc = "Toggle logs",
          cond = function(client) return client.name == "metals" end,
        },
        ["<Leader>Ma"] = {
          function() require("metals").analyze_stacktrace() end,
          desc = "Analyze stacktrace",
          cond = function(client) return client.name == "metals" end,
        },
        ["<Leader>MT"] = {
          function() require("metals").show_build_target_info() end,
          desc = "Build target info",
          cond = function(client) return client.name == "metals" end,
        },

        -- Decompile / Semanticdb / TASTy
        ["<Leader>Mj"] = {
          function() require("metals").show_javap() end,
          desc = "Show javap",
          cond = function(client) return client.name == "metals" end,
        },
        ["<Leader>MJ"] = {
          function() require("metals").show_javap_verbose() end,
          desc = "Show javap (verbose)",
          cond = function(client) return client.name == "metals" end,
        },
        ["<Leader>MC"] = {
          function() require("metals").show_cfr() end,
          desc = "Show cfr decompiled",
          cond = function(client) return client.name == "metals" end,
        },
        ["<Leader>My"] = {
          function() require("metals").show_tasty() end,
          desc = "Show TASTy",
          cond = function(client) return client.name == "metals" end,
        },
        ["<Leader>Me"] = {
          function() require("metals").show_semanticdb_compact() end,
          desc = "Show SemanticDB (compact)",
          cond = function(client) return client.name == "metals" end,
        },
        ["<Leader>ME"] = {
          function() require("metals").show_semanticdb_detailed() end,
          desc = "Show SemanticDB (detailed)",
          cond = function(client) return client.name == "metals" end,
        },

        -- Workspace
        ["<Leader>MR"] = {
          function() require("metals").reset_workspace() end,
          desc = "Reset workspace",
          cond = function(client) return client.name == "metals" end,
        },
        ["<Leader>Mm"] = {
          function() require("metals").restart_metals() end,
          desc = "Restart Metals",
          cond = function(client) return client.name == "metals" end,
        },
        ["<Leader>Mg"] = {
          function() require("metals").scan_sources() end,
          desc = "Scan sources",
          cond = function(client) return client.name == "metals" end,
        },
        ["<Leader>MZ"] = {
          function() require("metals").find_in_dependency_jars() end,
          desc = "Find in dependency jars",
          cond = function(client) return client.name == "metals" end,
        },

        -- Ammonite / Scala CLI
        ["<Leader>M1"] = {
          function() require("metals").start_ammonite() end,
          desc = "Start Ammonite",
          cond = function(client) return client.name == "metals" end,
        },
        ["<Leader>M!"] = {
          function() require("metals").stop_ammonite() end,
          desc = "Stop Ammonite",
          cond = function(client) return client.name == "metals" end,
        },
        ["<Leader>M2"] = {
          function() require("metals").start_scala_cli() end,
          desc = "Start Scala CLI",
          cond = function(client) return client.name == "metals" end,
        },
        ["<Leader>M@"] = {
          function() require("metals").stop_scala_cli() end,
          desc = "Stop Scala CLI",
          cond = function(client) return client.name == "metals" end,
        },
      },
    },
    -- A custom `on_attach` function to be run after the default `on_attach` function
    -- takes two parameters `client` and `bufnr`  (`:h lspconfig-setup`)
    on_attach = function(_client, _bufnr)
      -- this would disable semanticTokensProvider for all clients
      -- client.server_capabilities.semanticTokensProvider = nil
    end,
  },
}
