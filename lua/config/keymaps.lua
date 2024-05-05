-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keyset = vim.keymap.set

-- Avoid to use <Esc>j or k cause, move a line
keyset("i", "jk", "<Esc>")
keyset("v", "jk", "<Esc>")
keyset("i", "JK", "<Esc>")
keyset("v", "JK", "<Esc>")

-- Restore default keys vim
keyset("n", '"', '"')
keyset("v", "x", "x")
keyset("n", "<leader>m", "")
keyset("n", "<leader>,", "<cmd>Telescope buffers show_all_buffers=true<cr>", { desc = "Switch Buffer" })

keyset("n", "<leader>bf", ":call Differences()<cr>", { silent = true, desc = "Compare differences buffers" })
keyset("n", "<leader>br", ":e#<cr>", { silent = true, desc = "Reopen closed buffer" })

--undo redo
keyset("n", "<M-BS>", "u")
keyset("i", "<M-BS>", "<Esc>u")
keyset("n", "<M-S-BS>", "<C-r>", { remap = true })
keyset("i", "<M-S-BS>", "<Esc><C-r>", { remap = true })

-- Nav panes terminal
keyset("t", "<C-w>h", "<Esc><C-\\><C-n><C-w>h")
keyset("t", "<C-w>j", "<Esc><C-\\><C-n><C-w>j")
keyset("t", "<C-w>k", "<Esc><C-\\><C-n><C-w>k")
keyset("t", "<C-w>l", "<Esc><C-\\><C-n><C-w>l")
keyset("t", "<Esc>", "<C-\\><C-n>")
keyset("t", "<C-w>p", "<C-\\><C-n><C-w>p")
keyset("t", "<C-w><C-w>", "<Esc><C-\\><C-n><C-w>w")

-- Terminal
keyset("n", "<leader>ft", function()
  require("lazyvim.util").float_term(nil, { cwd = require("lazyvim.util").get_root() })
end, { desc = "Terminal (root dir)" })
keyset("n", "<leader>fT", function()
  require("lazyvim.util").float_term()
end, { desc = "Terminal (cwd)" })

-- Resize
keyset("n", "<A-Left>", ":vertical resize -2<CR>", { silent = true })
keyset("n", "<A-Right>", ":vertical resize +2<CR>", { silent = true })
keyset("n", "<A-Up>", ":resize +2<CR>", { silent = true })
keyset("n", "<A-Down>", ":resize -2<CR>", { silent = true })

-- TODO: Previous and Next Tab Vim

-- Static Line
keyset("n", "<C-j>", "<C-e>", { desc = "Static line up" })
keyset("n", "<C-k>", "<C-y>", { desc = "Static line down" })
keyset("i", "<C-j>", "<Esc><C-e>li", { desc = "Static line down" })
keyset("i", "<C-k>", "<Esc><C-y>li", { desc = "Static line up" })

-- Find and Replace
keyset("n", "<C-f>", "/\\c\\V", { desc = "Find a expresion" })
keyset("v", "<C-f>", "<Esc>/\\%V", { desc = "Find a expresion" })
keyset("n", "<C-h>", ":%s/\\c\\V/g<left><left>", { desc = "Replace a expresion" })
keyset("v", "<C-h>", ":s/\\c\\V", { desc = "Replace a expresion" })
-- Code
keyset("n", "grr", ":Trouble lsp_references<CR>", { desc = "My References" })
keyset("n", "<leader>cx", ":call ExeCode()<cr>", { desc = "Execute Code" })
keyset("i", "<leader>cx", "<Esc>:call ExeCode()<cr>", { desc = "Execute Code" })

-- Action lines
keyset("n", "yil", "^yg_", { desc = "Copy inner line" })
keyset("n", "yal", "0y$h", { desc = "Copy line without enter" })
keyset("n", "val", "0v$h", { desc = "Line without enter" })
keyset("n", "vil", "^vg_", { desc = "Inner line" })
keyset("n", "dil", "vild", { desc = "Delete inner line", remap = true })

-- Select buffer
keyset("n", "yib", ":%y<CR>", { desc = "Copy Buffer" })
keyset("n", "vib", "ggVG", { desc = "Select Buffer" })

-- Paths
keyset(
  "n",
  "ydc",
  ":let @+=expand('%:p:h')|echo 'Copied Directory!'<CR>",
  { silent = true, desc = "Copy Directory path" }
)
keyset("n", "ydf", ":let @+=expand('%:p')|echo 'Copied Full Path!'<CR>", { silent = true, desc = "Copy Full Path" })
keyset("n", "ydb", ":let @+=expand('%:t')|echo 'Copied File Name!'<CR>", { silent = true, desc = "Copy File Name" })
keyset(
  "n",
  "ydr",
  ":let @+=finddir('.git/..', expand('%:p:h').';')|echo 'Copied root Project!'<CR>",
  { silent = true, desc = "Copy root project dir" }
)

-- TODO: ponerlo en una funcion y llamarlo con el keymap
keyset("n", "<leader>De", function()
  local current_dir = vim.fn.expand("%:p:h")
  local file_explorer = {}

  file_explorer.OSX = "silent !open -a Finder "
  --TODO: verificar para linux y windows
  file_explorer.win32 = "silent !explorer "
  file_explorer.linux = "silent !nautilus "

  vim.cmd(file_explorer[jit.os] .. current_dir)
end, { desc = "Directory Open with File Explorer" })
keyset("n", "<leader>Dc", ":exe \"cd \" . expand('%:p:h')|pwd<CR>", { desc = "Directory Change to current" })

keyset(
  "n",
  "<C-k>m",
  ":lua require('telescope.builtin').filetypes()<CR>",
  { silent = true, desc = "Change to file type" }
)

-- plugin:coc-explorer
keyset("n", "<leader>e", ":CocCommand explorer --sources=buffer+,file+<cr>", { silent = true, desc = "coc-explorer" })

-- Comments
keyset("n", "<C-k><C-l>", ":norm gccjk<cr>", { silent = true, desc = "Invert Comment" })
keyset("n", "<C-k><C-j>", ":norm yyupkgcc<cr>", { silent = true, desc = "Backup Comment" })
keyset("i", "<C-k><C-j>", "<Esc>:norm yyupkgcc<cr>", { silent = true, desc = "Backup Comment" })

-- Debug
-- keyset("n", "<leader>dW", ":lua require('IDE').PrintWordOrSelection()<cr>", { silent = true, desc = "Add Watch" })
-- keyset("v", "<leader>dW", ":lua require('IDE').PrintWordOrSelection()<cr>", { silent = true, desc = "Add Watch" })
keyset("n", "<leader>dW", ":lua require('IDE').DebugAddWatch()<cr>", { silent = true, desc = "Add Watch" })
vim.api.nvim_set_keymap(
  "x",
  "<leader>dW",
  ":lua require('IDE').DebugAddWatchVisual()<cr>",
  { silent = true, desc = "Add Watch" }
)
