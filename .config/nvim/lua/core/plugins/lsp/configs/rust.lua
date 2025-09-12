return {
  ["rust-analyzer"] = {
    procMacro = {
      enable = true,
      ignored = {
        ["async-trait"] = { "async_trait" },
        ["napi-derive"] = { "napi" },
        ["async-recursion"] = { "async_recursion" },
      },
    },
    cargo = {
      allFeatures = true,
      loadOutDirsFromCheck = true,
      buildscripts = {
        enable = true
      }
    },
    checkOnSave = true,
    diagnostics = {
      enable = true
    },
    files = {
      excludeDirs = {
        ".direnv",
        ".git",
        ".github",
        ".gitlab",
        "bin",
        "node_modules",
        "target",
        "venv",
        ".venv",
      },
    },
    rustfmt = {
      extraArgs = { "+nightly" },
    }
  },
}
