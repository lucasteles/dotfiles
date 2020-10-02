set clipboard=unnamed


syntax on
filetype plugin on

set rnu
set number
set tabstop=4
set ai
set showcmd
set cursorline
set hlsearch
set ignorecase
set novisualbell
set noerrorbells
set showmatch
set nobackup
set nowritebackup
set backspace=2 " make backspace work like most other apps
set shiftwidth=4
set nowrap
set colorcolumn=80
set list
set listchars=tab:>-     " > is shown at the beginning, - throughout
set expandtab
set path+=**
set wildmenu
set spelllang=pt_br,en
set encoding=UTF-8
set mouse=a
" personal maps
" imap jj <ESC>

set foldlevelstart=20
nnoremap <M-i> :m .-2<CR>==
nnoremap <M-u> :m .+1<CR>==
vnoremap <M-i> :m '<-2<CR>gv=gv
vnoremap <M-u> :m '>+1<CR>gv=gv

nnoremap <leader><S-TAB> :bp!<CR>
nnoremap <leader><TAB> :bn!<CR>

nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

vnoremap <C-r> "hy:%s/\<<C-r>h\>//gc<left><left><left>

nnoremap <Leader>s :%s/\<<C-r><C-w>\>/
nnoremap <Leader>c *Nciw
nnoremap <Leader>a :noh<CR>

nnoremap <CR> o<ESC>
nnoremap <C-CR> O<ESC>

let mapleader = "\<space>" " Use space as leader key
let maplocalleader = "," " Use , as local leader key

let g:ale_disable_lsp = 1
call plug#begin('~/.vim/plugged')

command! Encode64 execute '.!base64'
command! Decode64 execute '.!base64 -d'

" Utilities
Plug 'junegunn/vim-plug'
Plug 'w0rp/ale'
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jpalardy/vim-slime'

" Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': './install.sh'}
Plug 'junegunn/goyo.vim'                            " Distraction free mode
Plug 'tpope/vim-repeat'

"Navigation
Plug 'bkad/CamelCaseMotion'
Plug 'tmhedberg/matchit'
Plug 'easymotion/vim-easymotion'

" Text transformations
Plug 'vim-scripts/ReplaceWithRegister' "replace withot losing yank with gr
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'tpope/vim-commentary'
Plug 'wellle/targets.vim'
Plug 'tpope/vim-surround'
Plug 'Chiel92/vim-autoformat'
Plug 'guns/vim-sexp'
Plug 'tommcdo/vim-exchange' " exchange text with cx
Plug 'kana/vim-textobj-user' " vim-textobj-entire
Plug 'kana/vim-textobj-entire' "{motion}ae  entire buffer 
" Plug 'cohama/lexima.vim' "auto close parenthesis

"Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Files
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Themes / VIsual
Plug 'kshenoy/vim-signature'
Plug 'joshdick/onedark.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'luochen1990/rainbow'
Plug 'machakann/vim-highlightedyank'
" Plug 'kien/rainbow_parentheses.vim'

" Web
Plug 'mattn/emmet-vim'
Plug 'pangloss/vim-javascript'
Plug 'plasticboy/vim-markdown'

"Tmux
Plug 'christoomey/vim-tmux-navigator'
" Plug 'melonmanchan/vim-tmux-resizer'
Plug 'RyanMillerC/better-vim-tmux-resizer'

"Clojure
Plug 'guns/vim-clojure-static'
Plug 'Olical/conjure', {'tag': 'v4.5.0'}

".NET
Plug 'lucasteles/fsi.vim'
Plug 'OmniSharp/omnisharp-vim'
Plug 'puremourning/vimspector'

call plug#end()
" colorscheme novum
" let g:airline_theme='jellybeans'

colorscheme onedark
let g:airline_theme='onedark'

command! Vimrc :vs $MYVIMRC


" NERDTree
map <leader>n :NERDTreeToggle<CR> " Leader + n open/close tree
map <leader>r :NERDTreeFind<cr> " Leader + r show file on tree
autocmd StdinReadPre * let s:std_in=1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.git$[[dir]]']



" VIM Airline
let g:airline#extensions#tabline#enabled = 1
set laststatus=2
let g:airline_powerline_fonts = 1

" Rainbow
let g:rainbow_active = 1 "
" au VimEnter * RainbowParenthesesToggle
" au Syntax * RainbowParenthesesLoadRound
" au Syntax * RainbowParenthesesLoadSquare
" au Syntax * RainbowParenthesesLoadBraces


" Ag
" :Ag  - Start fzf with hidden preview window that can be enabled with "?" key
" :Ag! - Start fzf in fullscreen and display the preview window above
command! -bang -nargs=* Ag
            \ call fzf#vim#grep(
            \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
            \   fzf#vim#with_preview(), <bang>0)
nnoremap <Leader>a :Ag<Space>
nnoremap <Leader>ag :Ag <C-R><C-W><CR>
vnoremap <Leader>ag y:Ag <C-r><C-r>"<CR>


"vim fortmat
noremap <Leader><C-f> :Autoformat<CR>

" CamelCaseMotion
" call camelcasemotion#CreateMotionMappings('<leader>')


"Tmux
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>

let g:tmux_resizer_no_mappings = 1
nnoremap <silent> <C-M-h> :TmuxResizeLeft<cr>
nnoremap <silent> <C-M-j> :TmuxResizeDown<cr>
nnoremap <silent> <C-M-k> :TmuxResizeUp<cr>
nnoremap <silent> <C-M-l> :TmuxResizeRight<cr>


" FZF
nnoremap <Leader>p :Buffers<CR>
nnoremap <c-p> :Files<CR>
" hide lastsatus (> fzf) on fzf
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
            \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler


" Ale
let g:ale_lint_on_text_changed = 0 "dont lint on text change
let g:ale_lint_on_save = 1 "lint on save
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
let g:ale_echo_msg_format = '%severity%: %s [%linter%]'
let g:ale_statusline_format = ['E:%s', 'W:%s', 'OK']
highlight ALEErrorSign ctermbg=NONE ctermfg=darkred
highlight ALEWarningSign ctermbg=NONE ctermfg=yellow
highlight ALEError cterm=undercurl ctermfg=none
highlight ALEWarning cterm=undercurl ctermfg=none
let g:ale_linters = { 
\ 'javascript': ['eslint'], 
\ 'scss': ['stylelint'], 
\ 'cs': ['OmniSharp'], 
\ 'elm': ['elm-ls'],
\ 'cpp': ['ccls']
\ }
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\   'scss': ['stylelint'],
\   'haskell': ['hlint']
\}
let g:ale_cpp_ccls_init_options = {
\   'cache': {
\       'directory': '/tmp/ccls/cache'
\   }
\ }

nnoremap <silent> <leader>gf :ALEDetail<cr>
nnoremap <silent> <leader>gF :ALEFix<cr>
nnoremap <silent> <leader>ge :CocDiagnostics<cr>


" Goyo
let g:goyo_width = 120
let g:goyo_height = 95

function! s:goyo_enter()
    set wrap
    set linebreak
    hi NonText ctermfg=235
    let b:quitting = 0
    let b:quitting_bang = 0
    autocmd QuitPre <buffer> let b:quitting = 1
    cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction

function! s:goyo_leave()
    set nowrap
    set nolinebreak
    " Quit Vim if this is the only remaining buffer
    if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
        if b:quitting_bang
            qa!
        else
            qa
        endif
    endif
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

nnoremap <leader><M-CR> :Goyo<CR>


" Vim Markdown
let g:vim_markdown_folding_disabled = 1



" Clojure
let g:conjure#mapping#doc_word = "K"
let g:conjure#mapping#def_word = "gd"
let g:conjure#client#clojure#nrepl#eval#auto_require = v:false

" COC.Nvim
"
let g:coc_global_extensions = ['coc-json', 'coc-conjure', 'coc-rls', 'coc-tsserver', 'coc-eslint', 'coc-fsharp']
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <F2> <Plug>(coc-rename)
nmap <leader>ac <Plug>(coc-codeaction)

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
else
    inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
if exists('*complete_info')
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Show documentation on K
function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction
nnoremap <silent> K :call <SID>show_documentation()<CR>


"Slime
let g:slime_target = "tmux"


"OmniSharp
augroup omnisharp_commands
  autocmd!

  let g:OmniSharp_diagnostic_showid = 1
  " Tabtop size 4
  autocmd FileType cs setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4

  " Show type information automatically when the cursor stops moving.
  " Note that the type is echoed to the Vim command line, and will overwrite
  " any other messages in this space including e.g. ALE linting messages.
  autocmd CursorHold *.cs OmniSharpTypeLookup

  " The following commands are contextual, based on the cursor position.
  autocmd FileType cs nmap <silent> <buffer> gd <Plug>(omnisharp_go_to_definition)
  autocmd FileType cs nmap <silent> <buffer> gr <Plug>(omnisharp_find_usages)
  autocmd FileType cs nmap <silent> <buffer> gi <Plug>(omnisharp_find_implementations)
  autocmd FileType cs nmap <silent> <buffer> gD <Plug>(omnisharp_preview_definition)
  autocmd FileType cs nmap <silent> <buffer> gI <Plug>(omnisharp_preview_implementations)
  autocmd FileType cs nmap <silent> <buffer> gy <Plug>(omnisharp_type_lookup)
  autocmd FileType cs nmap <silent> <buffer> K <Plug>(omnisharp_documentation)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfs <Plug>(omnisharp_find_symbol)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfx <Plug>(omnisharp_fix_usings)
  autocmd FileType cs nmap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)
  autocmd FileType cs imap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)

  " Navigate up and down by method/property/field
  autocmd FileType cs nmap <silent> <buffer> [[ <Plug>(omnisharp_navigate_up)
  autocmd FileType cs nmap <silent> <buffer> ]] <Plug>(omnisharp_navigate_down)
  " Find all code errors/warnings for the current solution and populate the quickfix window
  autocmd FileType cs nmap <silent> <buffer> <Leader>osgcc <Plug>(omnisharp_global_code_check)
  " Contextual code actions (uses fzf, CtrlP or unite.vim selector when available)
  autocmd FileType cs nmap <silent> <buffer> ac <Plug>(omnisharp_code_actions)
  autocmd FileType cs xmap <silent> <buffer> ac <Plug>(omnisharp_code_actions)
  " Repeat the last code action performed (does not use a selector)
  autocmd FileType cs nmap <silent> <buffer> <Leader>os. <Plug>(omnisharp_code_action_repeat)
  autocmd FileType cs xmap <silent> <buffer> <Leader>os. <Plug>(omnisharp_code_action_repeat)

  autocmd FileType cs nmap <silent> <buffer> <Leader>os= <Plug>(omnisharp_code_format)

  autocmd FileType cs nmap <silent> <buffer> rn <Plug>(omnisharp_rename)

  autocmd FileType cs nmap <silent> <buffer> <Leader>osre <Plug>(omnisharp_restart_server)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osst <Plug>(omnisharp_start_server)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ossp <Plug>(omnisharp_stop_server)
augroup END


"vimspector
let g:vimspector_enable_mappings = 'VISUAL_STUDIO'
