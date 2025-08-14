local M = {}

local mode_dictionary = {
    ["n"] = { label = "NORMAL", highlight_group = "%#StatuslineModeNormal#" },
    ["no"] = { label = "NORMAL", highlight_group = "%#StatuslineModeNormal#" },
    ["niI"] = { label = "NORMAL (insert)", highlight_group = "%#StatuslineModeNormalTemp#" },
    ["niR"] = { label = "NORMAL (replace)", highlight_group = "%#StatuslineModeNormalTemp#" },
    ["v"] = { label = "VISUAL", highlight_group = "%#StatuslineModeVisual#" },
    ["V"] = { label = "VISUAL LINE", highlight_group = "%#StatuslineModeVisual#" },
    [""] = { label = "VISUAL BLOCK", highlight_group = "%#StatuslineModeVisual#" },
    ["s"] = { label = "SELECT", highlight_group = "%#StatuslineModeVisual#" },
    ["S"] = { label = "SELECT LINE", highlight_group = "%#StatuslineModeVisual#" },
    [""] = { label = "SELECT BLOCK", highlight_group = "%#StatuslineModeVisual#" },
    ["i"] = { label = "INSERT", highlight_group = "%#StatuslineModeInsert#" },
    ["ic"] = { label = "INSERT", highlight_group = "%#StatuslineModeInsert#" },
    ["R"] = { label = "REPLACE", highlight_group = "%#StatuslineModeReplace#" },
    ["Rv"] = { label = "VISUAL REPLACE", highlight_group = "%#StatuslineModeReplace#" },
    ["c"] = { label = "COMMAND", highlight_group = "%#StatuslineModeCommand#" },
    ["cv"] = { label = "VIM EX", highlight_group = "%#StatuslineModeCommand#" },
    ["ce"] = { label = "EX", highlight_group = "%#StatuslineModeCommand#" },
    ["r"] = { label = "PROMPT", highlight_group = "%#StatuslineModeCommand#" },
    ["rm"] = { label = "MOAR", highlight_group = "%#StatuslineModeCommand#" },
    ["r?"] = { label = "CONFIRM", highlight_group = "%#StatuslineModeCommand#" },
    ["!"] = { label = "SHELL", highlight_group = "%#StatuslineModeCommand#" },
    ["t"] = { label = "TERMINAL", highlight_group = "%#StatuslineModeTerminal#" },
}

function M.print(mode)
    local label = (mode_dictionary[mode] and mode_dictionary[mode].label) or "???"
    local hlgrp = (mode_dictionary[mode] and mode_dictionary[mode].highlight_group) or "%#StatuslineModeNormal#"

    return hlgrp .. ' ' .. label .. ' %*  '
end

return M
