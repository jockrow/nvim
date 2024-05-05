-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Another options:
--	https://github.com/luukvbaal/statuscol.nvim
-- Add any additional options here
-- let g:sessions_path = $LOCALAPPDATA . "/nvim-data/sessions/"
vim.g.sessions_path = "~/.config/nvim/sessions"

-- lua require('telescope.builtin').command_history
-- lvim.builtin.telescope.defaults.file_ignore_patterns = {
-- require("telescope.builtin").file_ignore_patterns = {
-- TODO:configurar ignorar archivos para telescope find
-- https://github.com/nvim-telescope/telescope.nvim/issues/522
-- file_ignore_patterns = {
--   nil,
--   "node_modules/",
--   "extension/",
--   -- "sessions/",
--   -- "%.vim",
-- }
-- require("telescope").setup({ defaults = { file_ignore_patterns = {
--   nil,
--   "extension",
--   "node_modules",
-- } } })

vim.opt.ignorecase = false
--TODO:Poner highlight para focus buffer

-- vim.g.mapleader = ","
-- vim.g.maplocalleader = ","

vim.opt.swapfile = false --

-- FIX:mostrar letrero cuando haya una pestaña
-- vim.opt.showtabline._value = 2
-- vim.o.showtabline = 2
-- vim.opt.pumblend = 13
-- vim.opt.showtabline = { 2 }
-- vim.opt.showtabline = 2

vim.opt.listchars = "eol:↵,tab:> ,space:.,nbsp:+"
vim.opt.colorcolumn = "80"
vim.opt.cursorcolumn = true
vim.opt.foldcolumn = "1"
vim.opt.statuscolumn = "%C %s %l %r "
--TODO:poner el título a la izquierda
vim.opt.winbar = "%=%m %f"

-- -- Configure vim-dadbod
-- vim.g.dbs = {
--   bdMysql = "mysql://root:test@localhost:3306/mysql?protocol=tcp",
--   -- Add other database configurations as needed
-- }

-- Tabs
-- set copyindent
-- set preserveindent
-- "set expandtab
vim.cmd("set noexpandtab")
-- vim.opt.tabstop = 3
-- vim.opt.shiftwidth = 3
-- vim.opt.softtabstop = 0

vim.cmd([[
" filetype indent plugin on
" syntax enable

"let g:colorizer_auto_filetype='css,html'
" let colorizer_disable_bufleave = 1
]])

--TODO: cambiar 2 espacios por 1 tab
