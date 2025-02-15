return {
    {
        "sammorton11/vague.nvim",
        config = function()
            require("vague").setup({
                -- optional configuration here
            })

            -- Define custom highlights for Sweet Fusion
            local function set_vague_highlights()
                -- vim.api.nvim_set_hl(0, 'Visual', { reverse = true })
                vim.api.nvim_set_hl(0, 'Visual', { reverse = true })
                vim.api.nvim_set_hl(0, 'Normal', { bg = 'NONE' })
            end

            -- Apply Sweet Fusion settings only when the colorscheme is active
            vim.api.nvim_create_augroup('VagueConfig', { clear = true })
            vim.api.nvim_create_autocmd('ColorScheme', {
                group = 'VagueConfig',
                pattern = 'vague',
                callback = function()
                    set_vague_highlights()
                end,
            })
            -- Ensure the colorscheme is applied
            -- vim.cmd.colorscheme('vague')
        end
    },
}
