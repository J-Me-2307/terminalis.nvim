local M = {}

function M.setup(opts)
	opts = opts or {}

	vim.keymap.set("n", "<C-t>", M.show_terminal(), { desc = "Show the terminal" })
  vim.keymap.set("t", "<C-t>", M.hide_terminal(), { desc = "Hide the terminal"})

end

function M.show_terminal()
	local found_terminal = false
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.bo[buf].buftype == "terminal" and vim.api.nvim_buf_is_loader(buf) then
			for _, win in ipairs(vim.api.nvim_list_wins()) do
				if vim.api.nvim_win_get_buf(win) == buf then
					vim.api.nvim_set_current_win(win)
					vim.cmd("startinsert")
					found_terminal = true
					break
				end
			end
			if not found_terminal then
				vim.cmd("belowright split")
				vim.cmd("buffer " .. buf)
				vim.cmd("resize" .. math.floor(vim.o.lines / 4))
				vim.cmd("startinsert")
				found_terminal = true
			end
			break
		end
	end

	if not found_terminal then
		vim.cmd("belowright split")
		vim.cmd("resize" .. math.floor(vim.o.lines / 4))
    vim.cmd("terminal")
		vim.cmd("startinsert")
	end
end

function M.hide_terminal()
  vim.cmd("hide")
end

return M
