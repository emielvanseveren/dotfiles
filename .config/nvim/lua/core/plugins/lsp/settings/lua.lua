return {
  Lua = {
    hint = { enable = true },
    telemetry = { enable = false },
    diagnostics = { globals = { "vim" } },
    workspace = { checkThirdParty = false },
    runtime = { version = "LuaJIT" }
  },
}
