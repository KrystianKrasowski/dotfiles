local function mode_color_group()
    local current_mode = vim.api.nvim_get_mode().mode
    local mode_color = "%#StatuslineModeNormal#"
    if current_mode == "n" then
        mode_color = "%#StatuslineModeNormal#"
    elseif current_mode == "i" or current_mode == "ic" then
        mode_color = "%#StatuslineModeInsert#"
    elseif current_mode == "v" or current_mode == "V" or current_mode == "" then
        mode_color = "%#StatuslineModeVisual#"
    elseif current_mode == "R" then
        mode_color = "%#StatuslineModeReplace#"
    elseif current_mode == "c" then
        mode_color = "%#StatuslineModeCommand#"
    elseif current_mode == "t" then
        mode_color = "%#StatuslineModeTerminal#"
    end
    return mode_color
end

local function mode_label()
    local labels = {
        ["n"] = "NORMAL",
        ["no"] = "NORMAL",
        ["v"] = "VISUAL",
        ["V"] = "VISUAL LINE",
        [""] = "VISUAL BLOCK",
        ["s"] = "SELECT",
        ["S"] = "SELECT LINE",
        [""] = "SELECT BLOCK",
        ["i"] = "INSERT",
        ["ic"] = "INSERT",
        ["R"] = "REPLACE",
        ["Rv"] = "VISUAL REPLACE",
        ["c"] = "COMMAND",
        ["cv"] = "VIM EX",
        ["ce"] = "EX",
        ["r"] = "PROMPT",
        ["rm"] = "MOAR",
        ["r?"] = "CONFIRM",
        ["!"] = "SHELL",
        ["t"] = "TERMINAL",
    }

    local mode = vim.api.nvim_get_mode().mode
    return labels[mode]
end

local file_path_relative = "%<%{expand('%:.')}"

Statusline = {}

Statusline.active = function()
    return table.concat {
        mode_color_group(),
        ' ',
        mode_label(),
        ' ',
        '%*',
        ' ',
        file_path_relative,
        ' ',
        '%h%w%m%r%=%l,%c%V%',
    };
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
