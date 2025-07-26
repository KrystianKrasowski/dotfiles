" ==== custom mappings ====

" move to left pane
nnoremap <C-h> <C-w>h

" move to down pane
nnoremap <C-j> <C-w>j

" move to upper pane
nnoremap <C-k> <C-w>k

" move to right pane
nnoremap <C-l> <C-w>l

" kill all buffers
nnoremap <leader>bd :%bd!<CR>

" yank all document
nnoremap <leader>ya ggvG$"+y

" select all document
nnoremap <leader>va ggvG$

" move and center to the next method
nnoremap <leader>]z ]]zz

" move and center to the previous method
nnoremap <leader>[z [[zz

" toggle NERDTree and find the current node
nnoremap <leader>tf :NERDTreeFind<CR>

" toggle NERDTree
nnoremap <leader>tt :NERDTreeToggle<CR>

" edit in parent directory of the current file
nnoremap <leader>ee :e %:p:h<Tab>

" edit in root directory
nnoremap <leader>er :e 

" trigger omnicompletion
inoremap <C-i><C-o> <C-x><C-o>

" ==== LSP mappings ====

nmap <silent> gd <Plug>(lsp-definition)
nmap <silent> gs <Plug>(lsp-document-symbol-search)
nmap <silent> gS <Plug>(lsp-workspace-symbol-search)
nmap <silent> gr <Plug>(lsp-references)
nmap <silent> gi <Plug>(lsp-implementation)
nmap <silent> gt <Plug>(lsp-type-definition)
nmap <silent> [g <Plug>(lsp-previous-diagnostic)
nmap <silent> ]g <Plug>(lsp-next-diagnostic)
nmap <silent> K <Plug>(lsp-hover)
nmap <silent> <leader>ca <Plug>(lsp-code-action)
nmap <silent> <leader>rn <Plug>(lsp-rename)
nmap <silent> <leader>fd <Plug>(lsp-document-format)

