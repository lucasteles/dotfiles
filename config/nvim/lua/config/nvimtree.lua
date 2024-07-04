local M = {}

function M.setup()
  require('nvim-tree').setup {
    sort_by = 'case_sensitive',
    view = {
      number = true,
      relativenumber = true,
      adaptive_size = true,
    },
    filters = {
      custom = {'^\\.git$'},
    },
    update_cwd = true,
    update_focused_file = {
      enable = true,
      update_cwd = true,
    },
    renderer = {
      group_empty = true,
      indent_markers = {enable = false},
      icons = {
        git_placement = 'after',
      },
    },
    on_attach = function(bufnr)
      local api = require 'nvim-tree.api'

      local function opts (desc)
        return { buffer = bufnr, desc = ('nvim-tree: ' .. desc),
                 noremap = true, nowait = true, silent = true }
      end

      api.config.mappings.default_on_attach(bufnr)
      vim.keymap.set('n', 'U', api.tree.change_root_to_node, opts('CD'))
      vim.keymap.set('n', 'u', api.tree.toggle_custom_filter, opts('Toggle Hidden'))
    end,
  }
end

return M

