return {
  "scalameta/nvim-metals",
  ft = { "scala", "sbt", "sc" },
  dependencies = {
    "nvim-lua/plenary.nvim"
  },
  keys = {
    { "gD",         vim.lsp.buf.definition },
    { "K",          vim.lsp.buf.hover },
    { "gi",         vim.lsp.buf.implementation },
    { "gr",         vim.lsp.buf.references },
    { "gds",        vim.lsp.buf.document_symbol },
    { "gws",        vim.lsp.buf.workspace_symbol },
    { "<leader>cl", vim.lsp.codelens.run },
    { "<leader>sh", vim.lsp.buf.signature_help },
    { "<leader>rn", vim.lsp.buf.rename },
    { "<leader>f",  vim.lsp.buf.formatting },
    { "<leader>ca", vim.lsp.buf.code_action },
  },
  config = function()
    local cfg = require("metals").bare_config()

    cfg.init_options.statusBarProvider = false

    cfg.settings = {
      showImplicitArguments = true,
      excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
    }

    cfg.on_attach = function(client, bufnr)
      require("plugins.lsp.keys").setup(client, bufnr)

      --   local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
      --
      --   vim.api.nvim_create_autocmd("CursorHold", {
      --     callback = vim.lsp.buf.document_highlight,
      --     buffer = bufnr,
      --     group = nvim_metals_group,
      --   })
      --   vim.api.nvim_create_autocmd("CursorMoved", {
      --     callback = vim.lsp.buf.clear_references,
      --     buffer = bufnr,
      --     group = nvim_metals_group,
      --   })
      --   vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
      --     callback = vim.lsp.codelens.refresh,
      --     buffer = bufnr,
      --     group = nvim_metals_group,
      --   })
    end

    cfg.capabilities = require("cmp_nvim_lsp").default_capabilities()

    require("metals").initialize_or_attach(cfg)
  end
}
