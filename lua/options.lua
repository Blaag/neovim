-- VIM OPTIONS
--
-- Add line numbers and relative line numbers.
vim.opt.number = true
vim.opt.relativenumber = true

-- Splitting behaviors when opening new windows for code or help.
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Tab behaviors.
-- tabstop controls how far in a tab will go
-- shiftwidth controls how far indents go when auto indenting
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Clipboard options.
-- clipboard = "unnamedplus" integrates with the system clipboard (how do they get these names?)
vim.opt.clipboard = "unnamedplus"

-- Scrolling options.
-- scrolloff tell nvim to scroll down when cursor is at middle of page vs bottom
vim.opt.scrolloff = 999

-- Virtual edit options.
-- block mode means that when in visual block mode, you can go past ends of line
vim.opt.virtualedit = "block"

-- Substitution options.
-- inccommand puts a split window at the bottom when making substitutions so that
--   you can see all the places where the substitution will happen (good for when in large files)
inccommand = "split"

-- Tell nvim to ignore case when using commands
-- All internal commands start with lowercase, added/external commands always start with capital letters
vim.opt.ignorecase = true

-- Tell nvim to use expanded range of colors (can use all colors screen can use, 24bit support)
vim.opt.termguicolors = true

-- Set the leader key
vim.g.mapleader = " "
