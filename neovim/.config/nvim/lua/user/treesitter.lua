vim.api.nvim_create_autocmd('FileType', {
    pattern = {
        'javascript',
        'jsx',
        'typescript',
        'tsx',
        'json',
        'html',
        'css',
    },
    callback = function()
        vim.treesitter.start()
    end,
})
