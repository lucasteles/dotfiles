local M = {}

function M.setup()
  local parser_config = require 'nvim-treesitter.parsers'.get_parser_configs()
  parser_config.fsharp = {
    install_info = {
      url = 'https://github.com/ionide/tree-sitter-fsharp',
      branch = 'main',
      files = {'src/scanner.c', 'src/parser.c' },
    },
    filetype = 'fsharp',
  }

  require('nvim-treesitter.configs').setup {
    -- One of 'all', 'maintained'(parsers with maintainers), or a list of languages
    ensure_installed =  {
      'bash',
      'c',
      'c_sharp',
      'clojure',
      'cmake',
      'comment',
      'cpp',
      'css',
      'dockerfile',
      'diff',
      'fsharp',
      'glsl',
      'hlsl',
      'go',
      'haskell',
      'hcl',
      'html',
      'http',
      'javascript', 'jsdoc', 'json', 'json5','jsonc',
      'lua', 'luadoc',
      'make',
      'markdown',
      'markdown_inline',
      'python',
      'regex',
      'rust',
      'sql',
      'toml',
      'tsx',
      'typescript',
      'vim', 'vimdoc',
      'vue',
      'wgsl',
      'yaml',
    },

   endwise = {
      enable = true,
    },
    -- Install languages synchronously (only applied to `ensure_installed`)
    sync_install = false,

    highlight = {
      -- `false` will disable the whole extension
      enable = true,
    },
  }
end

return M
