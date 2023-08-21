require("mason").setup()
require("mason-lspconfig").setup()

-- After setting up mason-lspconfig you may set up servers via lspconfig
-- require("lspconfig").kotlin_language_server.setup {}

require 'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },
}
