-- This is my personal Nvim configuration, Linux only.
-- Author: Emiel Van Severen
-- Email: emiel@vanseveren.dev
-- Github: https://github.com/emielvanseveren

-- leader key -> ","
--
-- In general, it's a good idea to set this early in your config, otherwise
-- if you have any mappings set BEFORE this, they will be set to the OLD
-- leader
--

vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- check if we have the latest stable version of nvim
local expected_ver = "0.9.0"
local v = vim.version()
local nvim_ver = string.format("%d.%d.%d", v.major, v.minor, v.patch)

if nvim_ver ~= expected_ver then
  local msg = string.format("Unsupported nvim version: expect %s, but got %s instead!", expected_ver, nvim_ver)
  vim.api.nvim_err_writeln(msg)
  return
end

require("emiel.autocmd")
require("emiel.keymaps")
require("emiel.plugins")
require("emiel.options")
require("emiel.snippets.rust")
require("emiel.snippets.typescript")

require("impatient")

vim.cmd.colorscheme("dracula")
