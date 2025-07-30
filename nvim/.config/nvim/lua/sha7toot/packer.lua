vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'


  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    -- or                            , branch = '0.1.x',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }

  use('simrat39/rust-tools.nvim')
  use('nvim-treesitter/nvim-treesitter', { run = 'TSUpdate', commit = '4d03500' })
  use('theprimeagen/harpoon')
  use('mbbill/undotree')
  use({ 'Orange-OpenSource/hurl', ft = "hurl" })
  use({
    "laytan/cloak.nvim",
    config = function()
      require("cloak").setup({
        enabled = true,
        cloak_character = "•",
        highlight_group = "Comment",
        patterns = {
          { file_pattern = ".env*", cloak_pattern = "=.+" }, -- hide everything after =
        },
      })
    end
  })

  use({
    'folke/tokyonight.nvim',
    config = function()
      require('tokyonight').setup({
        transparent = true,
        styles = {
          sidebars = "transparent",
          floats = "transparent",
        },
      })
    end,
  })
  use({
    "folke/ts-comments.nvim",
    config = function()
      require("ts-comments").setup()
    end,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  })
  use({ 'VonHeikemen/lsp-zero.nvim', branch = 'v4.x' })
  use({ 'neovim/nvim-lspconfig' })
  use({ 'hrsh7th/nvim-cmp' })
  use({ 'hrsh7th/cmp-nvim-lsp' })
  use({ 'williamboman/mason.nvim' })
  use({ 'williamboman/mason-lspconfig.nvim' })

  use({ "hrsh7th/cmp-buffer" })
  use({ "hrsh7th/cmp-path" })
  use({ "hrsh7th/cmp-cmdline" })
  use({ "L3MON4D3/LuaSnip" })
  use({ "saadparwaiz1/cmp_luasnip" })
  use({ "j-hui/fidget.nvim" })
  use({
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup {
        signs = {
          add          = { text = '┃' }, -- default: '│'
          change       = { text = '╱' }, -- default: '│'
          delete       = { text = '' }, -- default: '_'
          topdelete    = { text = '‾' }, -- default: '‾'
          changedelete = { text = '~' }, -- default: '~'
          untracked    = { text = '┆' }, -- optional
        },
        signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
      }
    end
  })
end)
