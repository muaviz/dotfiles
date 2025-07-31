return {
  "mfussenegger/nvim-dap",
  dependencies = {
    {
      "nvim-neotest/nvim-nio",
    },
    {
      "rcarriga/nvim-dap-ui",
      config = function()
        require("dapui").setup()
      end,
    },
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    -- UI open/close logic
    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    -- Keybindings
    vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, {})
    vim.keymap.set("n", "<Leader>dc", dap.continue, {})

    -- DAP Adapter for codelldb
    dap.adapters.codelldb = {
      type = "executable",
      command = "codelldb", -- change this if it's not in your PATH
      name = "codelldb",
    }

    -- C++ Debug Configuration
    dap.configurations.cpp = {
      {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = {},
      },
    }

    -- Optional: Also apply this config for C and Rust
    dap.configurations.c = dap.configurations.cpp
    dap.configurations.rust = dap.configurations.cpp
  end,
}
