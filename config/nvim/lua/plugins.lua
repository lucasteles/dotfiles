local M = {}
function M.setup()
  local packer_bootstrap = false
  local conf = { display = { open_fn = function() return require("packer.util").float { border = "rounded" } end, },
                 profile = { enable = true, threshold = 0 }}
  local function packer_init()
    local fn = vim.fn
    local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
      packer_bootstrap = fn.system { "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path, }
      vim.cmd [[packadd packer.nvim]]
    end
    vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
  end

  packer_init()

  local packer = require "packer"
  packer.init(conf)

  -- Plugins
  packer.startup(function(use)

    use { "wbthomason/packer.nvim" }

   -- Notification
    use {
      "rcarriga/nvim-notify",
      event = "VimEnter",
      config = function()
        vim.notify = require('notify')
      end,
    }

     -- Utilities
     use 'jpalardy/vim-slime'
     use 'dhruvasagar/vim-zoom'
     use 'tpope/vim-repeat'
     use 'sk1418/HowMuch'
   
     -- Navigation
     use 'vim-scripts/BufOnly.vim'
     use 'andymass/vim-matchup'
   
     -- Text transformations
     use { 'mg979/vim-visual-multi', branch = 'master'}
     use 'tpope/vim-surround'
     use 'guns/vim-sexp'
     use 'junegunn/vim-easy-align' --Text alignment  j
   
    -- Themes / VIsual
    -- use 'arcticicestudio/nord-vim'
    use 'rakr/vim-one'
    use 'joshdick/onedark.vim'
   
    -- Web
    use 'mattn/emmet-vim'
   
    -- Tmux
    use 'christoomey/vim-tmux-navigator'
    use 'melonmanchan/vim-tmux-resizer'
    use 'RyanMillerC/better-vim-tmux-resizer'
   
   
     use "LunarVim/onedarker.nvim"
   
     -- Startup screen
     use {
       "goolord/alpha-nvim",
       config = function()
         require("config.alpha").setup()
       end,
     }
   
     -- WhichKey
     use {
        "folke/which-key.nvim",
        config = function()
          require("config.whichkey").setup()
        end,
     }
   
     use { "nvim-lua/plenary.nvim", module = "plenary" }
   
     -- Git
     use {
       "TimUntersberger/neogit",
       cmd = "Neogit",
       requires = "nvim-lua/plenary.nvim",
       config = function()
         require("config.neogit").setup()
       end,
     }
   
     -- Better icons
     use {
       "kyazdani42/nvim-web-devicons",
       module = "nvim-web-devicons",
       config = function()
         require("nvim-web-devicons").setup { default = true }
       end,
     }
   
     -- Better Comment
     use {
       "numToStr/Comment.nvim",
       opt = true,
       keys = { "gc", "gcc", "gbc" },
       config = function()
         require("Comment").setup {}
       end,
     }
     -- Easy hopping
     use {
       "phaazon/hop.nvim",
       config = function()
         require("hop").setup {}
       end,
       disable = true
     }
   
     -- Easy motion
     use {
       "ggandor/lightspeed.nvim",
       keys = { "s", "S", "f", "F", "t", "T" },
       config = function()
         require("lightspeed").setup {}
       end,
       disable = true
     }
   
     -- Markdown
     use {
       "iamcco/markdown-preview.nvim",
       run = function()
         vim.fn["mkdp#util#install"]()
       end,
       ft = "markdown",
       cmd = { "MarkdownPreview" },
     }
   
     use {
       "SmiteshP/nvim-gps",
       requires = "nvim-treesitter/nvim-treesitter",
       module = "nvim-gps",
       config = function()
         require("nvim-gps").setup()
       end,
     }
   
     use {
       "nvim-lualine/lualine.nvim",
       event = "VimEnter",
       config = function()
        require("config.lualine").setup()
       end,
       requires = { "nvim-web-devicons", "nvim-gps" },
     }
   
     use {
       "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = function()
          require("config.treesitter").setup()
        end,
     }
   
   
     use {
      "kyazdani42/nvim-tree.lua",
      requires = {
        "kyazdani42/nvim-web-devicons",
      },
      cmd = { "NvimTreeToggle", "NvimTreeClose", 
              "NvimTreeFocus", "NvimTreeRefresh" },
      config = function()
        require("config.nvimtree").setup()
      end,
     }
   
     -- User interface
     use {
       "stevearc/dressing.nvim",
       event = "BufEnter",
       config = function()
         require("dressing").setup {
           select = { backend = { "telescope", "fzf", "builtin" }, },
         }
       end,
     }
   
     -- Buffer line
     use {
       "akinsho/nvim-bufferline.lua",
       event = "BufReadPre",
       wants = "nvim-web-devicons",
       config = function()
         require("config.bufferline").setup()
       end,
     }
   
     use {
       "nvim-telescope/telescope.nvim",
       opt = true,
       config = function()
         require("config.telescope").setup()
       end,
       cmd = { "Telescope" },
       module = "telescope",
       keys = { "<leader>f", "<leader>p" },
       wants = {
         "plenary.nvim",
         "popup.nvim",
         "telescope-fzf-native.nvim",
         "telescope-project.nvim",
         "telescope-repo.nvim",
         "telescope-file-browser.nvim",
         "project.nvim",
       },
       requires = {
         "nvim-lua/popup.nvim",
         "nvim-lua/plenary.nvim",
         { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
         "nvim-telescope/telescope-project.nvim",
         "cljoly/telescope-repo.nvim",
         "nvim-telescope/telescope-file-browser.nvim",
         {
           "ahmedkhalf/project.nvim",
           config = function()
             require("project_nvim").setup {}
           end,
         },
       },
     }


    use {'saadparwaiz1/cmp_luasnip', requires = {'L3MON4D3/LuaSnip'}}
    use "rafamadriz/friendly-snippets"
     -- lsp and completion
    use {
        "hrsh7th/nvim-cmp",
        requires = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-calc',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-vsnip',
            "hrsh7th/cmp-cmdline",
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            require("config.cmp").setup()
        end
    }
   
     -- Auto pairs
     use {
       "windwp/nvim-autopairs",
       wants = "nvim-treesitter",
       module = { "nvim-autopairs.completion.cmp", "nvim-autopairs" },
       config = function()
         require("config.autopairs").setup()
       end,
     }
   
     -- Auto tag
     use {
       "windwp/nvim-ts-autotag",
       wants = "nvim-treesitter",
       event = "InsertEnter",
       config = function()
         require("nvim-ts-autotag").setup { enable = true }
       end,
     }
   
     -- End wise
     use {
       "RRethy/nvim-treesitter-endwise",
       wants = "nvim-treesitter",
       event = "InsertEnter",
     }
    use {
        'glacambre/firenvim',
        run = function() vim.fn['firenvim#install'](0) end 
    }

    -- LSP
     use {'neovim/nvim-lspconfig', 'williamboman/nvim-lsp-installer'}
     use {
        "ray-x/lsp_signature.nvim",
        config = function()
          require("config.lsp").setup()
          require('config.nvim-lsp-installer').setup()
        end
      }

    if packer_bootstrap then
      print "Restart Neovim required after installation!"
      require("packer").sync()
    end
  end)
end

return M
