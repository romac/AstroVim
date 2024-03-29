return {
  -- Configure AstroNvim updates
  updater = {
    remote = "origin", -- remote to use
    channel = "stable", -- "stable" or "nightly"
    version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "nightly", -- branch name (NIGHTLY ONLY)
    commit = nil, -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false, -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    auto_quit = false, -- automatically quit the current session after a successful update
    remotes = { -- easily add new remotes to track
      --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
      --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
      --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    },
  },

  -- Set colorscheme to use
  colorscheme = "catppuccin",

  -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
  diagnostics = {
    virtual_text = true,
    underline = true,
  },

  lsp = {
    -- customize lsp formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true, -- enable or disable format on save globally
        -- allow_filetypes = { -- enable format on save for specified filetypes only
        --   -- "go",
        -- },
        ignore_filetypes = { -- disable format on save for specified filetypes
          "toml",
          "markdown",
          "python",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- disable lua_ls formatting capability if you want to use StyLua to format your lua code
        -- "lua_ls",
      },
      timeout_ms = 1000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- enable servers that you already have installed without mason
    servers = {
      "sourcekit",
      "quint",
      "gleam",
    },
    -- server configuration
    config = {
      -- rust-analyzer options
      rust_analyzer = {
        settings = {
          ["rust-analyzer"] = {
            diagnostics = {
              disabled = { "unresolved-proc-macro" },
            },
            cargo = {
              features = "all",
              buildScripts = {
                enable = true,
              },
            },
            procMacro = {
              enable = true,
            },
            check = {
              command = "clippy",
              allTargets = true,
            },
            imports = {
              granularity = {
                group = "module",
              },
            },
          },
        },
      },

      quint = function()
        return {
          cmd = { "quint-language-server", "--stdio" },
          filetypes = { "quint" },
          root_dir = function(_) return vim.fn.getcwd() end,
        }
      end,

      -- pylsp options
      pylsp = {
        settings = {
          pylsp = {
            plugins = {
              pycodestyle = {
                enabled = false,
              },
              rope_autoimport = {
                enabled = true,
              },
            },
          },
        },
      },
    },
  },

  -- Configure require("lazy").setup() options
  lazy = {
    defaults = { lazy = true },
    performance = {
      rtp = {
        -- customize default disabled vim plugins
        disabled_plugins = { "tohtml", "gzip", "matchit", "zipPlugin", "netrwPlugin", "tarPlugin" },
      },
    },
  },

  -- This function is run last and is a good place to configuring
  -- augroups/autocommands and custom filetypes also this just pure lua so
  -- anything that doesn't fit in the normal config locations above can go here
  polish = function()
    -- Set background based on output of `dark-mode status` command
    local dark_mode = vim.trim(vim.fn.system { "dark-mode", "status" })
    if dark_mode == "off" then
      vim.o.background = "light"
    else
      vim.o.background = "dark"
    end

    -- Set up custom filetypes
    vim.filetype.add {
      extension = {
        qnt = "quint",
      },
    }

    -- Load custom commands
    require("user.commands").load()
  end,
}
