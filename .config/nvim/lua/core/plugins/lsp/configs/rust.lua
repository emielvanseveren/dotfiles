return {
  ["rust-analyzer"] = {
    procMacro = { enable = true },
    cargo = { AllFeatures = true },
    checkOnSave = true,
    capabilities = {
      experimental = {
        serverStatusNotification = true,
      }
    },
    completion = {
      fullFunctionSignatures = {
        enable = true
      }
    },
    check = {
      command = "clippy",
      extraArgs = { "--no-deps" }
    },
    rustfmt = {
      extraArgs = { "+nightly" },
    }
  },
}
