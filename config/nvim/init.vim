set clipboard=unnamed
syntax on
filetype plugin indent on
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
set colorcolumn=120
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

nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

vnoremap <C-r> "hy:%s/\<<C-r>h\>//gc<left><left><left

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

" for json files, 2 spaces
autocmd Filetype json setlocal ts=2 sw=2 sts=0 expandtab
augroup json_base
  au!
  autocmd BufNewFile,BufRead *.json.base  set ft=json
augroup END


vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>
" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
      \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
      \gvy/<C-R>=&ic?'\c':'\C'<CR><C-R><C-R>=substitute(
      \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
      \gVzv:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
      \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
      \gvy?<C-R>=&ic?'\c':'\C'<CR><C-R><C-R>=substitute(
      \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
      \gVzv:call setreg('"', old_reg, old_regtype)<CR>


" Utilities
Plug 'junegunn/vim-plug'
Plug 'w0rp/ale'
" Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jpalardy/vim-slime'
Plug 'dhruvasagar/vim-zoom'
Plug 'junegunn/goyo.vim'                            " Distraction free mode
Plug 'tpope/vim-repeat'
" Plug 'vim-test/vim-test'

"Navigation
Plug 'bkad/CamelCaseMotion'
Plug 'tmhedberg/matchit'
Plug 'vim-scripts/BufOnly.vim'

" Text transformations
Plug 'vim-scripts/ReplaceWithRegister' "replace withot losing yank with gr
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'tpope/vim-commentary'
" Plug 'wellle/targets.vim'
Plug 'tpope/vim-surround'
Plug 'Chiel92/vim-autoformat'
Plug 'guns/vim-sexp'
Plug 'tommcdo/vim-exchange' " exchange text with cx
Plug 'kana/vim-textobj-user' " vim-textobj-entire
Plug 'kana/vim-textobj-entire' "{motion}ae  entire buffer
"Plug 'cohama/lexima.vim' "auto close parenthesis
Plug 'junegunn/vim-easy-align' "Text alignment  j

"Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Files
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'mcchrish/nnn.vim'

" Themes / VIsual
Plug 'arcticicestudio/nord-vim'
Plug 'rakr/vim-one'
Plug 'joshdick/onedark.vim'
Plug 'kadekillary/Turtles'

Plug 'ryanoasis/vim-devicons'
Plug 'kshenoy/vim-signature'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'luochen1990/rainbow'
Plug 'machakann/vim-highlightedyank'

" Web
Plug 'mattn/emmet-vim'
Plug 'pangloss/vim-javascript'
Plug 'plasticboy/vim-markdown'
Plug 'mxw/vim-jsx'

"Tmux
Plug 'christoomey/vim-tmux-navigator'
Plug 'melonmanchan/vim-tmux-resizer'
Plug 'RyanMillerC/better-vim-tmux-resizer'

"Clojure
Plug 'lucasteles/vim-clojure-static', {'for': 'clojure' }
" Plug 'tpope/vim-fireplace', {'for': 'clojure'}
Plug 'bakpakin/fennel.vim'
" Plug 'jrdoane/vim-clojure-highlight'
Plug 'Olical/AnsiEsc'
Plug 'Olical/conjure'

".NET
" Plug 'lucasteles/fsi.vim'
" Plug 'OmniSharp/omnisharp-vim'
" Plug 'puremourning/vimspector'

"Flutter
" Plug 'dart-lang/dart-vim-plugin'
" Plug 'thosakwe/vim-flutter'

call plug#end()

set termguicolors
" colorscheme turtles
colorscheme one

command! Vimrc :vs $MYVIMRC

" NERDTree
map <leader>n :NERDTreeToggle<CR> " Leader + n open/close tree
map <leader>r :NERDTreeFind<cr> " Leader + r show file on tree
autocmd StdinReadPre * let s:std_in=1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.git$[[dir]]']



" VIM Airline

let g:airline_theme='one'
let g:airline#extensions#tabline#enabled = 1
set laststatus=2
let g:airline_powerline_fonts = 1

" Rainbow
let g:rainbow_active = 1 "
let lightcolors =  ['lightblue', 'lightyellow', 'red', 'darkgreen', 'darkyellow', 'lightred', 'yellow', 'cyan', 'magenta', 'white']
let darkcolors =  ['blue', 'yellow', 'red', 'green', 'yellow', 'red',  'cyan', 'magenta', 'white']
let g:rainbow_conf = {
      \   'ctermfgs': darkcolors
      \}


" Ag
" :Ag  - Start fzf with hidden preview window that can be enabled with "?" key
" :Ag! - Start fzf in fullscreen and display the preview window above
"
let $FZF_DEFAULT_OPTS = '--color hl:underline:reverse,hl+:underline:reverse'
command! -bang -nargs=* Ag
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 0,
      \   fzf#vim#with_preview(), <bang>0)

nnoremap <Leader>a :Ag<Space>
nnoremap <Leader>ag :Ag <C-R><C-W><CR>
vnoremap <Leader>ag y:Ag <C-r><C-r>"<CR>


"vim fortmat
noremap <Leader><C-f> :Autoformat<CR>

" CamelCaseMotion
" map <silent> w <Plug>CamelCaseMotion_w
" map <silent> b <Plug>CamelCaseMotion_b
" map <silent> e <Plug>CamelCaseMotion_e
" map <silent> ge <Plug>CamelCaseMotion_ge

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
let g:ale_sign_column_always = 1
let g:ale_lint_on_text_changed = 0 "dont lint on text change
let g:ale_lint_on_save = 1 "lint on save
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
let g:ale_echo_msg_format = '%severity%: %s [%linter%]'
let g:ale_statusline_format = ['E:%s', 'W:%s', 'OK']

" highlight ALEErrorSign ctermbg=NONE ctermfg=red
" highlight ALEWarningSign ctermbg=NONE ctermfg=yellow

let g:ale_linters = {
      \ 'javascript': ['eslint'],
      \ 'scss': ['stylelint'],
      \ 'elm': ['elm-ls'],
      \ 'clojure': [],
      \ 'cpp': ['ccls']
      \ }

" \ 'cs': ['OmniSharp'],

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

nnoremap <M-CR> :Goyo<CR>


" Vim Markdown
let g:vim_markdown_folding_disabled = 1

" Clojure
let g:conjure#mapping#doc_word = "K"
let g:conjure#mapping#def_word = "gd"
let g:conjure#client#clojure#nrepl#eval#auto_require = v:false

" disable gd
" let g:conjure#mapping#def_word = v:

" disable K
"let g:conjure#mapping#doc_word = v:false

" disable HUD
" let g:conjure#log#hud#enabled = v:false


" Plug 'tpope/vim-fireplace'
nmap <localleader><localleader>rr :Require<cr>
nmap <localleader><localleader>ee :Eval<cr>
nmap <localleader><localleader>tn :RunTests<cr>

augroup clojure
  au Syntax clojure nmap <buffer> gD <Plug>FireplaceDjump
    augroup END


" COC.Nvim
"
let g:coc_global_extensions = ['coc-json', 'coc-conjure', 'coc-rls', 'coc-tsserver', 'coc-eslint', 'coc-fsharp', 'coc-flutter']
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> <leader>gr <Plug>(coc-references)
nmap <F2> <Plug>(coc-rename)
nmap <leader>ac <Plug>(coc-codeaction)
nmap <leader><leader>a :call coc#util#float_hide()<CR>

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
"augroup omnisharp_commands
"  autocmd!

"  let g:OmniSharp_diagnostic_showid = 1
"  " Tabtop size 4
"  autocmd FileType cs setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4

"  " Show type information automatically when the cursor stops moving.
"  " Note that the type is echoed to the Vim command line, and will overwrite
"  " any other messages in this space including e.g. ALE linting messages.
"  autocmd CursorHold *.cs OmniSharpTypeLookup

"  " The following commands are contextual, based on the cursor position.
"  autocmd FileType cs nmap <silent> <buffer> gd <Plug>(omnisharp_go_to_definition)
"  autocmd FileType cs nmap <silent> <buffer> gr <Plug>(omnisharp_find_usages)
"  autocmd FileType cs nmap <silent> <buffer> gi <Plug>(omnisharp_find_implementations)
"  autocmd FileType cs nmap <silent> <buffer> gD <Plug>(omnisharp_preview_definition)
"  autocmd FileType cs nmap <silent> <buffer> gI <Plug>(omnisharp_preview_implementations)
"  autocmd FileType cs nmap <silent> <buffer> gy <Plug>(omnisharp_type_lookup)
"  autocmd FileType cs nmap <silent> <buffer> K <Plug>(omnisharp_documentation)
"  autocmd FileType cs nmap <silent> <buffer> <Leader><Leader>s <Plug>(omnisharp_find_symbol)
"  autocmd FileType cs nmap <silent> <buffer> <Leader><Leader>f <Plug>(omnisharp_fix_usings)
"  autocmd FileType cs nmap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)
"  autocmd FileType cs imap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)

"  " Navigate up and down by method/property/field
"  autocmd FileType cs nmap <silent> <buffer> [[ <Plug>(omnisharp_navigate_up)
"  autocmd FileType cs nmap <silent> <buffer> ]] <Plug>(omnisharp_navigate_down)
"  " Find all code errors/warnings for the current solution and populate the quickfix window
"  autocmd FileType cs nmap <silent> <buffer> <Leader>osgcc <Plug>(omnisharp_global_code_check)
"  " Contextual code actions (uses fzf, CtrlP or unite.vim selector when available)
"  autocmd FileType cs nmap <silent> <buffer> ac <Plug>(omnisharp_code_actions)
"  " Repeat the last code action performed (does not use a selector)
"  autocmd FileType cs nmap <silent> <buffer> <Leader>os. <Plug>(omnisharp_code_action_repeat)
"  autocmd FileType cs xmap <silent> <buffer> <Leader>os. <Plug>(omnisharp_code_action_repeat)

"  autocmd FileType cs nmap <silent> <buffer> <Leader>os= <Plug>(omnisharp_code_format)

"  autocmd FileType cs nmap <silent> <buffer> rn <Plug>(omnisharp_rename)

"  autocmd FileType cs nmap <silent> <buffer> <Leader>osre <Plug>(omnisharp_restart_server)
"  autocmd FileType cs nmap <silent> <buffer> <Leader>osst <Plug>(omnisharp_start_server)
"  autocmd FileType cs nmap <silent> <buffer> <Leader>ossp <Plug>(omnisharp_stop_server)
"augroup END


""vimspector
"let g:vimspector_enable_mappings = 'VISUAL_STUDIO'

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

nnoremap <leader><leader><TAB> :bp!<CR>
nnoremap <leader><TAB> :bn!<CR>
nnoremap <leader>q :bp<cr>:bd #<cr>

""ansi Esc
autocmd BufEnter conjure-log-* AnsiEsc
" augroup AnsiEscQuickFix
"     autocmd!
"     autocmd FileType qf silent! :AnsiEsc
" augroup END


autocmd BufEnter,BufNew,BufRead conjure-log-*  set ft=clojure

" entire
nnoremap <leader><leader>d :norm ggdG<CR>

" nnn
" Disable default mappings
let g:nnn#set_default_mappings = 0

" Start nnn in the current file's directory
nnoremap <leader>m :NnnPicker %:p:h<CR>
" Floating window (neovim latest and vim with patch 8.2.191)
let g:nnn#layout = { 'window': { 'width': 0.9, 'height': 0.6, 'highlight': 'Debug' } }


" vim zoom 
" set statusline+=%{zoom#statusline()}
nmap <C-W>z <Plug>(zoom-toggle)
function! AirlineInit()
  call g:airline#parts#define_raw('zoom', '%{zoom#statusline()}')
  let g:airline_section_y = airline#section#create_right(['ffenc', 'zoom'])
endfunction
autocmd VimEnter * call AirlineInit()

" autocmd BufRead *.clj try | silent! Require | catch /^Fireplace/ | endtry
