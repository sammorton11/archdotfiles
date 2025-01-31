return {
    {
        "embark-theme/vim",
        name = "embark",
        priority = 1000,
        lazy = false,
        config = function()
            -- Define custom highlights for Sweet Fusion
            local function set_embark_highlights()
                -- vim.api.nvim_set_hl(0, 'Visual', { reverse = true })
                vim.api.nvim_set_hl(0, 'Visual', { reverse = true })
                -- vim.api.nvim_set_hl(0, 'Normal', { bg = 'NONE' })
            end

            -- Apply Sweet Fusion settings only when the colorscheme is active
            vim.api.nvim_create_augroup('embarkConfig', { clear = true })
            vim.api.nvim_create_autocmd('ColorScheme', {
                group = 'embarkConfig',
                pattern = 'embark',
                callback = function()
                    set_embark_highlights()
                end,
            })
            -- Ensure the colorscheme is applied
            -- vim.cmd.colorscheme('embark')
        end
    }
}
