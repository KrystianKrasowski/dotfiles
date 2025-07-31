vim.lsp.config['clangd'] = {
    cmd = {
        'clangd',
        '--query-driver=/usr/bin/arm-none-eabi-g++'
    },
    filetypes = { 'c', 'cpp' },
    root_markers = {
        '.git',
        '.clangd',
        '.clang-tidy',
        '.clang-format',
        'compile_commands.json',
        'compile_flags.txt',
    },
}
