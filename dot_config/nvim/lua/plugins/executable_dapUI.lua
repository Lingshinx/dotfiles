return {
  "rcarriga/nvim-dap-ui",
  opts = {},
  config = function(_, opts)
    local dap = require("dap")
    local dapUI = require("dapui")

    dapUI.setup(opts)
    dap.listeners.before.event_initialized["dapui_config"] = function()
      require("toggleterm").toggle()
      vim.keymap.set("n", "<M-i>", function()
        dap.step_into()
      end)
      vim.keymap.set("n", "<M-o>", function()
        dap.step_over()
      end)
      vim.keymap.set("n", "<M-u>", function()
        dap.step_out()
      end)
      vim.keymap.set("n", "<M-p>", function()
        dap.terminate()
      end)
    end

    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapUI.open({})
    end

    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapUI.close({})
      vim.keymap.del("n", "<M-i>")
      vim.keymap.del("n", "<M-o>")
      vim.keymap.del("n", "<M-u>")
      vim.keymap.del("n", "<M-p>")
    end

    dap.listeners.before.event_exited["dapui_config"] = function()
      dapUI.close({})
    end
  end,
}
