local o = vim.opt
local g = vim.g

g.mapleader = " "

o.buftype = ""
o.cmdheight = 0
o.expandtab = true
o.laststatus = 0
o.number = true
o.relativenumber = true
o.shiftwidth = 2
o.signcolumn = "auto"
o.softtabstop = 2
o.spell = false
o.swapfile = false
o.tabstop = 2
o.termguicolors = true
o.wrap = true

vim.cmd("set noruler")
vim.cmd("set noshowmode")
vim.cmd("set noshowcmd")
vim.cmd("set clipboard+=unnamedplus")
