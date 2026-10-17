local lazy_dir = vim.fn.stdpath("data") .. "/lazy"

return {
  -- ========================================
  -- # DAP
  -- ========================================
  "mfussenegger/nvim-dap",
  lazy = true,
  dependencies = {
    {
      "rcarriga/nvim-dap-ui",
      dependencies = { "nvim-neotest/nvim-nio" }, -- hard requirement of dap-ui
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
      highlight_new_as_changed = true,
      commented = false, -- prefix virtual text with comment string
      show_stop_reason = true,
    })

    local dap = require("dap")

    --------------------------------------------------------------------
    -- Debug adapter configuration
    --------------------------------------------------------------------

    -- codelldb comes from mason. It replaces lldb-vscode, which LLVM renamed to
    -- lldb-dap in 18, and it pretty-prints Rust Vec/enum/Option out of the box.
    dap.adapters.codelldb = {
      type = "server",
      port = "${port}",
      executable = {
        command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
        args = { "--port", "${port}" },
      },
    }

    dap.configurations.rust = {
      {
        name = "Launch",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        showDisassembly = "never",
        stopOnEntry = false,
      },
    }
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
