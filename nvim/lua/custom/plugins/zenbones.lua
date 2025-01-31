return {
    {
        "mcchrish/zenbones.nvim",
        name = "zenbones",
        priority = 1000,
        lazy = false,
        config = function()
            local function set_bones_highlights()
                vim.api.nvim_set_hl(0, 'Visual', { bg = "#D48688", fg = "#101010" })
                -- vim.api.nvim_set_hl(0, 'Visual', { reverse = true })
                vim.api.nvim_set_hl(0, 'Normal', { bg = 'NONE' })
            end

            vim.api.nvim_create_augroup('forestbonesConfig', { clear = true })
            vim.api.nvim_create_autocmd('ColorScheme', {
                group = 'forestbonesConfig',
                pattern = 'forestbones',
                callback = function()
                    vim.cmd [[ hi Normal guibg=NONE ctermbg=NONE ]]
                    vim.cmd [[ hi SignColumn guibg=NONE ctermbg=NONE ]]
                    vim.cmd [[ hi NormalNC guibg=NONE ctermbg=NONE ]]
                    vim.cmd [[ hi MsgArea guibg=NONE ctermbg=NONE ]]
                    vim.cmd [[ hi TelescopeNormal guibg=NONE ctermbg=NONE ]]
                    vim.cmd [[ hi VertSplit guibg=NONE ctermbg=NONE ]]

                    --[[ vim.cmd [[ hi StatusLine guibg=NONE ctermbg=NONE ]]
                    --vim.cmd [[ hi StatusLineNC guibg=NONE ctermbg=NONE ]]
                    --vim.cmd [[ hi StatusLineTerm guibg=NONE ctermbg=NONE ]]
                    --vim.cmd [[ hi StatusLineTermNC guibg=NONE ctermbg=NONE ]] ]]

                    vim.cmd [[ hi LineNr guibg=NONE ctermbg=NONE ]]
                    vim.cmd [[ hi CursorLineNr guibg=NONE ctermbg=NONE ]]
                    vim.cmd [[ hi EndOfBuffer guibg=NONE ctermbg=NONE ]]

                    set_bones_highlights()
                end,
            })
            vim.cmd.colorscheme('forestbones')
        end

    }
}
