return {
  -- ========================================
  -- # DAP
  -- ========================================
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
  },
  keys = {
    {
      "<F1>",
      function()
        require("dap").step_back()
      end,
      "step_back",
    },
    {
      "<F3>",
      function()
        require("dap").step_over()
      end,
      "step_over",
    },
    {
      "<F2>",
      function()
        require("dap").step_into()
      end,
      "step_into",
    },
    {
      "<F4>",
      function()
        require("dap").step_out()
      end,
      "step_out",
    },
    {
      "<F5>",
      function()
        require("dap").continue()
      end,
      "continue",
    },
    {
      "<leader>Dc",
      function()
        require("dap").continue()
      end,
      "Start/Continue",
    },
    {
      "<leader>Db",
      function()
        require("dap").toggle_breakpoint()
      end,
      "toggle_breakpoint",
    },
    {
      "<leader>Di",
      function()
        require("dap").step_into()
      end,
      "Step Into",
    },
    {
      "<leader>Do",
      function()
        require("dap").step_over()
      end,
      "Step Over",
    },
    {
      "<leader>DO",
      function()
        require("dap").step_out()
      end,
      "Step Out",
    },
    {
      "<leader>Dr",
      function()
        require("dap").restart_frame()
      end,
      "Restart",
    },
    {
      "<leader>Du",
      function()
        require("dapui").toggle()
      end,
      "Toggle Debugger UI",
    },
  },
  lazy = true,
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    -- shows current position of debugger in code
    require("nvim-dap-virtual-text").setup({
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
