require("mason").setup()
require("mason-lspconfig").setup()

-- After setting up mason-lspconfig you may set up servers via lspconfig
-- require("lspconfig").kotlin_language_server.setup {}

-- see https://github.com/nvim-treesitter/nvim-treesitter for more information
-- possibly interesting guide using with neovim: https://blog.indoorvivants.com/2022-05-12-smithy-neovim#registering-smithy-filetype
require 'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    --disable = { "markdown", "md" }
  },
  -- NOTE: ensure that that tree-sitter cli is installed to support this
  auto_install = true,
}
