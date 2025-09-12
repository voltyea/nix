return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      -- Use NixOS lua-language-server instead of Mason’s broken one
      lspconfig.lua_ls.setup {
        cmd = { "lua-language-server" },
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      }
    end,
  },
}

