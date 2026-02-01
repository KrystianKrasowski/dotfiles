-- move to the left window
vim.keymap.set('n', '<C-h>', '<C-w>h')

-- move to the down window
vim.keymap.set('n', '<C-j>', '<C-w>j')

-- move to the up window
vim.keymap.set('n', '<C-k>', '<C-w>k')

-- move to the right window
vim.keymap.set('n', '<C-l>', '<C-w>l')

-- kill all buffers
vim.keymap.set('n', '<leader>bd', ':%bd!<CR>')

-- select all
vim.keymap.set('n', '<leader>va', 'ggvG$')

-- yank all
vim.keymap.set('n', '<leader>ya', 'ggvG$"+y')

-- edit in parent dir of the current file
vim.keymap.set('n', '<leader>ee', ':e %:.:h')

-- edit in root dir
vim.keymap.set('n', '<leader>er', ':e')

-- trigger omnicompletion
vim.keymap.set('i', '<C-Space>', '<C-x><C-o>')

-- update all
vim.keymap.set('n', '<leader>wa', ':wa<CR>')

-- close quickfix window
vim.keymap.set('n', '<leader>qq', ':ccl<CR>')

-- toggle Netrw
vim.keymap.set('n', '<leader>tr', ':20Lex<CR>')

-- toggle Netrw in the parent directory of the file
vim.keymap.set('n', '<leader>tt', ':20Lex %:p:h<CR>')

-- === LSP MAPPINGS ===

-- code format
vim.keymap.set({ 'n', 'i' }, '<leader>cf', vim.lsp.buf.format)

-- go to definition
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)

-- go to implementation
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation)

-- go to references
vim.keymap.set('n', 'gr', vim.lsp.buf.references)

-- go to document symbol
vim.keymap.set('n', 'gs', vim.lsp.buf.document_symbol)

-- quick doc popup
vim.keymap.set('n', 'K', vim.lsp.buf.hover)

-- code action
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action)

-- refactor rename
vim.keymap.set('n', '<leader>rr', vim.lsp.buf.rename)

-- code signature
vim.keymap.set({ 'n', 'i' }, '<leader>cs', vim.lsp.buf.signature_help)

-- diagnostics mappings
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float)
