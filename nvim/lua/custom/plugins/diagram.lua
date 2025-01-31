return {
  "3rd/diagram.nvim",
  dependencies = {
    "3rd/image.nvim",
  },
  opts = {
    renderer_options = {
      mermaid = {
        background = nil, -- Options: nil | "transparent" | "white" | "#hex"
        theme = nil, -- Options: nil | "default" | "dark" | "forest" | "neutral"
        scale = 1, -- Default: 1 | Other options: 2, 3, ...
        width = nil, -- Optional: set a specific width, e.g., 800
        height = nil, -- Optional: set a specific height, e.g., 600
      },
      plantuml = {
        charset = nil, -- Optional: set a charset if needed
      },
      d2 = {
        theme_id = nil, -- Set to theme ID if applicable
        dark_theme_id = nil, -- Dark theme variant
        scale = nil, -- Optional: scaling factor
        layout = nil, -- Optional: specific layout options
        sketch = nil, -- Optional: sketch mode
      },
    },
  },
}

