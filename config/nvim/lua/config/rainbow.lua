local M = {}

function M.setup()
    local status_ok, rainbow_delimiters = pcall(require, 'rainbow-delimiters')
    if not status_ok then
        return
    end

    vim.g.rainbow_delimiters = {
        strategy = {
            [''] = rainbow_delimiters.strategy['global'],
            vim = rainbow_delimiters.strategy['local'],
        },
        query = {
            [''] = 'rainbow-delimiters',
            lua = 'rainbow-blocks',
        },
        priority = {
            [''] = 110,
            lua = 210,
        },
        highlight = {
            'RainbowDelimiterYellow',
            'RainbowDelimiterViolet',
            'RainbowDelimiterBlue',
            'RainbowDelimiterRed',
            'RainbowDelimiterCyan',
            'RainbowDelimiterOrange',
            'RainbowDelimiterGreen',
        },
    }

    colors = {
        ['RainbowDelimiterYellow'] = '#ffd602',
        ['RainbowDelimiterViolet'] = '#da70d6',
        ['RainbowDelimiterBlue'] = '#169fff',
        ['RainbowDelimiterRed'] = '#e06c75',
        ['RainbowDelimiterCyan'] = '#2bbac5',
        ['RainbowDelimiterOrange'] = '#d19a66',
        ['RainbowDelimiterGreen'] = '#89ca79',
    }

    for name, color in pairs(colors) do
      vim.cmd("au ColorScheme * highlight " .. name .. " ctermfg=White guifg=" .. color)
    end
end

return M
