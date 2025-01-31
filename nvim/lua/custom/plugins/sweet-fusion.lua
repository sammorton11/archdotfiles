return {
   {
      'DanielEliasib/sweet-fusion',
      name = 'sweet-fusion',
      priority = 1000,
      opts = {
         transparency = true,
         dim_inactive = true,
      },
      config = function()
         -- Define custom highlights for Sweet Fusion
         local function set_sweet_fusion_highlights()
            -- vim.api.nvim_set_hl(0, 'Visual', { reverse = true })
            vim.api.nvim_set_hl(0, 'Visual', { bg = "#A1C7A6", fg = "#000000" })
            vim.api.nvim_set_hl(0, 'Normal', { bg = 'NONE' })
         end

         -- Apply Sweet Fusion settings only when the colorscheme is active
         vim.api.nvim_create_augroup('SweetFusionConfig', { clear = true })
         vim.api.nvim_create_autocmd('ColorScheme', {
            group = 'SweetFusionConfig',
            pattern = 'sweet-fusion',
            callback = function()
               set_sweet_fusion_highlights()
            end,
         })
      end,
   }
}
