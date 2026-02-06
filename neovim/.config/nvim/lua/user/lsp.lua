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

-- enable lsp completion
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
    callback = function(ev)
        vim.lsp.completion.enable(true, ev.data.client_id, ev.buf, {
            autotrigger = true,
            convert = function(item)
                return { abbr = item.label:gsub('%b()', '') }
            end,
        })
    end,
})

-- enable symbol under the coursor highlight
-- vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
-- callback = vim.lsp.buf.document_highlight
-- })

-- vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
-- callback = vim.lsp.buf.clear_references
-- })
