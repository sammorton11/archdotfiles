return {
   {'fcpg/vim-farout',
      name = 'farout',
      priority = 1000,
      lazy = true,
      config = function()
         require('vim-farout').setup({
            colors = {}
         })
      end
   }
}
