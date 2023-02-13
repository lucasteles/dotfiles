local M = {}

local lsp_signature = require "lsp_signature"

local signs = { { name = "DiagnosticSignError", text = "" },
                { name = "DiagnosticSignWarn", text = "" },
                { name = "DiagnosticSignHint", text = "" },
                { name = "DiagnosticSignInfo", text = "" }, }


function M.setup()

  for _, sign in ipairs(signs) do
      vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
  end

  lsp_signature.setup {
    bind = true,
    handler_opts = {
      border = "rounded",
    },
  }
end

return M

