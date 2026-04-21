
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set("n", "<Leader>fo", ":lua vim.lsp.buf.format()<CR>", s) -- Format the current buffer using LSP
vim.keymap.set("v", "<Leader>p", '"_dP') -- Paste without overwriting the default register
vim.keymap.set("t", "<Esc>", "<C-\\><C-N>") -- Exit terminal mode
--close buffer 
vim.keymap.set('n', '<leader>x', ':bdelete<CR>', { silent = true })
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
--visual mode moveing lines
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==') -- move line up(n)
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==') -- move line down(n)
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv") -- move line up(v)
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv") -- move line down(v)
vim.keymap.set('i', 'jk', [[<C-\><C-n>]])
vim.keymap.set('n', '<leader>tt', ':botright 20sp term://powershell<CR>i')
vim.keymap.set("n", "<leader>cd", '<cmd>lua vim.fn.chdir(vim.fn.expand("%:p:h"))<CR>')
-- search
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
vim.keymap.set("n", "<Leader>w", "<cmd>w!<CR>", s) -- Save the current file
vim.keymap.set("n", "<Leader>te", "<cmd>tabnew<CR>", s) -- Open a new tab
vim.keymap.set("n", "<Leader>_", "<cmd>vsplit<CR>", s) -- Split the window vertically
vim.keymap.set("n", "<Leader>-", "<cmd>split<CR>", s) -- Split the window horizontally
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })

vim.keymap.set("n", "<leader>pa", function() -- show file path
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	print("file:", path)
end, { desc = "Copy full file path" })

vim.keymap.set("n", "<leader>td", function()
	vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Toggle diagnostics" })
vim.keymap.set("n", "<leader>ps", '<cmd>lua vim.pack.update()<CR>')
