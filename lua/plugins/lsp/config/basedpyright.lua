local setup=({
  settings = {
    basedpyright = {
      analysis = {
        typeCheckingMode = "standard", -- Options: "off", "basic", "standard", "strict", "all"
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
  },
})

return setup
