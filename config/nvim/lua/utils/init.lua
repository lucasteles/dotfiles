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

local M = {}

function M.echo(msg, hl, name)
  name = name or 'Neovim'
  hl = hl or 'Todo'
  vim.api.nvim_echo({ { name .. ': ', hl }, { msg } }, true, {})
end

function M.inspect(...)
  print(vim.inspect(...))
end

function M.dump(...)
  vim.notify(vim.inspect(...), vim.log.levels.DEBUG, { title = 'Dump' })
end

function M.warn(msg, name)
  vim.notify(msg, vim.log.levels.WARN, { title = name })
end

function M.error(msg, name)
  vim.notify(msg, vim.log.levels.ERROR, { title = name })
end

function M.info(msg, name)
  vim.notify(msg, vim.log.levels.INFO, { title = name })
end

_G.log = M
return M
