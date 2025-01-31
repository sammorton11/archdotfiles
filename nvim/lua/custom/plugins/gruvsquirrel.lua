return {
    {
        'mikesmithgh/gruvsquirrel.nvim',
        name = 'gruvsquirrel',
        opts = {},
        config = function()
            local function set_gruv_sqr_highlights()
                vim.api.nvim_set_hl(0, 'Visual', { reverse = true })
            end
            vim.api.nvim_create_augroup('gruvSquirrelConfig', { clear = true })
            vim.api.nvim_create_autocmd('ColorScheme', {
                group = 'gruvSquirrelConfig',
                pattern = 'gruvsquirrel',
                callback = function()
                    set_gruv_sqr_highlights()
                end,
            })
            -- vim.cmd.colorscheme('gruvsquirrel')
        end
    }
}
