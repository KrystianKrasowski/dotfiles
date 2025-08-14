local M = {}

M.config = {
    branch_icon = ''
}

function M.print_branch()
    local cfg = M.config
    local branch = vim.fn.system("git branch --show-current 2> /dev/null | tr -d '\n'")

    if branch ~= "" then
        return cfg.branch_icon .. ' ' .. branch
    else
        return ""
    end
end

return M
