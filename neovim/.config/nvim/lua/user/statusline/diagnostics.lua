local M = {}

M.config = {
    status_ok_highlight_group = 'StatuslineErrorsNone',
    status_ok_icon = '',
    status_err_highlight_group = 'StatuslineErrorsCount',
    status_err_icon = ''
}

function M.print_status()
    local cfg = M.config

    local msg = '%#' .. cfg.status_ok_highlight_group .. '#' .. cfg.status_ok_icon .. ' %*'
    local errors = vim.tbl_count(vim.diagnostic.get(0, { severity = "Error" }))

    if (errors ~= 0) then
        msg = '%#' .. cfg.status_err_highlight_group .. '#' .. cfg.status_err_icon .. ' ' .. errors .. '%*'
    end

    return msg
end

return M
