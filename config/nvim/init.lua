require 'init_env'

local api = vim.api
local g = vim.g
local opt = vim.opt

-- disable netrw
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-- Remap leader and local leader to <Space>
api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
g.mapleader = ' '
g.maplocalleader = ','

vim.loader.enable()

opt.termguicolors = true              -- Enable colors in terminal
opt.hlsearch = true                   --Set highlight on search
opt.number = true                     --Make line numbers default
opt.relativenumber = true             --Make relative number default
opt.mouse = 'a'                       --Enable mouse mode
opt.breakindent = true                --Enable break indent
opt.undofile = true                   --Save undo history
opt.ignorecase = true                 --Case insensitive searching unless /C or capital in search
opt.smartcase = true                  -- Smart case
opt.updatetime = 250                  --Decrease update time
opt.signcolumn = 'yes'                -- Always show sign column
opt.clipboard = 'unnamed,unnamedplus' -- Access system clipboard
opt.showcmd = true
opt.wildmenu = true
opt.spelllang = 'pt_br,en'
opt.timeoutlen = 300
opt.path:remove '/usr/include'
opt.path:append '**'
opt.wildignorecase = true
opt.wildignore:append '**/node_modules/*'
opt.wildignore:append '**/.git/*'
opt.wrap = false

-- tab config
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 0
opt.expandtab = true
opt.smarttab = true

require 'custom.cmds'
require('plugins').install()

vim.cmd.colorscheme 'onedark'
