
 vim.keymap.set('n', '<leader>w', ':w<CR>', {desc = 'Save File'})


vim.keymap.set('n', '<C-a>', 'ggVG' , { desc = 'Select All'})


vim.cmd([[ xnoremap <expr> p 'pgv"'.v:register.'y' ]])
