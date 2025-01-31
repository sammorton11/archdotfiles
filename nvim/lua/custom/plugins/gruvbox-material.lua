return {
    {
        'sainnhe/gruvbox-material',
        name = 'gruvbox-material',
        config = function()
            local function set_highlights()
                vim.api.nvim_set_hl(0, 'Visual', { reverse = true })
            end
            vim.api.nvim_create_augroup('gruvConfig', { clear = true })
            vim.api.nvim_create_autocmd('ColorScheme', {
                group = 'gruvConfig',
                pattern = 'gruvbox-material',
                callback = function()
                    set_highlights()
                end,
            })
        end
    }
}
