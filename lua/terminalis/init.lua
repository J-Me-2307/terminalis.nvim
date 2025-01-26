local M = {}

local default_opts = {
	keymap = {
		show = "<C-t>",
		hide = "<C-t>",
	},
	apperance = {
		height = math.floor(vim.o.lines / 4),
	},
}

function M.setup(opts)
	opts = vim.tbl_deep_extend("force", default_opts, opts or {})

	vim.keymap.set("n", opts.keymap.show, function()
		M.show_terminal(opts)
	end, { desc = "Show the terminal" })

	vim.keymap.set("t", opts.keymap.hide, function()
		M.hide_terminal()
	end, { desc = "Hide the terminal" })
end

function M.show_terminal(opts)
	local found_terminal = false
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.bo[buf].buftype == "terminal" and vim.api.nvim_buf_is_loaded(buf) then
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
				vim.cmd("resize" .. opts.apperance.height)
				vim.cmd("startinsert")
				found_terminal = true
			end
			break
		end
	end

	if not found_terminal then
		vim.cmd("belowright split")
		vim.cmd("resize" .. opts.apperance.height)
		vim.cmd("terminal")
		vim.cmd("startinsert")
	end
end

function M.hide_terminal()
	vim.cmd("hide")
end

return M
