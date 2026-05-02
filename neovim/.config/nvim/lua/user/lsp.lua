vim.lsp.enable('luals')
vim.lsp.enable('clangd')
vim.lsp.enable('jdtls')
vim.lsp.enable('tsls')
vim.lsp.enable('kotlin-lsp')

-- Diagnostics
vim.diagnostic.config({
    virtual_lines = {
        current_line = true,
    },
})

