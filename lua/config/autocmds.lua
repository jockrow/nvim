-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--------------------------------------------------------------------------------
-- print(vim.inspect(vim.api.nvim_get_mode()))
-- -- print(vim.inspect(vim.api.nvim_list_bufs()))
--
-- local time = os.date("%H:%M")
-- local context_msg = " "
-- local msg = context_msg .. " " .. time
-- print(msg)
-- require "notify"(vim.inspect(vim.api.nvim_get_mode()), "debug", { title = { "Debug Output", msg } })
-- -- require "notify"(vim.inspect(v), "debug", { title = { "Debug Output", msg } })

-- Check if we need to reload the file when it changed
--TODO: validar que no aplique para fugitive
-- vim.api.nvim_create_autocmd({ "BufEnter" }, { command = "checktime" })
--TODO: verificar si se puede cambiar automáticamente el coc-explorer
--

local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- mini.map
vim.api.nvim_create_autocmd({ "BufEnter", "Filetype" }, {
  desc = "Open mini.map and exclude some filetypes",
  pattern = { "*" },
  callback = function()
    local exclude_ft = {
      "qf",
      -- "NvimTree",
      "coc-explorer",
      "toggleterm",
      "TelescopePrompt",
      "alpha",
      "netrw",
    }

    local map = require("mini.map")
    if vim.tbl_contains(exclude_ft, vim.o.filetype) then
      vim.b.minimap_disable = true
      map.close()
    elseif vim.o.buftype == "" then
      map.open()
    end

    -- print(vim.o.filetype)
    -- if vim.tbl_contains(exclude_js, vim.o.filetype) then
    --   print("hellooo")
    -- end
  end,
})

-- BUG:Conflicto entre vim-matchup y treesiter
-- Disable andymass/vim-matchup for javascripts
-- TODO:Verificar si se puede deshabilitar por completo el andymass/vim-matchup plugin
-- con los archivos de abajo desde que se inicia lazyvim
-- vim.api.nvim_create_autocmd({ "FileType", "CursorMovedI" }, {
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup("matchup_matchparen_disable_ft"),
  pattern = {
    "javascript",
    "typescript",
  },
  callback = function()
    -- local exclude_js = {
    --   "javascript",
    --   "typescript",
    -- }

    -- if vim.tbl_contains(exclude_js, vim.o.filetype) then
    vim.g.matchup_matchparen_enabled = 0
    vim.g.matchup_motion_enabled = 0
    vim.g.matchup_text_obj_enabled = 0
    -- end
  end,
})
