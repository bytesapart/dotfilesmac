local dap = require('dap')

dap.adapters.lldb = {
  type = 'executable',
  command = '/opt/homebrew/opt/llvm/bin/lldb-vscode', -- adjust as needed
  name = "lldb"
}

dap.configurations.c = {
  {
    name = "Launch",
    type = "lldb",
    request = "launch",
    program = function()
      local cwd = vim.fn.getcwd()
      return cwd .. '/bin/debug'
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
    runInTerminal = false,
    postRunCommands = {'process handle -p true -s false -n false SIGWINCH'}
  },
}

dap.configurations.cpp = dap.configurations.c
dap.configurations.objc = dap.configurations.c
dap.configurations.rust = dap.configurations.cpp

-- Python Configurations
dap.configurations.python = {
  {
    name = "Launch Python",
    type = "python",
    request = "launch",
    justMyCode = true,
    program="${file}",
    stopOnEntry = false,
    args = {}
  },
  {
    name = "Pytest: Current File",
    type = "python",
    request = "launch",
    module = "pytest",
    justMyCode = true,
    stopOnEntry = false,
    args = {
      "${file}"
    }
  }
}
