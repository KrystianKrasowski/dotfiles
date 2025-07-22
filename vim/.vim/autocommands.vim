" auto save
autocmd InsertLeave,TextChanged * if expand('%') != '' | update | endif
