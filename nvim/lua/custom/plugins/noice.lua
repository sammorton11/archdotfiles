-- lazy.nvim
return {
   --[[ "folke/noice.nvim",
   event = "VeryLazy",
   opts = {
      cmdline = {
         view = "cmdline", -- Classic bottom cmdline
      },
      messages = {
         enabled = false, -- Disable Noice messages UI
      },
      notify = {
         enabled = true, -- Disable notifications
         merge = true,
         timeout = 1000, -- Messages disappear after 1 second
      },
      presets = {
         bottom_search = true,      -- Use a classic bottom cmdline for search
         command_palette = true,    -- Position cmdline and popupmenu together
         long_message_to_split = true, -- Long messages go to a split
         inc_rename = false,        -- Disable incremental rename input dialog
      },
      routes = {
         {
            filter = {
               event = "msg_show",
               kind = "",
               find = "written", -- Suppress "written" messages
            },
            opts = { skip = true },
         },
      },
   },
   dependencies = {
      "MunifTanjim/nui.nvim", -- Required for Noice UI
      "rcarriga/nvim-notify", -- Optional: notification plugin
   }, ]]
}
