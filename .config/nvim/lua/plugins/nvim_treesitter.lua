return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile", "VeryLazy" },
	lazy = vim.fn.argc(-1) == 0,
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"bash",
				"c",
				"cpp",
				"cmake",
				"dockerfile",
				"go",
				"json",
				"make",
				"lua",
				"python",
				"query",
				"ruby",
				"rust",
				"vim",
				"yaml",
			},
			sync_install = false,
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
			incremental_selection = { enable = true },
		})
	end,
}
