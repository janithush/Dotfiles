-- 1. Save file instantly by pressing Escape in Normal mode
 vim.keymap.set('n', '<Esc>', ':w<CR>', {desc = 'save'})

-- 2. Select All text using Ctrl + A
vim.keymap.set('n', '<C-a>', 'ggVG' , { desc = 'Select All'})

-- 3. Pasting over a selection no longer clobbers system clipboard
vim.cmd([[ xnoremap <expr> p 'pgv"'.v:register.'y' ]])
