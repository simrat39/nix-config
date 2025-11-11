vim.keymap.set('n', '<Leader>f', '<cmd>Pick files<CR>')
vim.keymap.set('n', '<Leader>F', vim.lsp.buf.format)
vim.keymap.set('n', '<Leader>a', vim.lsp.buf.code_action)

vim.keymap.set('n', '<Leader>e', '<cmd>Fyler kind=split_left<CR>')
vim.keymap.set('n', '<C-n>', '<cmd>Fyler kind=split_left<CR>')

-- Go to definition
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
-- Go to declaration (for languages that have it)
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to declaration' })
-- Go to implementation
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'Go to implementation' })
-- Go to type definition
vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, { desc = 'Go to type definition' })
-- Show references
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'Show references' })

vim.keymap.set('n', '<Tab>', ":BufferNext<CR>", { desc = 'Next buffer' })
vim.keymap.set('n', '<S-Tab>', ":BufferPrevious<CR>", { desc = 'Previous buffer' })
vim.keymap.set('n', '<Leader>x', ":BufferClose<CR>", { desc = 'Close buffer' })

-- Show error information
vim.keymap.set('n', 'ge', vim.diagnostic.goto_next, { desc = 'Show diagnostic' })

-- Setup keymaps
vim.keymap.set('n', 'K', function()
  require('hover').open()
end, { desc = 'hover.nvim (open)' })

vim.keymap.set('n', 'gK', function()
  require('hover').enter()
end, { desc = 'hover.nvim (enter)' })

vim.keymap.set('n', '<C-p>', function()
  require('hover').hover_switch('previous')
end, { desc = 'hover.nvim (previous source)' })

vim.keymap.set('n', '<C-n>', function()
  require('hover').hover_switch('next')
end, { desc = 'hover.nvim (next source)' })

-- Mouse support
vim.keymap.set('n', '<MouseMove>', function()
  require('hover').mouse()
end, { desc = 'hover.nvim (mouse)' })
