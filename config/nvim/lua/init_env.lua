_G.prequire = function(...)
  local status, lib = pcall(require, ...)
  if status then
    return lib
  end
  return nil
end

_G.t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

_G.log = require 'utils.logger'
