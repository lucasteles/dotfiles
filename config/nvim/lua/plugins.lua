require 'utils/init'

local M = {}

function M.setup()
  local packer_bootstrap = false
  local conf = { display = { open_fn = function() return require('packer.util').float { border = 'rounded' } end, },
                 profile = { enable = true, threshold = 0 }}
  local function packer_init()
    local fn = vim.fn
    local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
      packer_bootstrap = fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path, }
      vim.cmd [[packadd packer.nvim]]
    end
    vim.cmd 'autocmd BufWritePost plugins.lua source <afile> | PackerCompile'
  end

  packer_init()

  local packer = require 'packer'
  packer.init(conf)

  -- Plugins
  packer.startup(function(use)

    use { 'wbthomason/packer.nvim' }

   -- Notification
    use {
      'rcarriga/nvim-notify',
      event = 'VimEnter',
      config = function()
        vim.notify = require('notify')
        vim.notify.setup({render = 'wrapped-compact'})
      end,
    }

     -- Navigation
     use 'andymass/vim-matchup'
     use 'vim-scripts/BufOnly.vim'
     use 'jpalardy/vim-slime'
     -- use 'dhruvasagar/vim-zoom'
     use {
      'junegunn/goyo.vim',
       config = function()
         require('config.goyo').setup()
       end,
    }

     -- Text transformations
     use { 'mg979/vim-visual-multi', branch = 'master'}
     use 'tpope/vim-surround'
     use 'guns/vim-sexp'
     use 'junegunn/vim-easy-align' --Text alignment  j

    -- Themes / VIsual
    -- use 'rakr/vim-one'
    use 'joshdick/onedark.vim'

    -- use 'junegunn/rainbow_parentheses.vim'
    use {
       'HiPhish/rainbow-delimiters.nvim',
       config = function()
         require('config.rainbow').setup()
       end,
    }

    -- Web
    -- use 'mattn/emmet-vim'

    -- Tmux
    use 'christoomey/vim-tmux-navigator'
    use 'melonmanchan/vim-tmux-resizer'
    use 'RyanMillerC/better-vim-tmux-resizer'

     -- Startup screen
    use {
      'nvimdev/dashboard-nvim',
      event = 'VimEnter',
      config = function()
        require('config.dashboard').setup()
      end,
      requires = {'nvim-tree/nvim-web-devicons'}
    }


     use { 'nvim-lua/plenary.nvim', module = 'plenary' }

     -- Git
     use {
       'TimUntersberger/neogit',
       cmd = 'Neogit',
       requires = 'nvim-lua/plenary.nvim',
       config = function()
         require('config.neogit').setup()
       end,
     }

     -- Better icons
     use {
       'kyazdani42/nvim-web-devicons',
       module = 'nvim-web-devicons',
       config = function()
         require('nvim-web-devicons').setup { default = true }
       end,
     }

     -- Better Comment
     use {
       'numToStr/Comment.nvim',
       opt = true,
       keys = { 'gc', 'gcc', 'gbc' },
       config = function()
         require('Comment').setup {}
       end,
     }

     -- Easy motion
     -- https://github.com/ggandor/leap.nvim

     use {
       'unblevable/quick-scope',
       config = function()
         vim.cmd [[
           let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
           au ColorScheme * highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
           au ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
         ]]
       end,
    }

    use {
      "akinsho/toggleterm.nvim",
      tag = '*',
      config = function()
        require("toggleterm").setup({
          open_mapping = [[<leader>t]], direction = "vertical",
          size = 60, shade_terminals = true, start_in_insert = true,
          insert_mappings = false, terminal_mappings = false,
        })
      end
    }

    use {
        "SmiteshP/nvim-navic",
        requires = { "neovim/nvim-lspconfig" },
        config = function()
          require('config.navic').setup()
        end,
    }

    use {
        "SmiteshP/nvim-navbuddy",
        requires = {
            "neovim/nvim-lspconfig",
            "SmiteshP/nvim-navic",
            "MunifTanjim/nui.nvim",
            "numToStr/Comment.nvim",        -- Optional
            "nvim-telescope/telescope.nvim" -- Optional
        }
    }

     use {
       'nvim-lualine/lualine.nvim',
       event = 'VimEnter',
       requires = { 'nvim-tree/nvim-web-devicons', opt = true },
       config = function()
        require('config.lualine').setup()
       end,
     }

     use {
      'kyazdani42/nvim-tree.lua',
      requires = {
        'kyazdani42/nvim-web-devicons',
      },
      cmd = { 'NvimTreeToggle', 'NvimTreeClose',
              'NvimTreeFocus', 'NvimTreeRefresh' },
      config = function()
        require('config.nvimtree').setup()
      end,
     }

     -- User interface
     use {
       'stevearc/dressing.nvim',
       event = 'BufEnter',
       config = function()
         require('dressing').setup {
           select = { backend = { 'telescope', 'fzf', 'builtin' }, },
         }
       end,
     }

     -- Buffer line
     use {
       'akinsho/nvim-bufferline.lua',
       event = 'BufReadPre',
       wants = 'nvim-web-devicons',
       config = function()
         require('config.bufferline').setup()
       end,
     }

     use {
       'nvim-telescope/telescope.nvim',
       opt = true,
       config = function()
         require('config.telescope').setup()
       end,
       cmd = { 'Telescope' },
       module = 'telescope',
       keys = { '<leader>f', '<leader>p' },
       wants = {
         'plenary.nvim',
         'popup.nvim',
         'telescope-fzf-native.nvim',
         'telescope-project.nvim',
         'telescope-repo.nvim',
         'telescope-file-browser.nvim',
         'project.nvim',
       },
       requires = {
         'nvim-lua/popup.nvim',
         'nvim-lua/plenary.nvim',
         { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
         'nvim-telescope/telescope-project.nvim',
         'cljoly/telescope-repo.nvim',
         'nvim-telescope/telescope-file-browser.nvim',
         {
           'ahmedkhalf/project.nvim',
           config = function()
             require('project_nvim').setup {}
           end,
         },
       },
     }


    -- snippets
    use 'rafamadriz/friendly-snippets'
    use 'L3MON4D3/LuaSnip'

     -- dev-xp
    use {
      'Olical/conjure',
       config = function()
        require('config.conjure').setup()
       end,
    }
    use {
      'karb94/neoscroll.nvim',
      config = function()
        require('config.neoscroll').setup()
      end,
    }
    use {
      'norcalli/nvim-colorizer.lua',
       config = function()
        vim.opt.termguicolors = true
        require('colorizer').setup()
       end,
    }

    use 'PaterJason/cmp-conjure'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'

    use {
        'hrsh7th/nvim-cmp',
        requires = {'hrsh7th/cmp-nvim-lsp'},
        config = function()
            require('config.cmp').setup()
        end
    }

    use {
      'nvim-treesitter/nvim-treesitter',
       run = ':TSUpdate',
       config = function()
         require('config.treesitter').setup()
       end,
    }

     -- Auto pairs
     -- use {
     --   'windwp/nvim-autopairs',
     --   wants = 'nvim-treesitter',
     --   module = { 'nvim-autopairs.completion.cmp', 'nvim-autopairs' },
     --   config = function()
     --     require('config.autopairs').setup()
     --   end,
     -- }

     -- Auto tag
     -- use {
     --   'windwp/nvim-ts-autotag',
     --   wants = 'nvim-treesitter',
     --   event = 'InsertEnter',
     --   config = function()
     --     require('nvim-ts-autotag').setup { enable = true }
     --   end,
     -- }

     -- End wise
     -- use {
     --   'RRethy/nvim-treesitter-endwise',
     --   wants = 'nvim-treesitter',
     --   event = 'InsertEnter',
     -- }
    -- use {
    --     'glacambre/firenvim',
    --     run = function() vim.fn['firenvim#install'](0) end
    -- }

    -- LSP

    use {'williamboman/mason.nvim', 'williamboman/mason-lspconfig.nvim'}

    use {
       'ray-x/lsp_signature.nvim',
       config = function()
         require('config.lsp_signature').setup()
       end
     }

    use {
      'neovim/nvim-lspconfig',
      config = function()
        require('config.lsp').setup()
      end
    }

    if packer_bootstrap then
      print 'Restart Neovim required after installation!'
      require('packer').sync()
    end
  end)
end

return M
