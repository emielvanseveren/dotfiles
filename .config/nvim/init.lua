-- This is my personal Nvim configuration, Linux only.
-- Author: Emiel Van Severen
-- Email: emiel@vanseveren.dev
-- Github: https://github.com/emielvanseveren

vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- check if we have the latest stable version of nvim
local expected_ver = "0.9.2"
local v = vim.version()
local nvim_ver = string.format("%d.%d.%d", v.major, v.minor, v.patch)

if nvim_ver ~= expected_ver then
  local msg = string.format("Unsupported nvim version: expect %s, but got %s instead!", expected_ver, nvim_ver)
  vim.api.nvim_err_writeln(msg)
  return
end

-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("core.plugins")
require("core.config.autocmd")
require("core.config.keymaps")
require("core.config.options")
