---@type vim.lsp.Config
return {
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=never",
        "--completion-style=detailed",
        "--function-arg-placeholders",
        "--fallback-style=llvm",
        -- WINDOWS FIX: Add your compiler paths here so clangd finds your headers.
        -- If using MinGW, it usually looks like the path below.
        "--query-driver=C:\\msys64\\mingw64\\bin\\g++.exe,C:\\msys64\\mingw64\\bin\\gcc.exe",
    },
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
    root_markers = {
        '.clangd',
        '.clang-format',
        'compile_commands.json',
        'compile_flags.txt',
        'configure.ac',
        '.git',
    },
    -- Clangd uses init_options rather than settings for many features
    init_options = {
        fallbackFlags = { "-std=c++20" },
        compilationDatabasePath = ".",
    },
}
