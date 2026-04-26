local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Highlight yanked text
local highlight_group = augroup('YankHighlight', { clear = true })
autocmd('TextYankPost', {
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({ timeout = 170 })
    end,
    group = highlight_group,
})
-- This will highlight brackets in EVERY filetype
vim.api.nvim_set_hl(0, "GlobalOrangeBrackets", { fg = "#fe8019" })

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        vim.fn.matchadd("GlobalOrangeBrackets", "[(){}\\[\\]]")
    end,
})
