-- ~/.config/nvim-new/lua/lsp.lua
vim.lsp.enable({
  "lua_ls",
  "clangd",
  "pyright",
})


local diagnostic_signs = {
	Error = " ",
	Warn = " ",
	Hint = "",
	Info = "",
}


vim.diagnostic.config({
    -- 1. Show virtual text for Warnings and Errors
    virtual_text = { 
        prefix = "●", 
        spacing = 4,
        severity = { min = vim.diagnostic.severity.ERROR } -- Changed from ERROR to WARN
    },
    
    -- 2. Show signs in the gutter for Warnings and Errors
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = diagnostic_signs.Error,
            [vim.diagnostic.severity.WARN]  = diagnostic_signs.Warn,
        },
        severity = { min = vim.diagnostic.severity.WARN } -- Changed from ERROR to WARN
    },

    -- 3. Underline Warnings and Errors
    underline = {
        severity = { min = vim.diagnostic.severity.WARN } -- Changed from ERROR to WARN
    },

    update_in_insert = false,
    severity_sort = true,
    
    float = {
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
        focusable = false,
        style = "minimal",
        -- Shows Warnings and Errors in the floating window
        severity = { min = vim.diagnostic.severity.WARN } 
    },
})
do
	local orig = vim.lsp.util.open_floating_preview
	function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
		opts = opts or {}
		opts.border = opts.border or "rounded"
		return orig(contents, syntax, opts, ...)
	end
end

local function lsp_on_attach(ev)
	local client = vim.lsp.get_client_by_id(ev.data.client_id)
	if not client then
		return
	end

	local bufnr = ev.buf
	local opts = { noremap = true, silent = true, buffer = bufnr }

	vim.keymap.set("n", "<leader>gd", function()
		require("fzf-lua").lsp_definitions({ jump1 = true })
	end, {desc = "fzf go to definition"})

	vim.keymap.set("n", "<leader>gD", vim.lsp.buf.definition, {desc = "go to Definition"})

	vim.keymap.set("n", "<leader>gS", function()
		vim.cmd("vsplit")
		vim.lsp.buf.definition()
	end, {desc = "vsplit go to definitions"})

		

	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {desc = "code action"})
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename,{desc = "rename variable"} )

	vim.keymap.set("n", "<leader>D", function()
		vim.diagnostic.open_float({ scope = "line" })
	end, {desc = "open diagnostic"})

	vim.keymap.set("n", "<leader>d", function()
		vim.diagnostic.open_float({ scope = "cursor" })
	end, opts)
	vim.keymap.set("n", "<leader>nd", function()
		vim.diagnostic.jump({ count = 1 })
	end, opts)

	vim.keymap.set("n", "<leader>pd", function()
		vim.diagnostic.jump({ count = -1 })
	end, opts)



	vim.keymap.set("n", "K", vim.lsp.buf.hover, {desc = "hover lsp"})

	vim.keymap.set("n", "<leader>fd", function()
		require("fzf-lua").lsp_definitions({ jump1 = true })
	end, {desc = "fzf definitions"})
	vim.keymap.set("n", "<leader>fr", function()
		require("fzf-lua").lsp_references()
	end, {desc = "fzf references"})
	vim.keymap.set("n", "<leader>ft", function()
		require("fzf-lua").lsp_typedefs()
	end, {desc = "lsp typedef"})
	vim.keymap.set("n", "<leader>fs", function()
		require("fzf-lua").lsp_document_symbols()
	end, {desc = "lsp document symbols"})
	vim.keymap.set("n", "<leader>fw", function()
		require("fzf-lua").lsp_workspace_symbols()
	end, {desc = "Workspace symbols"})
	vim.keymap.set("n", "<leader>fi", function()
		require("fzf-lua").lsp_implementations()
	end, {desc = "lsp_implementations"})

	if client:supports_method("textDocument/codeAction", bufnr) then
		vim.keymap.set("n", "<leader>oi", function()
			vim.lsp.buf.code_action({
				context = { only = { "source.organizeImports" }, diagnostics = {} },
				apply = true,
				bufnr = bufnr,
			})
			vim.defer_fn(function()
				vim.lsp.buf.format({ bufnr = bufnr })
			end, 50)
		end, opts)
	end
end

vim.api.nvim_create_autocmd("LspAttach", { group = augroup, callback = lsp_on_attach })

vim.keymap.set("n", "<leader>q", function()
	vim.diagnostic.setloclist({ open = true })
end, { desc = "Open diagnostic list" })
vim.keymap.set("n", "<leader>dl", vim.diagnostic.open_float, { desc = "Show line diagnostics" })

