-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

local status, lazy = pcall(require, "lazy")
if not status then
  vim.notify("没有找到 lazy.nvim")
  return
end

-- Only load when Linux
local function Unload_in_windows()
  if vim.uv.os_uname().sysname == "Linux" or vim.uv.os_uname().sysname == "Darwin" then
    return true
  else
    return false
  end
end

lazy.setup({
  -- 你的插件列表...
  ---- colorschemes ----
  -- tokyonight
  -- {"folke/tokyonight.nvim",
  --   lazy = false,
  --   priority = 1000},

  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      require("plugins.themes.catppuccin")
    end,
    lazy = false,
    priority = 1000
  },

  -- { "ellisonleao/gruvbox.nvim",
  --   priority = 1000 ,
  --   config = true,
  --   opts = ...},
  ---- plugins ----
  -- nvim-tree
  -- {"nvim-tree/nvim-tree.lua",
  --     lazy = true,
  --     config = function()
  --       require("plugins.nvim-tree")
  --     end,
  --     keys = { {"<leader>n",":NvimTreeToggle<CR>",desc="Nvim-Tree"} },
  --     dependencies = {"nvim-tree/nvim-web-devicons"}},
  -- neotree
  -- {
  --   "nvim-neo-tree/neo-tree.nvim",
  --   event = 'VimEnter',
  --   config = function()
  --     require("plugins.neotree")
  --   end,
  --   dependencies = {
  --     -- necessary
  --     "nvim-lua/plenary.nvim",
  --     "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
  --     "MunifTanjim/nui.nvim" }
  -- },

  -- mini files
  {
    'echasnovski/mini.files',
    version = false,
    event = 'VimEnter',
    config = function()
      require("plugins.mini-files")
    end,
  },

  -- bufferline
  {
    "akinsho/bufferline.nvim",
    event = { 'BufNewFile', 'BufReadPre' },
    config = function()
      require("plugins.bufferline")
    end,
    -- dependencies = {"moll/vim-bbye" }},
    dependencies = { "nvim-tree/nvim-web-devicons" }
  },

  -- tabline
  -- {"nanozuki/tabby.nvim",
  --     lazy = true},

  -- lualine
  {
    "nvim-lualine/lualine.nvim",
    event = 'VimEnter',
    config = function()
      require("plugins.lualine")
    end,
    dependencies = { "arkav/lualine-lsp-progress" }
  },

  -- barbecue: vscode winbar
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    event = 'VimEnter',
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {
      -- configurations go here
    },
  },

  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    event = 'VimEnter',
    config = function()
      require("plugins.telescope")
    end,
    dependencies = {
      -- necessary
      "nvim-lua/plenary.nvim", }
  },
  {
    "ahmedkhalf/project.nvim",
    event = 'VimEnter',
    config = function()
      require("plugins.project")
    end,
    dependencies = { "nvim-telescope/telescope.nvim" }
  },

  -- dashboard-nvim
  {
    "glepnir/dashboard-nvim",
    event = 'VimEnter',
    config = function()
      require("plugins.dashboard")
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" }
  },

  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    event = { 'BufNewFile', 'BufReadPre' },
    config = function()
      require("plugins.nvim-treesitter")
    end,
    -- tag = "v0.9.2",
    enabled = Unload_in_windows,
    -- cmd = "TSUpdate"
  },

  -- code outline
  {
    'stevearc/aerial.nvim',
    event = { 'BufNewFile', 'BufReadPre' },
    config = function()
      require("plugins.aerial")
    end,
    opts = {},
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
  },

  -- surround
  {
    "kylechui/nvim-surround",
    event = { 'BufNewFile', 'BufReadPre' },
    config = function()
      require("plugins.nvim-surround")
    end,
    lazy = true
  },

  -- nvim-autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("plugins.nvim-autopairs")
    end,
  },

  -- comment
  {
    "numToStr/Comment.nvim",
    event = { 'BufNewFile', 'BufReadPre' },
    config = function()
      require("plugins.comment")
    end,
  },
  -- Float terminal
  -- {
  --   "numToStr/FTerm.nvim",
  --   event = 'VimEnter',
  --   config = function()
  --     require("plugins.FTerm")
  --   end,
  -- },

  -- git sign
  {
    "lewis6991/gitsigns.nvim",
    event = { 'BufNewFile', 'BufReadPre' },
    config = function()
      require("plugins.gitsigns")
    end,
  },

  -- navi with tmux
  {
    "alexghergh/nvim-tmux-navigation",
    event = 'VimEnter',
    config = function()
      require("plugins.nvim-tmux-navigation")
    end,
    enabled = Unload_in_windows,
  },

  -- indent blank line
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { 'BufNewFile', 'BufReadPre' },
    config = function()
      require("plugins.indent-blankline")
    end,
  },

  {
    "skywind3000/asyncrun.vim",
    event = { 'BufNewFile', 'BufReadPre' },
    config = function()
      require("plugins.async")
    end,
  },

  -- view symbols based on LSP
  -- {
  --   "simrat39/symbols-outline.nvim",
  --   event = { 'BufNewFile', 'BufReadPre' },
  --   config = function()
  --     require("plugins.symbols-outline")
  --   end,
  -- },
  -- message UI
  -- {"folke/noice.nvim",
  --     event = 'VeryLazy',
  --     config = function()
  --         require("plugins.noice")
  --     end,
  --     dependencies = {
  --       "MunifTanjim/nui.nvim",
  --       -- "rcarriga/nvim-notify"
  -- }},

  -- Lspconfig
  {
    "neovim/nvim-lspconfig",
    -- event = 'VimEnter',
    event = { 'BufNewFile', 'BufReadPre' },
    config = function()
      require("plugins.lsp.setup")
      require("plugins.lsp.ui")
    end,
    enabled = Unload_in_windows,
    -- lazy = true
  },

  -- mason !!! Lazy-loading mason is not recommended
  {
    "williamboman/mason.nvim",
    -- event = 'VimEnter',
    config = function()
      require("plugins.mason")
    end,
    enabled = Unload_in_windows,
    -- lazy = true
  },
  {
    "williamboman/mason-lspconfig.nvim",
    enabled = Unload_in_windows,
    -- event = 'VimEnter',
  },

  {
    "stevearc/conform.nvim",
    -- load cmp on InsertEnter
    event = { 'BufNewFile', 'BufReadPre' },
    config = function()
      require("plugins.nvim-conform")
    end,
  },

  -- Markdown
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function(plugin)
      if vim.fn.executable "npx" then
        vim.cmd("!cd " .. plugin.dir .. " && cd app && npx --yes yarn install")
      else
        vim.cmd [[Lazy load markdown-preview.nvim]]
        vim.fn["mkdp#util#install"]()
      end
    end,
    init = function()
      if vim.fn.executable "npx" then vim.g.mkdp_filetypes = { "markdown" } end
    end,
  },

  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    ft = { "markdown", "codecompanion" },
    opts = {},
  },

  -- log highlight
  {
    'fei6409/log-highlight.nvim',
    event = { 'BufNewFile', 'BufReadPre' },
    config = function()
        require('log-highlight').setup {}
    end,
  },

  -- Auto complete
  {
    "hrsh7th/nvim-cmp",
    -- load cmp on InsertEnter
    event = "VimEnter",
    config = function()
      require("plugins.cmp")
    end,
    -- these dependencies will only be loaded when cmp loads
    -- dependencies are always lazy-loaded unless specified otherwise
    dependencies = {
      -- snippet 引擎
      "hrsh7th/vim-vsnip",
      -- 补全源
      "hrsh7th/cmp-vsnip",
      "hrsh7th/cmp-nvim-lsp", -- { name = nvim_lsp }
      "hrsh7th/cmp-buffer",   -- { name = 'buffer' },
      "hrsh7th/cmp-path",     -- { name = 'path' }
      "hrsh7th/cmp-cmdline",  -- { name = 'cmdline' }
    },
  },
  -- 常见编程语言代码段
  {
    "rafamadriz/friendly-snippets",
    event = { 'BufNewFile', 'BufReadPre' },
    dependencies = {
      -- snippet 引擎
      "hrsh7th/vim-vsnip",
    },
  },

  -- -- fitten code
  -- {
  --   'luozhiya/fittencode.nvim',
  --   config = function()
  --     require('plugins.fitten-code')
  --   end,
  -- },

-- lazy.nvim
{
  "olimorris/codecompanion.nvim",
  config = function()
    require('plugins.code-companion')
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "ravitemer/codecompanion-history.nvim"
  },
  opts = {
    -- NOTE: The log_level is in `opts.opts`
    opts = {
      log_level = "DEBUG", -- or "TRACE"
    },
  },
},

  {
    "supermaven-inc/supermaven-nvim",
    config = function()
      require('plugins.supermaven')
    end,
  },

  -- Dap
  {
    "mfussenegger/nvim-dap",
    cmd = { "DapToggleBreakpoint", "DapContinue" },
    config = function()
      require("plugins.dap.setup")
    end,
    enabled = Unload_in_windows,
  },
  {
    "rcarriga/nvim-dap-ui",
    lazy = true,
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio"
    },
    enabled = Unload_in_windows,
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    lazy = true,
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    enabled = Unload_in_windows,
  },
})
