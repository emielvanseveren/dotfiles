return {
  ["rust-analyzer"] = {
    procMacro = { enable = true },
    cargo = { AllFeatures = true },



    checkOnSave = {
      allTargets = false,
      extraArgs = {
        "--bins"
      }
    },
    check = {

      command = "clippy",
      extraArgs = { "--no-deps" }
    }
  },
}
