local M = {}

function M.setup()
    local navic = require 'nvim-navic'

    navic.setup {
        lsp = {
            auto_attach = false,
            preference = nil,
        },
        highlight = false,
        separator = ' > ',
        depth_limit = 0,
        depth_limit_indicator = '..',
        safe_output = true,
        lazy_update_context = false,
        click = true,
        format_text = function(text)
            return text
        end,
    }
end

return M
