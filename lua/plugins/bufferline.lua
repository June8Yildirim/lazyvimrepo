-- buffer line
return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  keys = {
    { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
    { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
  },
  opts = {
    options = {
      -- mode = "tabs",
      mode = "buffers",
      separator_style = "slant", -- "thin" | "thick" | "slant"
      offsets = {
        {
          filetype = "neo-tree",
          text = "Neo-tree",
          highlight = "Directory",
          text_align = "left",
        },
      },
      hover = {
        enabled = true,
        delay = 200,
        reveal = { "close" },
      },
      -- Add filename display options
      show_buffer_close_icons = true,
      show_close_icon = true,
    },
    highlights = {
      buffer_selected = {
        italic = false,
        bold = true,
        fg = "#007C80",
        bg = "#00FF00",
      },
      fill = {
        bg = "#1e1e2e", -- background of the empty area
      },
      indicator_selected = {
        fg = "#ff9e64",
      },
      separator_selected = {
        fg = "#ff9e64",
      },
      close_button_selected = {
        fg = "#007C80",
        bg = "#00FF00",
      },
    },
  },
}
