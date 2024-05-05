local M = {}

-- M.watch = ""

-- function DebugAddWatch()
--   vim.cmd([[
--   let watch	= expand('<cword>')
--   let bufmap = map(range(1, winnr('$')), '[bufname(winbufnr(v:val)), v:val]')
--   let w_watch = filter(bufmap, 'v:val[0] =~ "DAP Watches"')[0][1]
--   exe w_watch . "wincmd w"
--   exe "normal! A" . watch . "\<CR>"
--   exe "wincmd p"
-- 	]])
-- end

function M.DebugAddWatch()
  local watch = vim.fn.expand("<cword>")
  _DebugAddWatch(watch)
  --   local bufmap = vim.fn.map(vim.fn.range(1, vim.fn.winnr("$")), 'v:val .. ":" .. bufname(winbufnr(v:val))')
  --   local w_watch = vim.fn.filter(bufmap, 'v:val:match("DAP Watches")')[1]:match(":(.*)")
  --   vim.cmd(w_watch .. "wincmd w")
  --   vim.fn.feedkeys("A" .. watch .. "\n", "n")
  --   vim.cmd("wincmd p")
end

function M.DebugAddWatchVisual()
  -- local watch = @"

  -- local selection = vim.fn.getreg('"', 1, 1)
  -- -- vim.fn.setreg("+", selection)
  -- print("selection:" .. selection)

  local selection = vim.fn.getreg('"', 1, 1)
  local concatenated_selection = table.concat(selection, "\n")
  print("Visual selection:\n" .. concatenated_selection)

  -- local selection = vim.fn.getreg('"', 1, 1)
  -- print("Visual selection: " .. selection)

  --  vim.cmd([[
  -- " exe "y"
  -- exe "normal! y"
  -- echo @"
  -- 	]])

  vim.cmd("y")
  -- vim.cmd('exe "y"')
  -- vim.fn.feedkeys("y")
  print("..." .. vim.fn.getreg('@"'))
  local watch = vim.fn.getreg('"')
  -- local watch = vim.fn.getreg('"', 1, 1)
  -- _DebugAddWatch(watch)
  -- -- local watch = vim.fn.expand("<cword>")
end

function _DebugAddWatch(watch)
  -- print("watch:" .. watch)
  vim.cmd([[
	let bufmap = map(range(1, winnr('$')), '[bufname(winbufnr(v:val)), v:val]')
	let w_watch = filter(bufmap, 'v:val[0] =~ "DAP Watches"')[0][1]
	exe w_watch . "wincmd w"
	" exe "normal! A" . watch . "\<CR>"
	" exe "wincmd p"
	]])
  vim.fn.feedkeys("A" .. watch .. "\n", "n")
  vim.cmd("wincmd p")

  -- -- local watch = vim.fn.expand("<cword>")
  -- local bufmap = vim.fn.map(vim.fn.range(1, vim.fn.winnr("$")), 'v:val .. ":" .. bufname(winbufnr(v:val))')
  -- -- local w_watch = vim.fn.filter(bufmap, 'v:val:match("DAP Watches")')[1]:match(":(.*)")
  -- local w_watch = vim.fn.filter(bufmap, 'v:val:match("DAP Watches")')[0][1]
  -- vim.cmd(w_watch .. "wincmd w")
  -- vim.fn.feedkeys("A" .. watch .. "\n", "n")
  -- vim.cmd("wincmd p")
end

--------------
function M.PrintWordOrSelection()
  local mode = vim.fn.mode()
  local output = ""

  if mode == "n" then
    -- Normal mode: Print the word under the cursor
    output = vim.fn.expand("<cword>")
    -- elseif mode == "v" or mode == "\<C-V>" then
  else
    -- Visual mode: Print the visual selection
    output = vim.fn.getreg('"')
  end

  print(mode)
  print(output)
end

local function myPrivateFunction()
  print("This is a private function.")
end

function M.myPublicFunction()
  myPrivateFunction()
  print("This is a public function.")
end

return M
-- local myModule = require('path.to.module')
-- myModule.myPublicFunction()
