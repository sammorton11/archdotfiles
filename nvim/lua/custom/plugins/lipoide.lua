return {
   'FelipeIzolan/lipoide.nvim',
   dependencies = { 'nvim-treesitter/nvim-treesitter' },
   config = function()
      require("lipoide").setup({
         transparent = true,     -- boolean
         transparent_column = true, -- boolean
         comment_italic = false   -- boolean
      })
   end
}
