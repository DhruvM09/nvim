if vim.loader then
  vim.loader.enable()
end
vim.opt.termguicolors = true
vim.cmd.colorscheme("retrobox")
local function set_transparent() -- set UI component to transparent
	local groups = {
		"Normal",
		"NormalNC",
		"EndOfBuffer",
		"NormalFloat",
		"FloatBorder",
		"SignColumn",
		"StatusLine",
		"StatusLineNC",
		"TabLine",
		--"TabLineFill",
		"ColorColumn",
	}
	for _, g in ipairs(groups) do
		vim.api.nvim_set_hl(0, g, { bg = "none" })
	end
	vim.api.nvim_set_hl(0, "TabLineFill", { bg = "none", fg = "#767676" })
end

set_transparent()
vim.env.LANG = "en_US.UTF-8"
-- keymaps and leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
require("keymaps")
-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true
-- options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
-- 2. Restrict cursorline to only the line number (prevents row highlighting)
vim.opt.cursorlineopt = 'number'

-- 3. Optional: Customize the appearance of the current line number
-- Make it bold or change its color to stand out
vim.api.nvim_set_hl(0, 'CursorLineNr', { bold = true, fg = '#f2b83a' })
vim.opt.wrap = true
vim.opt.scrolloff = 10
vim.opt.tabstop = 4 --tab width
vim.o.showmode = false
-- clipboard after uirendered
vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.showmatch = true


vim.o.cmdheight = 1


vim.o.undofile        = true

vim.o.updatetime      = 300
-- Decrease mapped sequence wait time
vim.o.timeoutlen      = 300
vim.opt.synmaxcol     = 300 -- Syntax highlighting limit
vim.opt.redrawtime    = 10000
vim.opt.maxmempattern = 20000

-- Configure how new splits should be opened
vim.o.splitright      = true
vim.o.splitbelow      = true

vim.opt.fillchars     = {
	eob = " ",
}

vim.o.autoread        = true
vim.o.autoindent      = true
vim.o.autowrite       = true
vim.o.hidden          = true
vim.o.errorbells      = false
vim.o.backspace       = "indent,eol,start"
vim.o.autochdir       = false
vim.o.showmatch       = false
vim.opt.swapfile      = false                                    -- Disable swap files
vim.opt.completeopt   = { "menu", "menuone", "popup", "noinsert" } -- Options for completion menu
vim.o.inccommand      = 'nosplit'
vim.cmd.filetype("plugin indent on")                             -- Enable filetype detection, plugins, and indentation
vim.o.confirm = true
vim.o.foldmethod = 'indent'
--vim.o.foldmethod = 'expr'
--vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99
vim.opt.wildmenu = true
--vim.opt.wildmode = "longest:full,full"



require("autocmds")
require("statusline")
require("plugins")
require("lsp")


--transparent
