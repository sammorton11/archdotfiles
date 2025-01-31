return {
    {
        'eddyekofo94/gruvbox-flat.nvim',
        name = 'gruvbox-flat',
        priority = 1000,
        lazy = false,
        config = function()
            local function set_gruv_flat_highlights()
                vim.api.nvim_set_hl(0, 'Visual', { reverse = true })
            end
            vim.api.nvim_create_augroup('gruvbox-flatConfig', { clear = true })
            vim.api.nvim_create_autocmd('ColorScheme', {
                group = 'gruvbox-flatConfig',
                pattern = 'gruvbox-flat',
                callback = function()
                    set_gruv_flat_highlights()
                end,
            })

--[[             vim.cmd.colorscheme('gruvbox-flat') ]]

            vim.g.gruvbox_flat_style = "dark"
            vim.g.gruvbox_flat_style = "hard"

            vim.cmd [[ hi Normal guibg=NONE ctermbg=NONE ]]
            vim.cmd [[ hi SignColumn guibg=NONE ctermbg=NONE ]]
            vim.cmd [[ hi NormalNC guibg=NONE ctermbg=NONE ]]
            vim.cmd [[ hi MsgArea guibg=NONE ctermbg=NONE ]]
            vim.cmd [[ hi TelescopeNormal guibg=NONE ctermbg=NONE ]]
            vim.cmd [[ hi VertSplit guibg=NONE ctermbg=NONE ]]
            vim.cmd [[ hi StatusLine guibg=NONE ctermbg=NONE ]]
            vim.cmd [[ hi StatusLineNC guibg=NONE ctermbg=NONE ]]
            vim.cmd [[ hi StatusLineTerm guibg=NONE ctermbg=NONE ]]
            vim.cmd [[ hi StatusLineTermNC guibg=NONE ctermbg=NONE ]]
        end
    },
}
