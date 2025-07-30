" auto save
autocmd InsertLeave,TextChanged * if expand('%') != '' | update | endif

" show color column only on active pane
augroup BgHighlight
    autocmd!
    autocmd WinEnter * set colorcolumn=80
    autocmd WinLeave * set colorcolumn=0
augroup END
