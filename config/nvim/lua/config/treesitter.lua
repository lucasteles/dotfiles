local M = {}

function M.setup()
  require("nvim-treesitter.configs").setup {
    -- One of "all", "maintained" (parsers with maintainers), or a list of languages
    ensure_installed =  {
      "c", "lua", "rust",
      "bash" ,
      "c_sharp" ,
      "clojure" ,
      "cmake" ,
      "comment" ,
      "cpp" ,
      "css" ,
      "dockerfile" ,
      "fennel" ,
      "glsl" ,
      "go" ,
      "graphql" ,
      "haskell",
      "hcl" ,
      "html" ,
      "http" ,
      "javascript" , "jsdoc" , "json", "json5","jsonc" ,
      "make" ,
      "markdown" ,
      "markdown_inline" ,
      "ocaml" ,
      "ocaml_interface" ,
      "ocamllex" ,
      "python" ,
      "regex" ,
      "scheme" ,
      "scss" ,
      "sql" ,
      "toml" ,
      "tsx" ,
      "typescript" ,
      "vim" ,
      "vue" ,
      "wgsl" ,
      "yaml" ,
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
