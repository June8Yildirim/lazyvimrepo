return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Keep pyright here if you need Python support
        pyright = {},
        -- DO NOT add tsserver or vtsls here.
        -- The "Extra" in your lazy.lua handles them automatically.
      },
    },
  },
}
