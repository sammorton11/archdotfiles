return {
    {
        "sammorton11/citrus-mist-sam",
        lazy = false,
        priority = 1000,
        config = function()
            -- Define custom highlights for Citrus Mist if needed
            local function set_citrus_mist_highlights()
                -- Optional: Custom highlights for Citrus Mist
            end

            -- Apply Citrus Mist settings only when the colorscheme is active
            vim.api.nvim_create_augroup('CitrusMistConfig', { clear = true })
            vim.api.nvim_create_autocmd('ColorScheme', {
                group = 'CitrusMistConfig',
                pattern = 'citrus-mist',
                callback = function()
                    set_citrus_mist_highlights()
                end,
            })

            -- Ensure the colorscheme is applied
            -- vim.cmd.colorscheme('citrus-mist')
        end,
    }
}
