local lazy_dir = vim.fn.stdpath("data") .. "/lazy"
print(lazy_dir)

return {
  -- ========================================
  -- # DAP
  -- ========================================
  "mfussenegger/nvim-dap",
  dependencies = {
    {
      "rcarriga/nvim-dap-ui",
      config = function(_, opts)
        local dap = require("dap")
        local dapui = require("dapui")
        dapui.setup(opts)
        dap.listeners.after.event_initialized["dapui_config"] = function()
          dapui.open({})
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
          dapui.close({})
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
          dapui.close({})
        end
      end,
    },

    {
      "theHamsta/nvim-dap-virtual-text",
      opts = {},
    },
  },
  config = function()
    -- shows current position of debugger in code
    require("nvim-dap-virtual-text").setup({
      enabled_commands = false,
      highlight_changed_variables = true,
      highlight_new_as_changeod = true,
      commented = false, -- prefix virtual text with comment string
      show_stop_reason = true,
    })
  end,
  opts = function()
    local dap = require("dap")

    --------------------------------------------------------------------
    -- Debug adapter configuration
    --------------------------------------------------------------------

    -- link adapters to debugger
    dap.adapters.lldb = {
      type = "executable",
      command = "/usr/bin/lldb-vscode",
      name = "lldb",
    }

    dap.configurations.rust = {
      {
        name = "Launch",
        type = "lldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        showDisassembly = "never",
        stopOnEntry = false,
      },
    }

    -- in case no launch.json is found
  end,
  keys = {
    {
      "<F1>",
      function()
        require("dap").step_back()
      end,
      desc = "[DEBUG] step_back",
    },
    {
      "<F3>",
      function()
        require("dap").step_over()
      end,
      desc = "[DEBUG] step_over",
    },
    {
      "<F2>",
      function()
        require("dap").step_into()
      end,
      desc = "[DEBUG] step_into",
    },
    {
      "<F4>",
      function()
        require("dap").step_out()
      end,
      desc = "[DEBUG] step_out",
    },
    {
      "<F5>",
      function()
        require("dap").continue()
      end,
      desc = "[DEBUG] continue",
    },
    {
      "<leader>Dc",
      function()
        require("dap").continue()
      end,
      desc = "[DEBUG] Start/Continue",
    },
    {
      "<leader>Db",
      function()
        require("dap").toggle_breakpoint()
      end,
      desc = "[DEBUG] toggle_breakpoint",
    },
    {
      "<leader>Di",
      function()
        require("dap").step_into()
      end,
      desc = "[DEBUG] Step Into",
    },
    {
      "<leader>Do",
      function()
        require("dap").step_over()
      end,
      desc = "[DEBUG] Step Over",
    },
    {
      "<leader>DO",
      function()
        require("dap").step_out()
      end,
      desc = "[DEBUG] Step Out",
    },
    {
      "<leader>Dr",
      function()
        require("dap").restart_frame()
      end,
      desc = "[DEBUG] Restart",
    },
    {
      "<leader>Du",
      function()
        require("dapui").toggle()
      end,
      desc = "[DEBUG] Toggle Debugger UI",
    },
  },
}
