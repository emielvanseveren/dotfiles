local dap = require("dap")
local dap_ui = require("dapui")

local map = function(lhs, rhs, desc)
	if desc then
		desc = "[DAP] " .. desc
	end

	vim.keymap.set("n", lhs, rhs, { silent = true, desc = desc })
end

map("<F1>", dap.step_back, "step_back")
map("<F2>", dap.step_into, "step_into")
map("<F3>", dap.step_over, "step_over")
map("<F4>", dap.step_out, "step_out")
map("<F5>", dap.continue, "continue")

map("<leader>b", dap.toggle_breakpoint, "toggle_breakpoint")

-- shows current position of debugger in code
require("nvim-dap-virtual-text").setup({
	enabled_commands = false,
	highlight_changed_variables = true,
	highlight_new_as_changeod = true,

	-- prefix virtual text with comment sring
	commented = false,
	show_stop_reason = true,
})

dap.listeners.after.event_initialized["dapui_config"] = function()
	dap_ui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
	dap_ui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
	dap_ui.close()
end

--------------------------------------------------------------------
-- Debug adapter configuration
-- Note: rust-tools in other.lua also has builtin dap support.
--------------------------------------------------------------------
dap.adapters.firefox = {
	type = "executable",
	command = "node",
	args = { os.getenv("HOME") .. "/code/vscode-firefox-debug/dist/adapter.bundle.js" },
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
