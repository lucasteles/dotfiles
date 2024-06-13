local api = vim.api
local g = vim.g
local opt = vim.opt

-- Remap leader and local leader to <Space>
api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })

g.mapleader = " "
g.maplocalleader = ","

opt.termguicolors = true -- Enable colors in terminal
opt.hlsearch = true --Set highlight on search
opt.number = true --Make line numbers default
opt.relativenumber = true --Make relative number default
opt.mouse = "a" --Enable mouse mode
opt.breakindent = true --Enable break indent
opt.undofile = true --Save undo history
opt.ignorecase = true --Case insensitive searching unless /C or capital in search
opt.smartcase = true -- Smart case
opt.updatetime = 250 --Decrease update time
opt.signcolumn = "yes" -- Always show sign column
opt.clipboard = "unnamed,unnamedplus" -- Access system clipboard
opt.showcmd = true
opt.wildmenu = true
opt.spelllang="pt_br,en"
opt.timeoutlen = 300
opt.path:remove "/usr/include"
opt.path:append "**"
opt.wildignorecase = true
opt.wildignore:append "**/node_modules/*"
opt.wildignore:append "**/.git/*"

-- tab config
opt.tabstop=4
opt.shiftwidth=4
opt.softtabstop=0
opt.expandtab=true
opt.smarttab=true

-- slime
g.slime_target = "tmux"

vim.cmd [[
let g:clipboard = {
          \   'name': 'win32yank-wsl',
          \   'copy': {
          \      '+': 'win32yank.exe -i --crlf',
          \      '*': 'win32yank.exe -i --crlf',
          \    },
          \   'paste': {
          \      '+': 'win32yank.exe -o --lf',
          \      '*': 'win32yank.exe -o --lf',
          \   },
          \   'cache_enabled': 0,
          \ }
]]

 --Highlight on yank
vim.cmd [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]]


vim.cmd [[
  autocmd Filetype json setlocal ts=2 sw=2 sts=0 expandtab
  augroup json_base
    au!
    autocmd BufNewFile,BufRead *.json.base  set ft=json
  augroup END
]]

vim.cmd "colorscheme onedark"

vim.loader.enable()
