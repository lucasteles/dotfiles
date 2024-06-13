require 'custom.yank'

vim.cmd [[
  autocmd Filetype json setlocal ts=2 sw=2 sts=0 expandtab
  augroup json_base
    au!
    autocmd BufNewFile,BufRead *.json.base  set ft=json
  augroup END
]]

