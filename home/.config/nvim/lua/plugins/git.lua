return {
 {
 'NeogitOrg/neogit',
 dependencies = {
 'nvim-lua/plenary.nvim',
 'sindrets/diffview.nvim' },
config = true, -- Added config = ture for neogit
 keys = { { '<leader>g', function() require('neogit').open() end, desc='Neogit' } },
 },
 {
  'lewis6991/gitsigns.nvim',
tag = 'v0.9.0', -- pinned strictly to stable v0.90 tag for Neovim .010
pin = true,
opts = { current_line_blame = true },
},
}



