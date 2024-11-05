-- This is my personal Nvim configuration, Linux only.
-- Author: Emiel Van Severen
-- Email: emiel@vanseveren.dev
-- Github: https://github.com/emielvanseveren

vim.g.mapleader = ","
vim.g.maplocalleader = ","

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

