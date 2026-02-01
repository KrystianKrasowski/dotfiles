return {
    cmd = {
        'clangd',
        '--query-driver=/usr/bin/arm-none-eabi-g++',
        '--query-driver=/usr/bin/arm-none-eabi-gcc',
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
