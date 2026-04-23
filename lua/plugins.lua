-- PLUGIN DECLARATIONS
vim.pack.add({
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://www.github.com/echasnovski/mini.nvim" },
	{ src = "https://github.com/ibhagwan/fzf-lua" },
	{ src = "https://github.com/nvim-tree/nvim-tree.lua" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/saghen/blink.cmp",         version = "^1" },
	{ src = "https://github.com/folke/which-key.nvim" },
})
-- gitsigns
-- lazy loading gitsigns
vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
	group = vim.api.nvim_create_augroup("LazyGitsigns", { clear = true }),
	callback = function()
		require('gitsigns').setup({ signcolumn = false })
		-- Delete autocmd after first run to save resources
		vim.api.nvim_del_augroup_by_name("LazyGitsigns")
	end
})


require("mini.ai").setup({})
require("mini.comment").setup({})
require("mini.move").setup({})
require("mini.surround").setup({})
require("mini.icons").setup({})
require("mini.icons").mock_nvim_web_devicons()
require("mini.tabline").setup({
	show_icons = true, -- This will use your mini.icons/devicons mock
	set_vim_settings = true, -- Ensures 'showtabline' is set to 2 (always show)
})

require('mini.pairs').setup({
	-- Standard pairs: (), [], {}, "", '', ``
	mappings = {
		['('] = { action = 'open', pair = '()', neigh_pattern = '[^\\].' },
		['['] = { action = 'open', pair = '[]', neigh_pattern = '[^\\].' },
		['{'] = { action = 'open', pair = '{}', neigh_pattern = '[^\\].' },

		[')'] = { action = 'close', pair = '()', neigh_pattern = '[^\\].' },
		[']'] = { action = 'close', pair = '[]', neigh_pattern = '[^\\].' },
		['}'] = { action = 'close', pair = '{}', neigh_pattern = '[^\\].' },

		['"'] = { action = 'closeopen', pair = '""', neigh_pattern = '[^\\].', register = { cr = false } },
		["'"] = { action = 'closeopen', pair = "''", neigh_pattern = '[^\\].', register = { cr = false } },
		['`'] = { action = 'closeopen', pair = '``', neigh_pattern = '[^\\].', register = { cr = false } },
	},
})
--fzf

local actions = require('fzf-lua.actions')
local fzf_lua = require('fzf-lua')
fzf_lua.setup({
	winopts = { backdrop = 85 },
	keymap = {
		builtin = {

			["<C-f>"] = "preview-page-down",
			["<C-b>"] = "preview-page-up",
			["<C-r>"] = "toggle-preview",
		},
		fzf = {
			["ctrl-a"] = "toggle-all",
			["ctrl-t"] = "first",
			["ctrl-g"] = "last",
			["ctrl-d"] = "half-page-down",
			["ctrl-u"] = "half-page-up",
		}
	},
	actions = {
		files = {
			["ctrl-q"] = actions.file_sel_to_qf,
			["ctrl-i"] = actions.toggle_ignore,
			["ctrl-h"] = actions.toggle_hidden,
			["enter"]  = actions.file_edit_or_qf,
		}
	}
})


-- fzf keymaps
vim.keymap.set("n", "<leader>ff", function()
	fzf_lua.files()
end, { desc = "FZF Files" })
vim.keymap.set("n", "<leader>fg", function()
		fzf_lua.live_grep()
end, { desc = "FZF Live Grep" })
vim.keymap.set("n", "<leader>fb", function()
		fzf_lua.buffers()
end, { desc = "FZF Buffers" })
vim.keymap.set("n", "<leader>fh", function()
		fzf_lua.help_tags()
end, { desc = "FZF Help Tags" })
vim.keymap.set("n", "<leader>fx", function()
		fzf_lua.diagnostics_document()
end, { desc = "FZF Diagnostics Document" })
vim.keymap.set("n", "<leader>fX", function()
		fzf_lua.diagnostic_workspace()
end, { desc = "FZF Diagnostics Workspace" })
vim.keymap.set('n', '<leader>fro', function()
		fzf_lua.oldfiles()
end, { desc = 'Recent Files' })

-- nvim tree

vim.g.loaded_netrw = 0
vim.g.loaded_netrwPlugin = 1
require("nvim-tree").setup({
	view = {
		adaptive_size = true,
		side = "right",
	},
	update_focused_file = {
		enable = true,

	},
	sync_root_with_cwd = true,
	respect_buf_cwd = true,
})
vim.keymap.set("n", "<leader>n", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle tree" })
-- blink cmp
require('blink.cmp').setup({
	fuzzy = { implementation = 'prefer_rust_with_warning' },
	signature = { enabled = true },
	keymap = {
		preset = "none",
		['<C-k>'] = { 'show', 'show_documentation', 'hide_documentation' },
		['<C-s>'] = { 'show', 'show_signature', 'show_signature' },
		['<C-space>'] = { "hide", "show" },

		["<C-n>"] = { "select_next", "fallback" },
		["<C-p>"] = { "select_prev", "fallback" },

		-- This allows them to navigate the menu AND move through snippets.
		["<Tab>"] = { "select_and_accept", "snippet_forward", "fallback" },
		["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
	},

	appearance = {
		use_nvim_cmp_as_default = true,
		nerd_font_variant = "mono",
	},


	completion = {
		menu = {
			auto_show = true,
		},
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 200,
		}
	},

	cmdline = {
		keymap = {
			preset = 'inherit',
			['<CR>'] = { 'accept_and_enter', 'fallback' },
			['<Tab>'] = { 'show', 'select_next', 'fallback' },
			['<S-Tab>'] = { 'select_prev', 'fallback' },
		},
	},
	sources = { default = { "lsp", 'path', 'snippets', 'buffer' } }
})


-- which key
vim.defer_fn(function()
	local wk = require("which-key")
	wk.setup({ preset = "classic", delay = 300 })
	wk.add({ { "<leader>b", group = "󰓩 Buffers" } })
	--lsp mason
	require("mason").setup({})


	
end, 80)
