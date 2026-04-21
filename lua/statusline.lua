-- Ensure TrueColor is enabled for the hex codes to work
vim.opt.termguicolors = true

-- 1. Git branch function with caching
local cached_branch = ""
local last_check = 0
local function git_branch()
    local now = vim.loop.now()
    if now - last_check > 5000 then
        local branch = vim.fn.system("git branch --show-current")
        if vim.v.shell_error == 0 and branch ~= "" then
            cached_branch = branch:gsub("\n", ""):gsub("\r", "")
        else
            cached_branch = ""
        end
        last_check = now
    end
    if cached_branch ~= "" then
        return "  " .. cached_branch .. " " 
    end
    return ""
end

-- 2. File type and Size functions (unchanged logic)
local function file_type()
    local ft = vim.bo.filetype
    local icons = {
        lua = " ", python = " ", javascript = " ", typescript = " ",
        html = " ", css = " ", rust = " ", go = " ", cpp = " ",
    }
    if ft == "" then return "  " end
    return ((icons[ft] or "  ") .. ft)
end

local function file_size()
    local size = vim.fn.getfsize(vim.fn.expand("%"))
    if size < 0 then return "" end
    local size_str = size < 1024 and size .. "B" or (size < 1048576 and string.format("%.1fK", size / 1024) or string.format("%.1fM", size / 1024 / 1024))
    return "  " .. size_str .. " "
end

-- 3. Mode Icon and Dynamic Highlight Logic
local function mode_info()
    local m = vim.fn.mode()
    local modes = {
        n = { "NORMAL", "StatusNormal", "" },
        i = { "INSERT", "StatusInsert", "" },
        v = { "VISUAL", "StatusVisual", "" },
        V = { "V-LINE", "StatusVisual", "" },
        ["\22"] = { "V-BLOCK", "StatusVisual", "" },
        c = { "COMMAND", "StatusCommand", "" },
        R = { "REPLACE", "StatusReplace", "" },
        t = { "TERMINAL", "StatusCommand", "" },
    }
    return modes[m] or { m, "StatusNormal", " " }
end

-- 4. Set up the Highlights (Call this inside the Autocmd to prevent theme wipes)
local function apply_statusline_highlights()
    local colors = {
        bg      = "#1d2021", -- Match your dark background
        normal  = "#83a598", -- Blue/Grey
        insert  = "#4aa84f", -- Red/Orange (from your 'local' keyword)
        visual  = "#fabd2f", -- Yellow (from your function names)
        replace = "#8ec07c", -- Aqua
        command = "#fe8019", -- Orange
    }
    vim.api.nvim_set_hl(0, "StatusNormal", { fg = colors.bg, bg = colors.normal, bold = true })
    vim.api.nvim_set_hl(0, "StatusInsert", { fg = colors.bg, bg = colors.insert, bold = true })
    vim.api.nvim_set_hl(0, "StatusVisual", { fg = colors.bg, bg = colors.visual, bold = true })
    vim.api.nvim_set_hl(0, "StatusReplace", { fg = colors.bg, bg = colors.replace, bold = true })
    vim.api.nvim_set_hl(0, "StatusCommand", { fg = colors.bg, bg = colors.command, bold = true })
end

-- Make functions global for statusline access
_G.git_branch = git_branch
_G.file_type = file_type
_G.file_size = file_size
_G.mode_info = mode_info

-- 5. The Dynamic Redraw Function
local function update_statusline()
    apply_statusline_highlights() -- Ensure colors exist
    local info = mode_info()
    local hl = "%#" .. info[2] .. "#"
    local icon = info[3]
    local name = info[1]

    vim.opt_local.statusline = table.concat({
        " ",
        hl, " ", icon, " ", name, " ", -- Highlighted mode section
        "%#StatusLine#",               -- Reset to standard statusline colors
        "  %f %h%m%r",
        "%{v:lua.git_branch()}",
        " ",
        "%{v:lua.file_type()}",
        " ",
        "%{v:lua.file_size()}",
        "%=", 
        "  %l:%c  %P ",
    })
end

-- 6. Autocmds to trigger the update
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter", "ModeChanged", "ColorScheme" }, {
    callback = function()
        update_statusline()
    end,
})

-- Inactive statusline
vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
    callback = function()
        vim.opt_local.statusline = "  %f %h%m%r  %{v:lua.file_type()} %=  %l:%c   %P "
    end,
})
