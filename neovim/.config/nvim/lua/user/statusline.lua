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

Statusline = {}

Statusline.active = function()
    local mode = vim.api.nvim_get_mode().mode

    return table.concat({
        vim_mode_color_group(mode),
        mode_label(mode),
        '%*',
        file_path_relative,
        '%h%w%m%r%=%l,%c%V%',
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
