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
    wit = "wit",
    eff = "effed",
    log = "tracing",
    tracing = "tracing",
    cairo = "cairo",
  },
  filename = {
    ["Justfile"] = "just",
    ["justfile"] = "just",
  },
  pattern = {
    -- ["~/%.config/foo/.*"] = "fooscript",
  },
}

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

-- Setup parser for Effed
---@diagnostic disable-next-line: inject-field
parser_config.effed = {
  install_info = {
    url = "~/Code/effed/tree-sitter-effed",
    files = { "src/parser.c" },
  },
  filetype = "eff",
}

vim.treesitter.language.register("effed", "eff")

-- -- Setup parser for tracing log files
-- ---@diagnostic disable-next-line: inject-field
-- parser_config.tracing = {
--   install_info = {
--     url = "~/Code/tree-sitter-tracing",
--     files = { "src/parser.c" },
--   },
--   filetype = "log",
-- }
--
-- vim.treesitter.language.register("tracing", "log")
-- vim.treesitter.language.register("tracing", "tracing")

local aliases = {
  -- Set :W as an alias for :w
  { "W", "w" },

  -- Set :Q as an alias for :q
  { "Q", "q" },
}

for _, alias in ipairs(aliases) do
  vim.api.nvim_create_user_command(alias[1], alias[2], { nargs = 0 })
end

-- WezTerm integration
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  callback = function(event)
    local title = "nvim"
    if event.file ~= "" then title = string.format("nvim: %s", vim.fs.basename(event.file)) end

    vim.fn.system { "wezterm", "cli", "set-tab-title", title }
  end,
})

vim.api.nvim_create_autocmd({ "VimLeave" }, {
  callback = function()
    -- Setting title to empty string causes wezterm to revert to its
    -- default behavior of setting the tab title automatically
    vim.fn.system { "wezterm", "cli", "set-tab-title", "" }
  end,
})

-- -- https://github.com/neovim/neovim/issues/30985
-- for _, method in ipairs { "textDocument/diagnostic", "workspace/diagnostic" } do
--   local default_diagnostic_handler = vim.lsp.handlers[method]
--   vim.lsp.handlers[method] = function(err, result, context, config)
--     if err ~= nil and err.code == -32802 then return end
--     return default_diagnostic_handler(err, result, context, config)
--   end
-- end
