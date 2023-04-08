return {
  -- ========================================
  -- # DAP
  -- ========================================
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
  },
  lazy = true,
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    local virtual = require("nvim-dap-virtual-text")

    local map = function(lhs, rhs, desc)
      if desc then
        desc = "[DAP] " .. desc
      end
      vim.keymap.set("n", lhs, rhs, { silent = true, desc = desc })
    end

    -- shows current position of debugger in code
    virtual.setup({
      enabled_commands = false,
      highlight_changed_variables = true,
      highlight_new_as_changeod = true,
      commented = false, -- prefix virtual text with comment string
      show_stop_reason = true,
    })

    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    map("<F1>", dap.step_back, "step_back")
    map("<F2>", dap.step_into, "step_into")
    map("<F3>", dap.step_over, "step_over")
    map("<F4>", dap.step_out, "step_out")
    map("<F5>", dap.continue, "continue")
    map("<leader>Db", dap.toggle_breakpoint, "toggle_breakpoint")
    map("<leader>Dc", dap.continue, "Start/Continue")
    map("<leader>Di", dap.step_into, "Step Into")
    map("<leader>Do", dap.step_over, "Step Over")
    map("<leader>DO", dap.step_out, "Step Out")
    map("<leader>Dr", dap.restart_frame, "Restart")
    map("<leader>Du", dapui.toggle, "Toggle Debugger UI")

    --------------------------------------------------------------------
    -- Debug adapter configuration
    --------------------------------------------------------------------

    -- native debugger
    dap.adapters.lldb = {
      type = "executable",
      command = "/usr/bin/lldb-vscode",
      name = "lldb",
    }

    -- Debug adapter configuration
    dap.adapters.firefox = {
      type = "executable",
      command = "node",
      args = { os.getenv("HOME") .. "/code/vscode-firefox-debug/dist/adapter.bundle.js" },
    }

    dap.configurations.rust = {
      {
        name = "Launch",
        type = "lldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
        end,
        cwd = "${workspaceFolder}",
        showDisassembly = "never",
        stopOnEntry = false,
        args = {},
      },
    }

    dap.configurations.typescriptreact = {
      name = "Debug with Firefox",
      type = "firefox",
      request = "launch",
      reAttach = true,
      url = "http://localhost:3000",
      webRoot = "${workspaceFolder}",
      firefoxExecutable = "/usr/bin/firefox",
    }
  end,
}
