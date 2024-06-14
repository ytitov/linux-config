
vim.opt.wildignore = { '*.o', '*.a', '__pycache__' }

require("mason").setup()
-- require("mason-lspconfig").setup()

-- require('packer').startup(function()
--   use 'neovim/nvim-lspconfig'
--   use 'simrat39/rust-tools.nvim'
-- end)

-- After setting up mason-lspconfig you may set up servers via lspconfig
-- require("lspconfig").kotlin_language_server.setup {}

-- see https://github.com/nvim-treesitter/nvim-treesitter for more information
-- possibly interesting guide using with neovim: https://blog.indoorvivants.com/2022-05-12-smithy-neovim#registering-smithy-filetype
require 'nvim-treesitter.configs'.setup {
  -- NOTE: ensure that that tree-sitter cli is installed to support this
  auto_install = true,
  ensure_installed = { "lua", "rust", "toml" },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
    --disable = { "markdown", "md" }
  },
  ident = {
    enable = true,
  },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  },
}
