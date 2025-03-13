local setup = {
  settings = {
    pylsp = {
      configurationSources = { 'flake8' },
      plugins = {
        flake8 = {
          enabled = false,
          ignore = { 'E501', 'E231' },
          maxLineLength = 80,
        },
        black = { enabled = true },
        autopep8 = { enabled = false },
        mccabe = { enabled = false },
        pycodestyle = {
          enabled = false,
          ignore = { 'E501', 'E231' },
          maxLineLength = 80,
        },
        pyflakes = { enabled = false },
      },
    },
  },
}

return setup
