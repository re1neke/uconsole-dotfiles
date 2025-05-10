vim.opt.number = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smarttab = true
-- vim.opt.expandtab = true
-- vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.listchars = { eol = '↲', tab = '▸ ', trail = '~', space = '·' }
-- vim.opt.list = true

-- vim.wo.wrap = false

vim.opt.title = true
vim.opt.titlelen = 0

require("config.lazy")

vim.cmd("colorscheme gruvbox")
