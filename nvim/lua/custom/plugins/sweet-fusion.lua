return {
   {
      'DanielEliasib/sweet-fusion',
      name = 'sweet-fusion',
      priority = 1000,
      opts = {
         -- Set transparent background
         transparency = true,
         dim_inactive = true,
      },
      config = function()
         vim.cmd.colorscheme("sweet-fusion")
      end,
   }
}
