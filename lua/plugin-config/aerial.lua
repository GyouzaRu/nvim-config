local status, aerial = pcall(require, "aerial")
if not status then
  vim.notify("没有找到 aerial")
  return
end

local keybindings = require('keybindings').aerial

aerial.setup({
  -- Priority list of preferred backends for aerial.
  -- This can be a filetype map (see :help aerial-filetype-map)
  backends = { "lsp", "treesitter", "markdown", "asciidoc", "man" },

  on_attach = keybindings.functionKeys_onattach(),

  -- Show box drawing characters for the tree hierarchy
  show_guides = true,

  -- A list of all symbols to display. Set to false to display all symbols.
  -- This can be a filetype map (see :help aerial-filetype-map)
  -- To see all available values, see :help SymbolKind
  filter_kind = {
    "Array",
    -- "Boolean",
    "Class",
    "Constant",
    "Constructor",
    "Enum",
    -- "EnumMember",
    "Event",
    "Field",
    "File",
    "Function",
    "Interface",
    "Key",
    "Method",
    "Module",
    "Namespace",
    "Null",
    -- "Number",
    "Object",
    "Operator",
    "Package",
    "Property",
    -- "String",
    "Struct",
    "TypeParameter",
    -- "Variable",
  }
})

keybindings.functionKeys()
