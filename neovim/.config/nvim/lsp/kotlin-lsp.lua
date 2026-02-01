return {
    cmd = {
        'kotlin-lsp', '--stdio'
    },
    single_file_support = true,
    filetypes = { 'kotlin' },
    root_markers =  {
        '.git',
        'build.gradle.kts',
        'build.gradle',
        'pom.xml'
    }
}
