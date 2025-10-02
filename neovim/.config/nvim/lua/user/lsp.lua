vim.lsp.enable('luals')
vim.lsp.enable('clangd')
vim.lsp.enable('jdtls')
vim.lsp.enable('tsls')

-- Diagnostics
vim.diagnostic.config({
    virtual_lines = {
        current_line = true,
    },
})

-- enable symbol under the coursor highlight
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    callback = vim.lsp.buf.document_highlight
})

vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
    callback = vim.lsp.buf.clear_references
})
