local lspconfig = require("lspconfig")
lspconfig.kotlin_language_server.setup({
  init_options = {
    storagePath = lspconfig.util.path.join(vim.env.XDG_DATA_HOME, "nvim-data"),
  },
})
