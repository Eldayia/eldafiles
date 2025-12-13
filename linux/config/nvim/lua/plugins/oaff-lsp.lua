return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      local configs = require("lspconfig.configs")

      if not configs.oaff then
        configs.oaff = {
          default_config = {
            cmd = { "node", vim.fn.expand("~/Code/oaff-lsp/oaff-language-server.js"), "--stdio" },
            filetypes = { "oaff" },
            root_dir = lspconfig.util.root_pattern(".git", "package.json"),
            settings = {},
          },
        }
      end

      lspconfig.oaff.setup({
        on_attach = function(client, bufnr)
          local opts = { buffer = bufnr }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        end,
      })

      vim.filetype.add({
        extension = { oaff = "oaff" },
      })
    end,
  },
}
