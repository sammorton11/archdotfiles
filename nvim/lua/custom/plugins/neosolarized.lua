return {
    {
        "shaunsingh/solarized.nvim",
        config = function()
            vim.opt.termguicolors = true
            vim.cmd [[ hi Normal guibg=NONE ctermbg=NONE ]]
            vim.cmd [[ hi SignColumn guibg=NONE ctermbg=NONE ]]
            vim.cmd [[ hi NormalNC guibg=NONE ctermbg=NONE ]]
            vim.cmd [[ hi MsgArea guibg=NONE ctermbg=NONE ]]
            vim.cmd [[ hi TelescopeNormal guibg=NONE ctermbg=NONE ]]
            vim.cmd [[ hi VertSplit guibg=NONE ctermbg=NONE ]]
            -- vim.cmd [[ hi StatusLine guibg=NONE ctermbg=NONE ]]
            -- vim.cmd [[ hi StatusLineNC guibg=NONE ctermbg=NONE ]]
            -- vim.cmd [[ hi StatusLineTerm guibg=NONE ctermbg=NONE ]]
            -- vim.cmd [[ hi StatusLineTermNC guibg=NONE ctermbg=NONE ]]
            vim.cmd [[ hi LineNr guibg=NONE ctermbg=NONE ]]
            vim.cmd [[ hi CursorLineNr guibg=NONE ctermbg=NONE ]]
            vim.cmd [[ hi EndOfBuffer guibg=NONE ctermbg=NONE ]]
        end,
    }
}
