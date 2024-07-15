
vim.opt.wildignore = { '*.o', '*.a', '__pycache__', 'target' }

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

vim.g.rustaceanvim = {
  -- Plugin configuration
  tools = {
  },
  -- LSP configuration
  server = {
    on_attach = function(client, bufnr)
      -- you can also put keymaps in here
    end,
    default_settings = {
      -- rust-analyzer language server configuration
      -- see https://rust-analyzer.github.io/manual.html
      ['rust-analyzer'] = {
        cargo = {
          buildScripts = {
            -- run build scripts in project's root directory and not the workspace
            invocationLocation = "root"
          }
        }
      },
    },
  },
  -- DAP configuration
  dap = {
  },
}
