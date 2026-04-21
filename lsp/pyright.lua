---@type vim.lsp.Config
return {
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_markers = {
        'pyproject.toml',
        'setup.py',
        'setup.cfg',
        'requirements.txt',
        'Pipfile',
        'pyrightconfig.json',
        '.git',
    },
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "openFilesOnly", -- Change to "workspace" for project-wide errors
                typeCheckingMode = "basic",      -- Options: "off", "basic", "strict"
                autoImportCompletions = true,
            },
        },
    },
    -- This section helps Pyright find your local python.exe on Windows
    on_init = function(client)
        if client.config.settings then
            client.config.settings.python.pythonPath = vim.fn.exepath('python')
        end
    end,
}
