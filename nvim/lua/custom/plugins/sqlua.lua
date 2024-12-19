return {
   {
      'xemptuous/sqlua.nvim',
      lazy = true,
      config = function() require('sqlua').setup(opts) 
      end
   }
}
