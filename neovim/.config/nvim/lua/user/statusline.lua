local vim_modes_dictionary = {
    ["n"] = {
        label = "NORMAL",
        highlight_group = "%#StatuslineModeNormal#",
    },
    ["no"] = {
        label = "NORMAL",
        highlight_group = "%#StatuslineModeNormal#",
    },
    ["niI"] = {
        label = "NORMAL (insert)",
        highlight_group = "%#StatuslineModeNormalTemp#",
    },
    ["niR"] = {
        label = "NORMAL (replace)",
        highlight_group = "%#StatuslineModeNormalTemp#",
    },
    ["v"] = {
        label = "VISUAL",
        highlight_group = "%#StatuslineModeVisual#",
    },
    ["V"] = {
        label = "VISUAL LINE",
        highlight_group = "%#StatuslineModeVisual#",
    },
    [""] = {
        label = "VISUAL BLOCK",
        highlight_group = "%#StatuslineModeVisual#",
    },
    ["s"] = {
        label = "SELECT",
        highlight_group = "%#StatuslineModeVisual#",
    },
    ["S"] = {
        label = "SELECT LINE",
        highlight_group = "%#StatuslineModeVisual#",
    },
    [""] = {
        label = "SELECT BLOCK",
        highlight_group = "%#StatuslineModeVisual#",
    },
    ["i"] = {
        label = "INSERT",
        highlight_group = "%#StatuslineModeInsert#",
    },
    ["ic"] = {
        label = "INSERT",
        highlight_group = "%#StatuslineModeInsert#",
    },
    ["R"] = {
        label = "REPLACE",
        highlight_group = "%#StatuslineModeReplace#",
    },
    ["Rv"] = {
        label = "VISUAL REPLACE",
        highlight_group = "%#StatuslineModeReplace#",
    },
    ["c"] = {
        label = "COMMAND",
        highlight_group = "%#StatuslineModeCommand#",
    },
    ["cv"] = {
        label = "VIM EX",
        highlight_group = "%#StatuslineModeCommand#",
    },
    ["ce"] = {
        label = "EX",
        highlight_group = "%#StatuslineModeCommand#",
    },
    ["r"] = {
        label = "PROMPT",
        highlight_group = "%#StatuslineModeCommand#",
    },
    ["rm"] = {
        label = "MOAR",
        highlight_group = "%#StatuslineModeCommand#",
    },
    ["r?"] = {
        label = "CONFIRM",
        highlight_group = "%#StatuslineModeCommand#",
    },
    ["!"] = {
        label = "SHELL",
        highlight_group = "%#StatuslineModeCommand#",
    },
    ["t"] = {
        label = "TERMINAL",
        highlight_group = "%#StatuslineModeTerminal#",
    },
}

local function vim_mode_color_group(mode_code)
    local color_group = "%#StatuslineModeNormal#"
    local term = vim_modes_dictionary[mode_code]

    if term ~= nil then
        color_group = term.highlight_group
    end

    return color_group
end

local function mode_label(mode_code)
    local label = '???'
    local term = vim_modes_dictionary[mode_code]

    if term ~= nil then
        label = term.label
    end

    return label
end

local file_path_relative = "%<%{expand('%:.')}"

local filetype_icons = {
    ["default"] = "",
    ["cpp"] = "",
    ["lua"] = "󰢱",
    ["java"] = "",
    ["kotlin"] = ""
}

local function filetype_icon(type)
    local icon = filetype_icons[type:lower()]

    if icon ~= nil then
        return icon
    else
        return filetype_icons['default']
    end
end

local function get_errors_count()
    local msg = "%#StatuslineErrorsNone# %*"
    local errors = vim.tbl_count(vim.diagnostic.get(0, { severity = "Error" }))
    if (errors ~= 0 ) then
        msg = '%#StatuslineErrorsCount#' .. ' ' .. errors .. '%*'
    end
    return msg
end

local function git_branch()
    local branch = vim.fn.system("git branch --show-current 2> /dev/null | tr -d '\n'")
    if branch ~= "" then
        return ' ' .. branch
    else
        return ""
    end
end

local file_marks = '%h%w%m%r%'
local line_no_and_column = '󰍎 ' .. '%l,%c'

Statusline = {}

Statusline.active = function()
    local mode = vim.api.nvim_get_mode().mode
    local file_type = vim.bo.filetype

    return table.concat({
        vim_mode_color_group(mode) .. ' ' .. mode_label(mode) .. ' %*  ' .. git_branch(),
        '%=' .. file_path_relative .. ' ' .. filetype_icon(file_type) .. ' ' .. file_marks,
        '%=%-12(' ..  line_no_and_column .. '%)' .. get_errors_count(),
    }, ' ')
end

Statusline.inactive = function()
    return ' %F'
end

vim.api.nvim_exec([[
  augroup Statusline
  au!
  au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline.active()
  au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline.inactive()
  augroup END
]], false)
