local M = {}

local function header()
  return {
    [[=================     ===============     ===============   ========  ========]],
    [[\\ . . . . . . .\\   //. . . . . . .\\   //. . . . . . .\\  \\. . .\\// . . //]],
    [[||. . ._____. . .|| ||. . ._____. . .|| ||. . ._____. . .|| || . . .\/ . . .||]],
    [[|| . .||   ||. . || || . .||   ||. . || || . .||   ||. . || ||. . . . . . . ||]],
    [[||. . ||   || . .|| ||. . ||   || . .|| ||. . ||   || . .|| || . | . . . . .||]],
    [[|| . .||   ||. _-|| ||-_ .||   ||. . || || . .||   ||. _-|| ||-_.|\ . . . . ||]],
    [[||. . ||   ||-'  || ||  `-||   || . .|| ||. . ||   ||-'  || ||  `|\_ . .|. .||]],
    [[|| . _||   ||    || ||    ||   ||_ . || || . _||   ||    || ||   |\ `-_/| . ||]],
    [[||_-' ||  .|/    || ||    \|.  || `-_|| ||_-' ||  .|/    || ||   | \  / |-_.||]],
    [[||    ||_-'      || ||      `-_||    || ||    ||_-'      || ||   | \  / |  `||]],
    [[||    `'         || ||         `'    || ||    `'         || ||   | \  / |   ||]],
    [[||            .===' `===.         .==='.`===.         .===' /==. |  \/  |   ||]],
    [[||         .=='   \_|-_ `===. .==='   _|_   `===. .===' _-|/   `==  \/  |   ||]],
    [[||      .=='    _-'    `-_  `='    _-'   `-_    `='  _-'   `-_  /|  \/  |   ||]],
    [[||   .=='    _-'          `-__\._-'         `-_./__-'         `' |. /|  |   ||]],
    [[||.=='    _-'            /\ \ \___  ___/\   /(_)_ __ ___          `' |  /==.||]],
    [[=='    _-'              /  \/ / _ \/ _ \ \ / | | '_ ` _ \             \/   `==]],
    [[\   _-'                / /\  |  __| (_) \ V /| | | | | | |             `-_   /]],
    [[ `''                   \_\ \/ \___|\___/ \_/ |_|_| |_| |_|               ``' ]],
    [[                                                                             ]],
  }
end


function M.setup()
  local status_ok, dashboard = pcall(require, "dashboard")
  if not status_ok then
    return
  end

  local hl_links = {
    ['DashboardHeader'] = 'Identifier',
    ['DashboardFooter'] = 'Comment',
    ['DashboardDesc'] = 'Text',
    ['DashboardKey'] = 'Number',
    ['DashboardIcon'] = 'Special',
    ['DashboardShortCut'] = 'Comment',
  }

  for name, link in pairs(hl_links) do
    vim.api.nvim_set_hl(0, name, { link = link })
  end

  dashboard.setup {
    theme = 'doom',
    hide = {
      statusline = false,
    },
    config = {
      header = header(),
      center = {
        { action = 'ene | startinsert', desc = " New file", icon = " ", key = "e", key_format = ' %s' },
        { action = "Telescope find_files", desc = " Find file", icon = " ", key = "f", key_format = ' %s' },
        { action = "Telescope oldfiles", desc = " Recent files", icon = " ", key = "r", key_format = ' %s'  },
        { action = "Telescope live_grep",desc = " Find text",icon = " ", key = "g", key_format = ' %s'  },
        { action = 'e $MYVIMRC', desc = " Configuration", icon = " ", key = "c", key_format = ' %s' },
        { action = 'Lazy', desc = " Plugins", icon = " ", key = "p", key_format = ' %s' },
        { action = function() vim.api.nvim_input("<cmd>qa<cr>") end, desc = " Quit", icon = " ", key = "q",  key_format = ' %s' },
      },
      footer = function()
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        local datetime = os.date "󰃭 %d-%m-%Y  %H:%M:%S - "
        return { "⚡ Neovim loaded - " .. datetime .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }

      end,
    },
  }
end

return M
