--- IMPORTANT: neodev setup should be done BEFORE lspconfig
local present, neodev = pcall(require, "neodev")

if not present then
  return
end

neodev.setup({
  library = {
    plugins = { "nvim-dap-ui" },
    types = true,
  },
})
