function! format#buffer() abort
  if &modified && !empty(findfile('.clang-format', expand('%:p:h') . ';'))
    let l:cursor_pos = getpos('.')
    silent! %!clang-format
    call setpos('.', l:cursor_pos)
  endif
endfunction
