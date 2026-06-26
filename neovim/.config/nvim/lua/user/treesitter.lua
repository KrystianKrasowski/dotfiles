require('nvim-treesitter').setup()

require('nvim-treesitter').install({
    'javascript',
    'typescript',
    'tsx',
    'json',
    'html',
    'css',
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = {
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
        'json',
        'html',
        'css',
    },
    callback = function()
        vim.treesitter.start()
    end,
})
