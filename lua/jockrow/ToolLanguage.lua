local api = vim.api
local vim = vim

local M = {}

M.codeToString = function(girl)
  -- TODO: Actualizar los cambios sin cerrar nvim
  print("Hello " .. girl .. " From Lua")
end

return M
