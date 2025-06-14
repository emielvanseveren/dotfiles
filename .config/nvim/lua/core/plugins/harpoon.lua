local Util = require("core.utils")

return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  opts = {
    menu = {
      width = vim.api.nvim_win_get_width(0) - 4,
    },
    settings = {
      save_on_toggle = true,
    },
  },
  keys = {
    {
      "<leader><leader>H",
      function()
        local harpoon = require("harpoon")
        harpoon:list():add()
      end,
      desc = "[h]arpoon the file",
    },
    {
      "<leader><leader>h",
      function()
        local harpoon = require("harpoon")
        Util.telescope_harpoon(harpoon:list())
      end,
      desc = "[l]ist [h]arpoon files"
    },
  }
}
