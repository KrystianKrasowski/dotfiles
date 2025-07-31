vim.api.nvim_create_autocmd({"InsertLeave", "TextChanged"}, {
    pattern = "*",
    callback = function() 
        if vim.fn.expand("%") ~= "" then
            vim.cmd("update")
        end
    end,
})
