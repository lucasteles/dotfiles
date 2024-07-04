M = {}

local plugin_list = {
  -- Notification
  {
    'rcarriga/nvim-notify',
    event = 'VimEnter',
    config = function()
      vim.notify = require 'notify'
      vim.notify.setup({ render = 'wrapped-compact' })
    end,
  },

  -- Navigation
  'andymass/vim-matchup',
  'vim-scripts/BufOnly.vim',

  {
    'jpalardy/vim-slime',
    init = function()
      vim.g.slime_target = 'tmux'
    end
  },

  {
    'junegunn/goyo.vim',
    config = function()
      require('config.goyo').setup()
    end,
  },

  -- Text transformations
  { 'mg979/vim-visual-multi', branch = 'master' },
  'tpope/vim-surround',
  'guns/vim-sexp',
  'junegunn/vim-easy-align', --Text alignment  j

  -- Themes / VIsual
  -- 'rakr/vim-one'
  'joshdick/onedark.vim',

  -- 'junegunn/rainbow_parentheses.vim',
  {
    'HiPhish/rainbow-delimiters.nvim',
    config = function()
      require('config.rainbow').setup()
    end,
  },

  -- Web
  -- 'mattn/emmet-vim',

  -- Tmux
  'christoomey/vim-tmux-navigator',
  'melonmanchan/vim-tmux-resizer',
  'RyanMillerC/better-vim-tmux-resizer',

  -- Startup screen
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('config.dashboard').setup()
    end,
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },

  { 'nvim-lua/plenary.nvim',  module = 'plenary' },

  -- Git
  {
    'TimUntersberger/neogit',
    cmd = 'Neogit',
    dependencies = 'nvim-lua/plenary.nvim',
    config = function()
      require('config.neogit').setup()
    end,
  },

  -- Better icons
  {
    'kyazdani42/nvim-web-devicons',
    module = 'nvim-web-devicons',
    config = function()
      require('nvim-web-devicons').setup { default = true }
    end,
  },

  -- Better Comment
  {
    'numToStr/Comment.nvim',
    opt = true,
    keys = { 'gc', 'gcc', 'gbc' },
    config = function()
      require('Comment').setup {}
    end,
  },

  -- Easy motion
  -- https://github.com/ggandor/leap.nvim

  {
    'unblevable/quick-scope',
    init = function()
      vim.cmd [[
        let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
        au ColorScheme * highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
        au ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
      ]]
    end,
  },

  {
    "akinsho/toggleterm.nvim",
    version = '*',
    config = function()
      require("toggleterm").setup({
        open_mapping = [[<leader>t]],
        direction = "vertical",
        size = 60,
        shade_terminals = true,
        start_in_insert = true,
        insert_mappings = false,
        terminal_mappings = false,
      })
    end
  },

  {
    "SmiteshP/nvim-navic",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      require('config.navic').setup()
    end,
  },

  {
    'SmiteshP/nvim-navbuddy',
    dependencies = {
      'neovim/nvim-lspconfig',
      'SmiteshP/nvim-navic',
      'MunifTanjim/nui.nvim',
      'numToStr/Comment.nvim',            -- Optional
      'nvim-telescope/telescope.nvim'     -- Optional
    }
  },

  {
    'nvim-lualine/lualine.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
    config = function()
      require('config.lualine').setup()
    end,
  },

  {
    'kyazdani42/nvim-tree.lua',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require('config.nvimtree').setup()
    end,
    init = function()
      vim.g.nvim_tree_respect_buf_cwd = 1
      vim.cmd([[
          :hi NvimTreeExecFile    guifg=#2266fe gui=bold
          :hi NvimTreeSpecialFile guifg=#903288 gui=underline
          :hi NvimTreeSymlink     guifg=Yellow  gui=italic
      ]])
    end
  },

  -- User interface
  {
    'stevearc/dressing.nvim',
    event = 'BufEnter',
    config = function()
      require('dressing').setup {
        select = { backend = { 'telescope', 'fzf', 'builtin' }, },
      }
    end,
  },

  -- Buffer line
  {
    'akinsho/nvim-bufferline.lua',
    event = 'BufReadPre',
    wants = 'nvim-web-devicons',
    config = function()
      require('config.bufferline').setup()
    end,
  },

  {
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
    dependencies = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
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
  },

  -- langs
  {
    'Olical/conjure',
    config = function()
      require('config.conjure').setup()
    end,
  },
  'daveyarwood/vim-alda',

  -- snippets
  'rafamadriz/friendly-snippets',
  'L3MON4D3/LuaSnip',

  -- dev-xp
  {
    'karb94/neoscroll.nvim',
    config = function()
      require('config.neoscroll').setup()
    end,
  },
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end,
  },

  'PaterJason/cmp-conjure',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',

  {
    'hrsh7th/nvim-cmp',
    dependencies = { 'hrsh7th/cmp-nvim-lsp' },
    config = function()
      require('config.cmp').setup()
    end
  },

  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('config.treesitter').setup()
    end,
  },

  {
    'windwp/nvim-ts-autotag',
    wants = 'nvim-treesitter',
    event = 'InsertEnter',
    config = function()
      require('nvim-ts-autotag').setup()
    end,
  },

  -- browser integration
  -- {
  --     'glacambre/firenvim',
  --     build = function() vim.fn['firenvim#install'](0) end
  -- },

  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require("ibl").setup({
        exclude = { filetypes = { "dashboard" } } })
    end,
  },

  -- LSP
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  {
    'ray-x/lsp_signature.nvim',
    config = function()
      require('config.lsp_signature').setup()
    end,
  },

  {
    'neovim/nvim-lspconfig',
    config = function()
      require('config.lsp').setup()
    end,
  },

  {
    'mfussenegger/nvim-dap',
    dependencies = { 'williamboman/mason.nvim', 'williamboman/mason-lspconfig.nvim' },
    config = function()
      require('config.dap').setup()
    end,
  },

  {
    'rcarriga/nvim-dap-ui',
    dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
    config = function()
      require('config.dap').setup_ui()
    end,
  },
}

local function load()
  local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
  if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable',
      lazypath,
    })
  end
  vim.opt.rtp:prepend(lazypath)
end

function M.install()
  load()
  return require('lazy').setup(plugin_list)
end

return M
