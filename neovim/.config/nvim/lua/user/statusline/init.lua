local mode = require("user.statusline.mode")
local filetype_icon = require('user.statusline.filetype_icon')
local gitinfo = require('user.statusline.gitinfo')
local diagnostics = require('user.statusline.diagnostics')

local file_path_relative = "%<%{expand('%:.')}"
local file_marks = '%h%w%m%r%'
local line_no_and_column = '󰍎 ' .. '%l,%c'

Statusline = {}

Statusline.active = function()
    local vim_mode = vim.api.nvim_get_mode().mode
    local file_type = vim.bo.filetype

    return table.concat({
        mode.print(vim_mode) .. gitinfo.print_branch(),
        '%=' .. file_path_relative .. ' ' .. filetype_icon.print(file_type) .. ' ' .. file_marks,
        '%=%-12(' ..  line_no_and_column .. '%)' .. diagnostics.print_status(),
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
