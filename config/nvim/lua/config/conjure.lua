local M = {}


function M.setup()

vim.cmd [[
    let g:conjure#mapping#doc_word = "K"
    let g:conjure#mapping#def_word = "gd"
    let g:conjure#client#clojure#nrepl#eval#auto_require = v:false
    nmap <localleader><localleader>rr :Require<cr>
    nmap <localleader><localleader>ee :Eval<cr>
    nmap <localleader><localleader>tn :RunTests<cr>   
]]

end

return M

