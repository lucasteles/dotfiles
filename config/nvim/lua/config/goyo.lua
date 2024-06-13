local M = {}

function M.setup()
    vim.cmd [[
        let g:goyo_height='90%'
        let g:goyo_width='80%'

        function! s:goyo_enter()
            if executable('tmux') && strlen($TMUX)
                silent !tmux set status off
                silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
            endif


            set noshowmode
            set noshowcmd
            set scrolloff=999
        endfunction

        function! s:goyo_leave()
            if executable('tmux') && strlen($TMUX)
                silent !tmux set status on
                silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
            endif
            set showmode
            set showcmd
            set scrolloff=5
        endfunction

        autocmd! User GoyoEnter nested call <SID>goyo_enter()
        autocmd! User GoyoLeave nested call <SID>goyo_leave()
        autocmd VimResized * if exists('#goyo') | exe "normal \<c-w>=" | endif
    ]]
end

return M
