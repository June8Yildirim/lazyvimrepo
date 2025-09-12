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
      mode = "tabs",
      -- separator_style = "sladnt",
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
    buffer_close_icon = "",
    modified_icon = "●",
    close_icon = "",
    left_trunc_marker = "",
    right_trunc_marker = "",
    highlights = {
      buffer_selected = {
        italic = false,
        bold = true,
        fg = "#ffffff",
        bg = "red",
      },
      indicator_selected = {
        fg = "#ff9e64",
      },
      separator_selected = {
        fg = "#ff9e64",
      },
      close_button_selected = {
        fg = "#ffffff",
        bg = "#1e1e2e",
      },
    },
  },
}
