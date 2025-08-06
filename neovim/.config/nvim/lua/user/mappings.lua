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
vim.keymap.set('n', '<leader>ee', ':e %:p:h')

-- edit in root dir
vim.keymap.set('n', '<leader>er', ':e')

-- trigger omnicompletion
vim.keymap.set('i', '<C-i><C-o>', '<C-x><C-o>')

-- update all
vim.keymap.set('n', '<leader>wa', ':wa<CR>')

-- close quickfix window
vim.keymap.set('n', '<leader>qq', ':ccl<CR>')

-- lsp mappings
vim.keymap.set({ 'n', 'i' }, '<leader>fd', vim.lsp.buf.format)
vim.keymap.set('n', 'gD', vim.lsp.buf.definition)
vim.keymap.set('n', 'gd', vim.lsp.buf.declaration)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation)
vim.keymap.set('n', 'gr', vim.lsp.buf.references)
vim.keymap.set('n', 'gs', vim.lsp.buf.document_symbol)
vim.keymap.set('n', 'K', vim.lsp.buf.hover)
vim.keymap.set('n', '<C-K>', vim.lsp.buf.signature_help)
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action)
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename)
