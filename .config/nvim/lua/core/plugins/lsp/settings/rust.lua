return {
  ["rust-analyzer"] = {
    procMacro = { enable = true },
    cargo = { AllFeatures = true },
    checkOnSave = true,
    check = {
      command = "clippy",
      extraArgs = { "--no-deps" }
    }
  },
  cmd = {
    "rustup",
    "run",
    "stable",
    "rust-analyzer",
  },
}
