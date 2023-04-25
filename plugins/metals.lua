local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })

return {
  "scalameta/nvim-metals",
  ft = { "scala", "sbt", "sc" },
  dependencies = {
    "nvim-lua/plenary.nvim"
  },
  config = function()
    local cfg = require("metals").bare_config()

    -- cfg.init_options.statusBarProvider = true

    cfg.settings = {
      showImplicitArguments = true,
      excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
    }

    cfg.on_attach = function(client, bufnr)
      require("plugins.lsp.keys").setup(client, bufnr)
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
