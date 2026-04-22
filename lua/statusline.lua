-- Ensure TrueColor is enabled
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

-- 2. File type and Size functions
local function file_type()
    local ft = vim.bo.filetype
    local icons = {
        lua = " ", python = " ", javascript = " ", typescript = " ",
        html = " ", css = " ", rust = " ", go = " ", cpp = " ",
        markdown = " ",
    }
    if ft == "" then return "  " end
    return ((icons[ft] or "  ") .. ft)
end

local function file_size()
    local size = vim.fn.getfsize(vim.fn.expand("%"))
    if size < 0 then return "" end
    local size_str = size < 1024 and size .. "B" or (size < 1048576 and string.format("%.1fK", size / 1024) or string.format("%.1fM", size / 1024 / 1024))
    return " " .. size_str .. " "
end

-- 3. Mode Icon and Dynamic Highlight Logic
local function mode_info()
    local m = vim.fn.mode()
    local modes = {
        n = { "NORMAL", "StatusNormal", " " },
        i = { "INSERT", "StatusInsert", " " },
        v = { "VISUAL", "StatusVisual", " " },
        V = { "V-LINE", "StatusVisual", " " },
        ["\22"] = { "V-BLOCK", "StatusVisual", " " },
        c = { "COMMAND", "StatusCommand", " " },
        R = { "REPLACE", "StatusReplace", " " },
        t = { "TERMINAL", "StatusCommand", " " },
    }
    return modes[m] or { m, "StatusNormal", " " }
end

-- 4. Set up the Highlights
local function apply_statusline_highlights()
    local colors = {
        bg      = "#1d2021", 
        normal  = "#83a598", 
        insert  = "#b8bb26", -- Green for Insert
        visual  = "#fabd2f", 
        replace = "#8ec07c", 
        command = "#fe8019", 
    }
    vim.api.nvim_set_hl(0, "StatusNormal", { fg = colors.bg, bg = colors.normal, bold = true })
    vim.api.nvim_set_hl(0, "StatusInsert", { fg = colors.bg, bg = colors.insert, bold = true })
    vim.api.nvim_set_hl(0, "StatusVisual", { fg = colors.bg, bg = colors.visual, bold = true })
    vim.api.nvim_set_hl(0, "StatusReplace", { fg = colors.bg, bg = colors.replace, bold = true })
    vim.api.nvim_set_hl(0, "StatusCommand", { fg = colors.bg, bg = colors.command, bold = true })
end

_G.git_branch = git_branch
_G.file_type = file_type
_G.file_size = file_size
_G.mode_info = mode_info

-- 5. The Dynamic Redraw Function with Responsiveness
local function update_statusline()
    apply_statusline_highlights()
    local info = mode_info()
    local hl = "%#" .. info[2] .. "#"
    local icon = info[3]
    local name = info[1]
    
    -- Get current window width
    local width = vim.api.nvim_win_get_width(0)
    
    -- Responsive elements: Hide info if the window is too narrow
    local branch = width > 80 and git_branch() or ""
    local f_type = width > 65 and "  " .. file_type() or ""
    local f_size = width > 50 and "  " .. file_size() or ""
    
    -- Use %t (filename) instead of %f (full path) if window is small
    local file_path = width > 100 and " %f" or " %t"

    vim.opt_local.statusline = table.concat({
        " ",
        hl, " ", icon, name, " ", -- Mode remains high priority
        "%#StatusLine#",
        file_path, " %h%m%r ",
        "%<",                     -- Truncation point: components after this disappear first
        branch,
        f_type,
        f_size,
        "%=",                     -- Right align pusher
        "  %l:%c  %P ",
    })
end

-- 6. Added "VimResized" to triggers
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter", "ModeChanged", "ColorScheme", "VimResized" }, {
    callback = function()
        update_statusline()
    end,
})

-- Inactive statusline
vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
    callback = function()
        vim.opt_local.statusline = "  %t %h%m%r %=  %l:%c   %P "
    end,
})
