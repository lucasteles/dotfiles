
local M = {}

function M.setup()
    local status_ok, neoscroll = pcall(require, "neoscroll")
    if not status_ok then
      return
    end

    neoscroll.setup {
        pre_hook = function(info) if info == "cursorline" then vim.wo.cursorline = false end end,
        post_hook = function(info) if info == "cursorline" then vim.wo.cursorline = true end end
    }

    local config = {
        ['<A-u>'] = {'scroll', {'-vim.api.nvim_win_get_height(0)', 'true', '200'}},
        ['<A-d>'] = {'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '200'}},

        ['<C-b>'] = {'scroll', {'-vim.api.nvim_win_get_height(0)', 'true', '200'}},
        ['<C-f>'] = {'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '200'}},

        ['<A-w>'] = {'scroll', {'-vim.wo.scroll', 'false', '120', [['sine']]}},
        ['<A-s>'] = {'scroll', { 'vim.wo.scroll', 'false', '120', [['sine']]}},

        ['zz'] = {'zz', {'150'}},
        ['zb'] = {'zb', {'150'}},
    }

    require('neoscroll.config').set_mappings(config)
end

return M
