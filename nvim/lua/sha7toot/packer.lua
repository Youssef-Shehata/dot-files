vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'


  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.8',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }
  use( { "rose-pine/neovim", as = "rose-pine" })

use ('simrat39/rust-tools.nvim')

  use (  'nvim-treesitter/nvim-treesitter' , {run = 'TSUpdate'} )
  use (  'theprimeagen/harpoon')
  use (  'mbbill/undotree')
  use (  'tpope/vim-fugitive')
  use (    'folke/tokyonight.nvim'

)
  use (
{ -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      require('mini.ai').setup { n_lines = 500 }

      require('mini.surround').setup()

      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = vim.g.have_nerd_font }

      statusline.section_location = function()
        return '%2l:%-2v'
      end

    end,
  }
  )



use({'VonHeikemen/lsp-zero.nvim', branch = 'v4.x'})
use({'neovim/nvim-lspconfig'})
use({'hrsh7th/nvim-cmp'})
use({'hrsh7th/cmp-nvim-lsp'})
use({'williamboman/mason.nvim'})
use({'williamboman/mason-lspconfig.nvim'})

	use({"hrsh7th/cmp-buffer"})
	use({"hrsh7th/cmp-path"})
	use({"hrsh7th/cmp-cmdline"})
	use({"L3MON4D3/LuaSnip"})
	use({"saadparwaiz1/cmp_luasnip"})
	use({"j-hui/fidget.nvim"})








end)
