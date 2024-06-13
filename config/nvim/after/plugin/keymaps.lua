local keymap = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }

-- maps
vim.cmd [[
	nnoremap <M-i> :m .-2<CR>==
	nnoremap <M-u> :m .+1<CR>==
	vnoremap <M-i> :m '<-2<CR>gv=gv
	vnoremap <M-u> :m '>+1<CR>gv=gv
	nnoremap <CR> o<ESC>
	nnoremap <C-CR> O<ESC>
	nnoremap <leader><leader><TAB> :bp!<CR>
	nnoremap <leader>n :NvimTreeToggle<CR>
	nnoremap <leader><TAB> :bn!<CR>
	nnoremap <Leader>s :%s/\<<C-r><C-w>\>/
	nnoremap <Leader><C-p> :Telescope buffers<CR>
	nnoremap <C-p> :lua require('utils.finder').find_files()<CR>
	nnoremap <Leader>c *Nciw
	nnoremap <Leader>a :noh<CR>

	let g:tmux_navigator_no_mappings = 1
	nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
	nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
	nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
	nnoremap <silent> <C-l> :TmuxNavigateRight<cr>

	let g:tmux_resizer_no_mappings = 1
	nnoremap <silent> <C-M-h> :TmuxResizeLeft<cr>
	nnoremap <silent> <C-M-j> :TmuxResizeDown<cr>
	nnoremap <silent> <C-M-k> :TmuxResizeUp<cr>

	command! Encode64 execute '.!base64'
	command! Decode64 execute '.!base64 -d'
	command! Vimrc :vs ~/.config/nvim/after/plugin/defaults.lua
	command! Plugins :vs ~/.config/nvim/plugins.lua
	command! Keymaps :vs ~/.config/nvim/after/plugin/keymaps.lua
	command! Refresh :so $MYVIMRC
	command! Plugins :vs ~/.config/nvim/lua/plugins.lua
]]

-- Center search results
keymap("n", "n", "nzz", default_opts)
keymap("n", "N", "Nzz", default_opts)

-- Visual line wraps
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", expr_opts)
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", expr_opts)

-- Better indent
keymap("v", "<", "<gv", default_opts)
keymap("v", ">", ">gv", default_opts)

-- Paste over currently selected text without yanking it
keymap("v", "p", '"_dP', default_opts)

-- Switch buffer
keymap("n", "<S-h>", ":bprevious<CR>", default_opts)
keymap("n", "<S-l>", ":bnext<CR>", default_opts)

-- Cancel search highlighting with ESC
keymap("n", "<ESC>", ":nohlsearch<Bar>:echo<CR>", default_opts)

-- Move selected line / block of text in visual mode
keymap("x", "K", ":move '<-2<CR>gv-gv", default_opts)
keymap("x", "J", ":move '>+1<CR>gv-gv", default_opts)

keymap("x", "<leader>ea", "<Plug>(EasyAlign)", {})
keymap("n", "<leader>ea", "<Plug>(EasyAlign)", {})

keymap('n', '<localleader>t', ':TermSelect<CR>', { noremap=true })
keymap('n', '<C-t>', ':ToggleTerm<CR>', { noremap=true })
keymap('t', '<esc>', '<c-\\><c-n>', default_opts)
keymap('t', '<c-h>', '<c-\\><c-n><c-w>h', default_opts)
keymap('t', '<c-j>', '<c-\\><c-n><c-w>j', default_opts)
keymap('t', '<c-k>', '<c-\\><c-n><c-w>k', default_opts)
keymap('t', '<c-l>', '<c-\\><c-n><c-w>l', default_opts)


keymap('n', '<leader><CR>', ':Goyo<CR>', {})
