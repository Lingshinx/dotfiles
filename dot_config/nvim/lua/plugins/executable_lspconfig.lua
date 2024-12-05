local lspconfig = require("lspconfig")
return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      tinymist = {
        offset_encoding = "utf-8",
        single_file_support = true,
        settings = {
          exportPdf = "never",
        },
        root_dir = function()
          return vim.fn.getcwd()
        end,
      },

      kotlin_language_server = {
        init_options = {
          storagePath = lspconfig.util.path.join(vim.env.XDG_DATA_HOME, "nvim-data"),
        },
      },
    },
    setup = {
      clangd = function(_, opts)
        opts.capabilities.offsetEncoding = { "utf-16" }
      end,
    },
  },
}
