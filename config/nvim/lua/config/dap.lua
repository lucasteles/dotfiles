local M = {}

local function mason(file)
  return vim.fn.stdpath("data") .. '/mason/packages/' .. file
end

function M.setup()
  local status_ok, dap = pcall(require, 'dap')
  if not status_ok then
    return
  end

  dap.adapters.cppdbg  = {
    id = 'cppdbg',
    type = 'executable',
    command = mason('cpptools/extension/debugAdapters/bin/OpenDebugAD7'),
    -- windows only
    -- command = vim.env.MASON .. '/bin/OpenDebugAD7.exe',
    -- options = { detached = false }
  }

  dap.configurations.cpp = {
    {
      name = "Launch file",
      type = "cppdbg",
      request = "launch",
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      end,
      cwd = '${workspaceFolder}',
      stopAtEntry = true,
    },
    {
      name = 'Attach to gdbserver :1234',
      type = 'cppdbg',
      request = 'launch',
      MIMode = 'gdb',
      miDebuggerServerAddress = 'localhost:1234',
      miDebuggerPath = '/usr/bin/gdb',
      cwd = '${workspaceFolder}',
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      end,
    },
  }

  dap.configurations.c = dap.configurations.cpp
  dap.configurations.rust = dap.configurations.cpp

  dap.adapters.coreclr = {
    type = 'executable',
    command = mason('dotnet/netcoredbg/netcoredbg'),
    args = {'--interpreter=vscode'}
  }
  dap.configurations.cs = {
    {
      type = "coreclr",
      name = "launch - netcoredbg",
      request = "launch",
      program = function()
          return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
      end,
    },
  }

  local function SetupColors()
    vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#c23127', bg = '#31353f' })
    vim.api.nvim_set_hl(0, 'DapBreakpointRejected', { ctermbg = 0, fg = '#888ca6', bg = '#31353f' })
    vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = '#61afef', bg = '#31353f' })
    vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#98c379', bg = '#31353f' })
    vim.api.nvim_set_hl(0, 'DapHilight', { ctermbg = 0,  bg = '#31353f' })

    vim.fn.sign_define('DapBreakpoint', { text='', texthl='DapBreakpoint', linehl='DapHilight', numhl='DapBreakpoint' })
    vim.fn.sign_define('DapBreakpointCondition', { text='', texthl='DapBreakpoint', linehl='DapHilight', numhl='DapBreakpoint' })
    vim.fn.sign_define('DapBreakpointRejected', { text='󰅙', texthl='DapBreakpointRejected', linehl='DapHilight', numhl= 'DapBreakpointRejected' })
    vim.fn.sign_define('DapLogPoint', { text='', texthl='DapLogPoint', linehl='DapHilight', numhl= 'DapLogPoint' })
    vim.fn.sign_define('DapStopped', { text='󰐌', texthl='DapStopped', linehl='DapHilight', numhl= 'DapStopped' })
  end

  vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    desc = "Prevent colorscheme clearing self-defined DAP marker colors",
    callback = SetupColors,
  })

  SetupColors()
end

function M.setup_ui()
  local status_ok, dapui = pcall(require, 'dapui')
  if not status_ok then
    return
  end
  dapui.setup({})

end

return M

