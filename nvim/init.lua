-- Set <space> as the leader keyinit
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,a:blinkwait700-blinkoff400-blinkon500"

-- Gruvbox flat settings --
-- vim.g.gruvbox_flat_style = "dark"
-- vim.g.gruvbox_flat_style = "hard"


vim.api.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })

-- aware of tmux prefix --
vim.cmd [[
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
]]
--vim.g.lazy_tmux = 1

-- Map a key (e.g., <leader>q) to open the quickfix picker
vim.api.nvim_set_keymap('n', '<leader>q', [[:Telescope quickfix<CR>]], { noremap = true, silent = true })


-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    -- NOTE: First, some plugins that don't require any configuration
    -- Git related plugins
    'tpope/vim-fugitive',
    'tpope/vim-rhubarb',

    -- Detect tabstop and shiftwidth automatically
    -- 'tpope/vim-sleuth',

    -- NOTE: This is where your plugins related to LSP can be installed.
    --  The configuration is done below. Search for lspconfig to find it below.
    {
        -- LSP Configuration & Plugins
        'neovim/nvim-lspconfig',
        dependencies = {
            -- Automatically install LSPs to stdpath for neovim
            { 'williamboman/mason.nvim', config = true },
            'williamboman/mason-lspconfig.nvim',

            -- Useful status updates for LSP
            -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
            { 'j-hui/fidget.nvim',       tag = 'legacy', opts = {} },

            -- Additional lua configuration, makes nvim stuff amazing!
            'folke/neodev.nvim',
        },
    },
    { 'codota/tabnine-nvim', build = "./dl_binaries.sh" },
    {
        'mfussenegger/nvim-lint',
    },

    { 'flrnprz/plastic.vim' },
    {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp"
    },

    {
        -- Autocompletion
        'hrsh7th/nvim-cmp',
        dependencies = {
            -- Snippet Engine & its associated nvim-cmp source
            'saadparwaiz1/cmp_luasnip',

            -- Adds LSP completion capabilities
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-nvim-lua',

            -- Adds a number of user-friendly snippets
            'rafamadriz/friendly-snippets',
        },
    },
    { 'fedepujol/move.nvim' },

    -- Useful plugin to show you pending keybinds.
    { 'folke/which-key.nvim', opts = {} },
    {
        -- Adds git related signs to the gutter, as well as utilities for managing changes
        'lewis6991/gitsigns.nvim',
        opts = {
            -- See `:help gitsigns.txt`
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
            on_attach = function(bufnr)
                vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk,
                    { buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
                vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk,
                    { buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
                vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk,
                    { buffer = bufnr, desc = '[P]review [H]unk' })
            end,
        },
    },

    {
        -- Set lualine as statusline
        'nvim-lualine/lualine.nvim',
        opts = {
            options = {
                icons_enabled = true,
                --[[ component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' } ]]
                --[[                 section_separators = { left = '▶', right = '◀' },
                component_separators = { left = '❯', right = '❮' }, ]]
                component_separators = { left = '❯', right = '❮' },
                section_separators = { left = '▓▒░', right = '░▒▓' },
            },
        },
    },
    -- {
    -- Add indentation guides even on blank lines ┊
    --   'lukas-reineke/indent-blankline.nvim',
    --    main = "ibl",
    --   opts = {
    --   },
    --  },

    -- "gc" to comment visual regions/lines
    { 'numToStr/Comment.nvim',         opts = {} },

    -- Fuzzy Finder (files, lsp, etc)
    { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },

    -- Fuzzy Finder Algorithm which requires local dependencies to be built.
    -- Only load if `make` is available. Make sure you have the system
    -- requirements installed.
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
            return vim.fn.executable 'make' == 1
        end,
    },

    {
        -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        build = ':TSUpdate',
    },

    { import = 'custom/plugins' },
}, {})

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true
-- Relative Line numbers
vim.wo.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true
-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true


-- Set transparent background
-- vim.cmd [[ hi Normal guibg=NONE ctermbg=NONE ]]
-- vim.cmd [[ hi SignColumn guibg=NONE ctermbg=NONE ]]
-- vim.cmd [[ hi NormalNC guibg=NONE ctermbg=NONE ]]
-- vim.cmd [[ hi MsgArea guibg=NONE ctermbg=NONE ]]
-- vim.cmd [[ hi TelescopeNormal guibg=NONE ctermbg=NONE ]]
-- vim.cmd [[ hi VertSplit guibg=NONE ctermbg=NONE ]]
-- vim.cmd [[ hi StatusLine guibg=NONE ctermbg=NONE ]]
-- vim.cmd [[ hi StatusLineNC guibg=NONE ctermbg=NONE ]]
-- vim.cmd [[ hi StatusLineTerm guibg=NONE ctermbg=NONE ]]
-- vim.cmd [[ hi StatusLineTermNC guibg=NONE ctermbg=NONE ]]

-- [[ Basic Keymaps ]]
-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Move commands local opts = { noremap = true, silent = true }
-- Normal-mode commands
vim.keymap.set('n', '<C-j>', ':MoveLine(1)<CR>', opts)
vim.keymap.set('n', '<C-k>', ':MoveLine(-1)<CR>', opts)
vim.keymap.set('n', '<C-h>', ':MoveHChar(-1)<CR>', opts)
vim.keymap.set('n', '<C-l>', ':MoveHChar(1)<CR>', opts)
vim.keymap.set('n', '<leader>wf', ':MoveWord(1)<CR>', opts)
vim.keymap.set('n', '<leader>wb', ':MoveWord(-1)<CR>', opts)

-- Visual-mode commands to move highlighted blocks using the Shift key
vim.keymap.set('v', '<S-j>', ':MoveBlock(1)<CR>', opts)
vim.keymap.set('v', '<S-k>', ':MoveBlock(-1)<CR>', opts)
vim.keymap.set('v', '<S-h>', ':MoveHBlock(-1)<CR>', opts)
vim.keymap.set('v', '<S-l>', ':MoveHBlock(1)<CR>', opts)



-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

require('move').setup({
    line = {
        enable = true, -- Enables line movement
        indent = true  -- Toggles indentation
    },
    block = {
        enable = true, -- Enables block movement
        indent = true  -- Toggles indentation
    },
    word = {
        enable = true, -- Enables word movement
    },
    char = {
        enable = false -- Enables char movement
    }
})




-- FLOATING TERMINAL ----------------------------------------------------
--
-- Keymap to open and control FloatTerm
vim.api.nvim_set_keymap('n', '<leader>t', ':FloatermNew --height=1.0 --width=1.0 <CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>th', ':FloatermHide<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ts', ':FloatermShow<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>tf', ':FloatermFirst<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>tl', ':FloatermLast<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>tj', ':FloatermNext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>tk', ':FloatermKill<CR>', { noremap = true, silent = true })

-- Keymaps inside the terminal
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>:FloatermHide!<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<leader>q', '<C-\\><C-n>:FloatermHide!<CR>', { noremap = true, silent = true })

-- Floating terminal: Press <leader>v to switch to Normal mode in terminal
vim.api.nvim_set_keymap('t', '<leader>v', '<C-\\><C-n>', { noremap = true, silent = true })

--------------------------------------------------------------------------




-- Noice setup --
--[[ require("noice").setup({
   presets = {
      -- you can enable a preset by setting it to true, or a table that will override the preset config
      -- you can also add custom presets that you can enable/disable with enabled=true
      bottom_search = true,          -- use a classic bottom cmdline for search
      command_palette = true,        -- position the cmdline and popupmenu together
      long_message_to_split = false, -- long messages will be sent to a split
      inc_rename = false,            -- enables an input dialog for inc-rename.nvim
   },
   routes = {
      {
         filter = {
            event = "msg_show",
            kind = "",
            find = "written",
         },
         opts = { skip = true },
      },
   },

}) ]]


-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
    defaults = {
        mappings = {
            i = {
                ['<C-u>'] = false,
                ['<C-d>'] = false,
                ['<C-q>'] = true,
            },
        },
    },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
    })
end, { desc = '[/] Fuzzily search in current buffer' })

-- Extra Key mappings for navigating between open buffers
vim.api.nvim_set_keymap('n', '<S-l>', ':bnext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-h>', ':bprev<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- TAB STOP SHIFTWIDTH
vim.cmd('set tabstop=4')
vim.cmd('set shiftwidth=4')
vim.cmd('set expandtab')

-- Selection Highlights
--[[ vim.cmd([[
    function! SetCustomHighlight()
       hi! Visual cterm=reverse gui=reverse
    endfunction
]]

-- Custom highlight groups for the selection
--[[ vim.cmd([[
   hi! Visual cterm=reverse gui=reverse
]]

-- HABAMAX SETTINGS ----------------------------------------------------
-------------------------------------------------------------------------

-- Set up an autocommand to reapply the custom highlight when the color scheme changes
--[[ vim.cmd([[
    augroup CustomHighlight
        autocmd!
        autocmd ColorScheme * call SetCustomHighlight()
    augroup END
]]

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'typescript', 'vimdoc', 'vim', 'kotlin' },

    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = true,

    highlight = {
        enable = true,
    },

    indent = {
        enable = true,
        -- Treesitter doesn't provide indent_width or method option directly
        -- You can set these via Neovim's options or use a custom plugin.
        -- Example: vim.opt.tabstop = 3
        --          vim.opt.shiftwidth = 3
    },

    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<c-space>',
            node_incremental = '<c-space>',
            scope_incremental = '<c-s>',
            node_decremental = '<M-space>',
        },
    },

    textobjects = {
        select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ['aa'] = '@parameter.outer',
                ['ia'] = '@parameter.inner',
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                [']m'] = '@function.outer',
                [']]'] = '@class.outer',
            },
            goto_next_end = {
                [']M'] = '@function.outer',
                [']['] = '@class.outer',
            },
            goto_previous_start = {
                ['[m'] = '@function.outer',
                ['[['] = '@class.outer',
            },
            goto_previous_end = {
                ['[M'] = '@function.outer',
                ['[]'] = '@class.outer',
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ['<leader>a'] = '@parameter.inner',
            },
            swap_previous = {
                ['<leader>A'] = '@parameter.inner',
            },
        },
    },
}

require('lspconfig').gopls.setup({
    settings = {
        gopls = {
            gofumpt = true
        }
    }
})


-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
    -- NOTE: Remember that lua is a real programming language, and as such it is possible
    -- to define small helper and utility functions so you don't have to repeat yourself
    -- many times.
    --
    -- In this case, we create a function that lets us more easily define mappings specific
    -- for LSP related items. It sets the mode, buffer and description for us each time.
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    -- See `:help K` for why this keymap
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- Lesser used LSP functionality
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })

    vim.api.nvim_set_keymap('n', '<leader>f', ':Format<CR>', { noremap = true, silent = true })
end

local servers = {
    clangd = { 'c' },
    gopls = { filetypes = { 'go' } },
    pyright = { filetypes = { 'py' } },
    rust_analyzer = {},
    html = { filetypes = { 'html', 'twig', 'hbs' } },
    lua_ls = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
    },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
    function(server_name)
        require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
            filetypes = (servers[server_name] or {}).filetypes,
        }
    end
}

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert {
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete {},
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

-- Set transparent background
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
