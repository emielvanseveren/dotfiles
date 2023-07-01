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
    -- This is the actual node debugger
    {
      "microsoft/vscode-js-debug",
      build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
      lazy = true,
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

    dap.adapters["pwa-node"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = "node",
        args = { os.getenv("HOME") .. "/.local/share/nvim/lazy/vscode-js-debug/out/src/vsDebugServer.js", "${port}" },
      },
    }

    local ts_file_types = {
      "typescriptreact",
      "typescript",
      "javascript",
      "javascriptreact",
    }

    -- TODO: this is not working yet
    -- So added the configurations below manually (I think it is monorepo related)

    -- use .vscode/launch.json to setup debug configurations
    require("dap.ext.vscode").load_launchjs("~/launch.json", { ["pwa-node"] = ts_file_types })

    -- FIX: pwa-node is currently not working correctly.
    -- I think it is related to issue: https://github.com/mfussenegger/nvim-dap/issues/762
    -- I can start the debugger see the output in the terminal but the breakpoints are not hit
    dap.configurations.typescript = {
      {
        type = "pwa-node",
        request = "attach",
        name = "api",
        skipFiles = { "<node_internals>/**" },
        address = "127.0.0.1",
        port = 12001,
        localRoot = "${workspaceFolder}/packages/app-api",
        remoteRoot = "/app/packages/app-api",
        outFiles = {
          "${workspaceFolder}/packages/lib-http/**/*.js",
          "${workspaceFolder}/packages/lib-queues/**/*.js",
          "${workspaceFolder}/packages/lib-util/**/*.js",
          "${workspaceFolder}/packages/lib-gameserver/**/*.js",
          "${workspaceFolder}/packages/**/dist/*.js",
        },
      },
      {
        type = "pwa-node",
        request = "attach",
        name = "vmm",
        skipFiles = { "<node_internals>/**" },
        address = "127.0.0.1",
        port = 12002,
        localRoot = "${workspaceFolder}/packages/app-vmm",
        remoteRoot = "/app/packages/app-vmm",
        restart = true,
        outFiles = {
          "${workspaceFolder}/packages/lib-http/**/*.js",
          "${workspaceFolder}/packages/lib-queues/**/*.js",
          "${workspaceFolder}/packages/**/dist/*.js",
        },
      },
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
