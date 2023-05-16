local keys = {
  { "gD",         vim.lsp.buf.definition },
  { "K",          vim.lsp.buf.hover },
  { "gi",         vim.lsp.buf.implementation },
  { "gr",         vim.lsp.buf.references },
  { "gds",        vim.lsp.buf.document_symbol },
  { "gws",        vim.lsp.buf.workspace_symbol },
  { "<leader>cl", vim.lsp.codelens.run },
  { "<leader>sh", vim.lsp.buf.signature_help },
  { "<leader>rn", vim.lsp.buf.rename },
  { "<leader>f",  vim.lsp.buf.format },
  { "<leader>ca", vim.lsp.buf.code_action },
}

local get_opts = function(keys)
  local opts = {}
  for k, v in pairs(keys) do
    if type(k) ~= "number" and k ~= "mode" and k ~= "id" then
      opts[k] = v
    end
  end
  return opts
end

local add_keys = function(keys)
  for _, key in pairs(keys) do
    local opts = get_opts(key)

    local lhs = key[1]
    local rhs = key[2]
    local mode = key.mode or "n"

    vim.keymap.set("n", lhs, function()
        pcall(vim.keymap.del, mode, lhs)
        vim.keymap.set(mode, lhs, rhs, opts)

        local feed = vim.api.nvim_replace_termcodes("<Ignore>" .. lhs, true, true, true)
        -- insert instead of append the lhs
        vim.api.nvim_feedkeys(feed, "i", false)
      end,
      {
        desc = opts.desc,
        nowait = opts.nowait,
        expr = true
      })
  end
end

return {
  "scalameta/nvim-metals",
  ft = { "scala", "sbt", "sc" },
  dependencies = {
    "nvim-lua/plenary.nvim"
  },
  config = function()
    add_keys(keys)

    local cfg = require("metals").bare_config()

    cfg.init_options.statusBarProvider = false

    cfg.settings = {
      showImplicitArguments = true,
      excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
    }

    cfg.on_attach = function(client, bufnr)
      require("plugins.lsp.keys").setup(client, bufnr)

      local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })

      vim.api.nvim_create_autocmd("CursorHold", {
        callback = vim.lsp.buf.document_highlight,
        buffer = bufnr,
        group = nvim_metals_group,
      })
      vim.api.nvim_create_autocmd("CursorMoved", {
        callback = vim.lsp.buf.clear_references,
        buffer = bufnr,
        group = nvim_metals_group,
      })
      vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
        callback = vim.lsp.codelens.refresh,
        buffer = bufnr,
        group = nvim_metals_group,
      })
    end

    cfg.capabilities = require("cmp_nvim_lsp").default_capabilities()

    require("metals").initialize_or_attach(cfg)
  end
}
