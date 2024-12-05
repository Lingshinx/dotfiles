return {
  "mvllow/modes.nvim",
  config = function()
    require("modes").setup({
      colors = {
        copy = "#f5c359",
        delete = "#c75c6a",
        insert = "#c3e88d",
        visual = "#c099ff",
      },

      -- Set opacity for cursorline and number background
      line_opacity = 0.15,

      -- Enable cursor highlights
      set_cursor = true,

      -- Enable cursorline initially, and disable cursorline for inactive windows
      -- or ignored filetypes
      set_cursorline = true,

      -- Enable line number highlights to match cursorline
      set_number = true,

      -- Disable modes highlights in specified filetypes
      -- Please PR commonly ignored filetypes
      ignore_filetypes = { "NvimTree", "TelescopePrompt" },
    })
  end,
}
