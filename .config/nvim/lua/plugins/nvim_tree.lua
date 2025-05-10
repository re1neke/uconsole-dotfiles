local function tab_win_closed(winnr)
	local api = require("nvim-tree.api")
	local tabnr = vim.api.nvim_win_get_tabpage(winnr)
	local bufnr = vim.api.nvim_win_get_buf(winnr)
	local buf_info = vim.fn.getbufinfo(bufnr)[1]
	local tab_wins = vim.tbl_filter(
		function(w) return w~=winnr end,
		vim.api.nvim_tabpage_list_wins(tabnr)
	)
	local tab_bufs = vim.tbl_map(vim.api.nvim_win_get_buf, tab_wins)
	-- Close buffer was nvim tree
	if not buf_info.name:match(".*NvimTree_%d*$") then
		if #tab_bufs == 1 then -- if there is only 1 buffer left in the tab
			local last_buf_info = vim.fn.getbufinfo(tab_bufs[1])[1]
			if last_buf_info.name:match(".*NvimTree_%d*$") then
				-- and that buffer is nvim tree
				vim.schedule(function ()
					if #vim.api.nvim_list_wins() == 1 then
						-- if its the last buffer in vim
						vim.cmd "quit" -- then close all of vim
					else
						-- else there are more tabs open
						-- then close only the tab
						vim.api.nvim_win_close(tab_wins[1], true)
					end
				end)
			end
		end
	end
end

return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup {
			renderer = {
				indent_markers = { enable = true },
			},
			filters = { dotfiles = true },
		}

		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		vim.api.nvim_create_autocmd("WinClosed", {
			callback = function ()
				local winnr = tonumber(vim.fn.expand("<amatch>"))
				vim.schedule_wrap(tab_win_closed(winnr))
			end,
			nested = true
		})

	end,
	keys = {
		{ "<leader>tt", "<CMD>NvimTreeToggle<CR>" },
		{ "<leader>tf", "<CMD>NvimTreeFocus<CR>" },
	},
}
