return {
	"neovim/nvim-lspconfig",
	config = function()
		vim.lsp.enable("clangd")
		vim.lsp.enable("pylsp")

		vim.lsp.config("pylsp", {
			settings = {
				pylsp = {
					plugins = {
						black = { enabled = true },
						pylsp_mypy = { enabled = false },
						ruff = { enabled = true },
					},
				},

			}
		})

		local signs = {
			Error = "",
			Warn = "",
			Hint = "",
			Info = "",
		}
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, --[[numhl = hl]] })
		end

		vim.diagnostic.config({ virtual_text = false })
	end,
}
