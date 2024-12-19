return {
   {
      'sammorton11/vim-gotham',
      name = "gotham",
      lazy = false,
      config = function()
         vim.g['gotham_italic_comments'] = false
         vim.g['gotham_italic_keywords'] = false
         vim.g['gotham_italic_functions'] = true

         -- Customizing the color of function names
         vim.cmd('highlight! link Identifier Function')   -- Link Identifier to Function group
         vim.cmd('hi Function guifg=#d3ebe9 ctermfg=243') -- Change color to '#282c34' or any other color
      end
   },
}

