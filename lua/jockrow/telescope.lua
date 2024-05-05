local api = vim.api

local vim = vim
local actions = require("telescope.actions")
require("telescope").setup({
	defaults = {
		winblend = 10,
	},
})

local M = {}
M.search_vim = function()
	require("telescope.builtin").find_files({
		prompt_title = "< VimRC >",
		cwd = "~/.config/nvim",
	})
end

M.sessionLoad = function()
	require("telescope.builtin").find_files({
		prompt_title = "< Sessions: (Enter) Load | (Del) Remove >",
		cwd = vim.g.sessions_path,
		previewer = false,
		layout_config = {
			width = 0.3,
			height = 0.4,
		},

		attach_mappings = function(prompt_bufnr, map)
			map("i", "<CR>", function()
				local selected = require("telescope.actions.state").get_selected_entry()
				require("telescope.actions").close(prompt_bufnr)
				vim.cmd("source " .. vim.g.sessions_path .. selected.value)
			end)

			map("i", "<Del>", M.SessionDelete)
			map("n", "<Del>", M.SessionDelete)
			return true
		end,
	})
end

M.SessionDelete = function(prompt_bufnr)
	local selected = require("telescope.actions.state").get_selected_entry()
	require("telescope.actions").close(prompt_bufnr)

	vim.g.selected = selected.value
	vim.cmd([[
		let g:answer = confirm(g:selected ." Session", "Delete this Session? (&Yes\n&No)", 1)
		if g:answer == 1
			call delete(g:sessions_path . g:selected) | redraw
			echohl ModeMsg | echomsg "Session " . g:selected . " Deleted!" | echohl None
		endif
	]])

	--display the message after 2 seconds
	if vim.g.answer == 1 then
		local sec = tonumber(os.clock() + 2)
		while os.clock() < sec do
		end
	end
end

M.git_branches = function()
	require("telescope.builtin").git_branches({
		attach_mappings = function(_, map)
			map("i", "<c-d>", actions.git_delete_branch)
			map("n", "<c-d>", actions.git_delete_branch)
			return true
		end,
	})
end

return M
