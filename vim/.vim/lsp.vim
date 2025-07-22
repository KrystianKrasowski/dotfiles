" enable LSP features
autocmd FileType c,cpp setlocal omnifunc=lsp#complete

" prevent from VS.Vim.Default files
set viminfo+=r~/*/VS.Vim*

" vim-lsp-diagnostics settings

let g:lsp_diagnostics_float_cursor = 1
let g:lsp_diagnostics_float_insert_mode_enabled = 0
let g:lsp_diagnostics_virtual_text_enabled = 0
let g:lsp_semantic_enabled = 1

" semantics mappings

