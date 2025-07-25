-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out =
    vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { "tpope/vim-fugitive" },
    {
      "nvim-lualine/lualine.nvim",
      event = "VeryLazy",
      init = function()
        vim.g.lualine_laststatus = vim.o.laststatus
        if vim.fn.argc(-1) > 0 then
          -- set an empty statusline till lualine loads
          vim.o.statusline = " "
        else
          -- hide the statusline on the starter page
          vim.o.laststatus = 0
        end
      end,
    },

    {
      "danymat/neogen",
      config = true,
    },
    {
      "saghen/blink.cmp",
      -- optional: provides snippets for the snippet source
      -- dependencies = { "rafamadriz/friendly-snippets" },

      -- use a release tag to download pre-built binaries
      version = "1.*",

      opts = {
        -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
        -- 'super-tab' for mappings similar to vscode (tab to accept)
        -- 'enter' for enter to accept
        -- 'none' for no mappings
        --
        -- All presets have the following mappings:
        -- C-space: Open menu or open docs if already open
        -- C-n/C-p or Up/Down: Select next/previous item
        -- C-e: Hide menu
        -- C-k: Toggle signature help (if signature.enabled = true)
        --
        -- See :h blink-cmp-config-keymap for defining your own keymap
        keymap = {
          preset = "default",
        },

        appearance = {
          -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
          -- Adjusts spacing to ensure icons are aligned
          nerd_font_variant = "mono",
        },

        -- (Default) Only show the documentation popup when manually triggered
        completion = {
          documentation = { auto_show = true, auto_show_delay_ms = 500 },
        },

        -- Default list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, due to `opts_extend`
        sources = {
          default = { "lsp", "path", "snippets", "buffer" },
        },

        -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
        -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
        -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
        --
        -- See the fuzzy documentation for more information
        fuzzy = { implementation = "prefer_rust_with_warning" },
      },
      opts_extend = { "sources.default" },
    },
    {
      "stevearc/conform.nvim",
      -- 	event = { "BufWritePre" },
      -- 	cmd = { "ConformInfo" },
      -- 	keys = {
      -- 		{
      -- 			-- Customize or remove this keymap to your liking
      -- 			"<leader>f",
      -- 			function()
      -- 				require("conform").format({ async = true })
      -- 			end,
      -- 			mode = "",
      -- 			desc = "Format buffer",
      -- 		},
      -- 	},
      -- This will provide type hinting with LuaLS
      ---@module "conform"
      ---@type conform.setupOpts
      opts = {
        -- Define your formatters
        formatters_by_ft = {
          ruby = { "rubocop" },
          http = { "kulala" },
          lua = { "stylua" },
          python = { "ruff" },
          typescript = { "biome", "eslint_d" },
          typescriptreact = { "biome", "eslint_d" },
          javascript = { "biome", "eslint_d" },
          javascriptreact = { "biome", "eslint_d" },
          json = { "biome" },
          jsonc = { "biome" },
          svelte = { "biome", "eslint_d" },
          -- terraform = { "terraform_fmt" },
          -- tf = { "terraform_fmt" },
          rust = { "rustfmt", lsp_format = "fallback" },
          -- hcl = { "packer_fmt" },
          sql = { "sqruff" },
          ["terraform-vars"] = { "terraform_fmt" },
        },
        -- Set default options
        default_format_opts = {
          lsp_format = "fallback",
        },
        format_on_save = {
          lsp_format = "fallback",
          timeout_ms = 500,
        },
        formatters = {
          kulala = {
            command = "kulala-fmt",
            args = { "format", "$FILENAME" },
            stdin = false,
          },
          shfmt = {
            prepend_args = { "-i", "2" },
          },
        },
      },
      -- init = function()
      --   -- If you want the formatexpr, here is the place to set it
      --   vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
      -- end,
    },
    {
      "mfussenegger/nvim-lint",
      opts = {
        events = { "BufWritePost", "BufReadPost", "InsertLeave" },
        linters_by_ft = {
          -- shellcheck
          -- Use the "*" filetype to run linters on all filetypes.
          -- ['*'] = { 'global linter' },
          -- Use the "_" filetype to run linters on filetypes that don't have other linters configured.
          -- ['_'] = { 'fallback linter' },
          -- ["*"] = { "typos-cli" },
          json = { "biome" },
          jsonc = { "biome" },
          typescript = { "biome", "eslint_d" },
          typescriptreact = { "biome", "eslint_d" },
          javascript = { "biome", "eslint_d" },
          javascriptreact = { "biome", "eslint_d" },
          svelte = { "svelte_language_server" },
          docker = { "hadolint" },
          ruby = { "rubocop" },
          python = { "ruff" },
          -- terraform = { "terraform_validate", "tflint" },
          -- tf = { "terraform_validate", "tflint" },
          sql = { "sqruff" },
          css = { "stylelint" },
          yaml = { "yamllint" },
        },
        -- LazyVim extension to easily override linter options
        -- or add custom linters.
        ---@type table<string,table>
        linters = {
          -- -- Example of using selene only when a selene.toml file is present
          -- selene = {
          --   -- `condition` is another LazyVim extension that allows you to
          --   -- dynamically enable/disable linters based on the context.
          --   condition = function(ctx)
          --     return vim.fs.find({ "selene.toml" }, { path = ctx.filename, upward = true })[1]
          --   end,
          -- },
        },
      },
      config = function(_, opts)
        local M = {}

        local lint = require("lint")
        for name, linter in pairs(opts.linters) do
          if type(linter) == "table" and type(lint.linters[name]) == "table" then
            lint.linters[name] = vim.tbl_deep_extend("force", lint.linters[name], linter)
            if type(linter.prepend_args) == "table" then
              lint.linters[name].args = lint.linters[name].args or {}
              vim.list_extend(lint.linters[name].args, linter.prepend_args)
            end
          else
            lint.linters[name] = linter
          end
        end
        lint.linters_by_ft = opts.linters_by_ft

        function M.debounce(ms, fn)
          local timer = vim.uv.new_timer()
          return function(...)
            local argv = { ... }
            timer:start(ms, 0, function()
              timer:stop()
              vim.schedule_wrap(fn)(unpack(argv))
            end)
          end
        end

        function M.lint()
          -- Use nvim-lint's logic first:
          -- * checks if linters exist for the full filetype first
          -- * otherwise will split filetype by "." and add all those linters
          -- * this differs from conform.nvim which only uses the first filetype that has a formatter
          local names = lint._resolve_linter_by_ft(vim.bo.filetype)

          -- Create a copy of the names table to avoid modifying the original.
          names = vim.list_extend({}, names)

          -- Add fallback linters.
          if #names == 0 then
            vim.list_extend(names, lint.linters_by_ft["_"] or {})
          end

          -- Add global linters.
          vim.list_extend(names, lint.linters_by_ft["*"] or {})

          -- Filter out linters that don't exist or don't match the condition.
          local ctx = { filename = vim.api.nvim_buf_get_name(0) }
          ctx.dirname = vim.fn.fnamemodify(ctx.filename, ":h")
          names = vim.tbl_filter(function(name)
            local linter = lint.linters[name]
            return linter
              and not (type(linter) == "table" and linter.condition and not linter.condition(ctx))
          end, names)

          -- Run linters.
          if #names > 0 then
            lint.try_lint(names)
          end
        end

        vim.api.nvim_create_autocmd(opts.events, {
          group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
          callback = M.debounce(100, M.lint),
        })
      end,
    },
    {
      "neovim/nvim-lspconfig",
      dependencies = {
        "mason.nvim",
        { "mason-org/mason-lspconfig.nvim", config = function() end },
      },
    },

    { "tpope/vim-surround" },
    { "burntsushi/ripgrep" },
    { "tpope/vim-obsession" },
    -- lazy.nvim
    {
      "folke/noice.nvim",
      event = "VeryLazy",
      opts = {
        -- add any options here
      },
      dependencies = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        "MunifTanjim/nui.nvim",
        -- OPTIONAL:
        --   `nvim-notify` is only needed, if you want to use the notification view.
        --   If not available, we use `mini` as the fallback
        "rcarriga/nvim-notify",
      },
    },
    { "navarasu/onedark.nvim" },

    { "https://github.com/adelarsq/vim-devicons-emoji" },
    -- { "jxnblk/vim-mdx-js" },
    -- { "maxmellon/vim-jsx-pretty" },
    {
      "windwp/nvim-autopairs",
      -- event = "InsertEnter",
      config = true,
      -- use opts = {} for passing setup options
      -- this is equivalent to setup({}) function
    },
    -- { "cakebaker/scss-syntax.vim" },
    -- { "chr4/nginx.vim" },
    -- { "mechatroner/rainbow_csv" },
    -- Comments
    -- { 'tpope/vim-commentary' },
    { "JoosepAlviste/nvim-ts-context-commentstring" },
    {
      "numToStr/Comment.nvim",

      dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "JoosepAlviste/nvim-ts-context-commentstring",
      },
      -- pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    },

    -- { "lukas-reineke/indent-blankline.nvim" },
    {
      "folke/snacks.nvim",
      priority = 1000,
      lazy = false,
      ---@type snacks.Config
      opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        bigfile = { enabled = false },
        dashboard = { enabled = false },
        explorer = { enabled = false },
        indent = { enabled = true },
        input = { enabled = false },
        picker = { enabled = false },
        notifier = { enabled = false },
        quickfile = { enabled = false },
        scope = { enabled = false },
        scroll = { enabled = false },
        statuscolumn = { enabled = false },
        words = { enabled = false },
      },
    },
    {
      "mason-org/mason-lspconfig.nvim",
      opts = {},
      dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
      },
      opts = {
        ensure_installed = {
          "lua_ls",
          "kulala_ls",
          "biome",
          "shellcheck",
          "js-debug-adapter",
          --"rust_analyzer",
          -- "codelldb"
          -- "bacon",
        },
      },
    },
    { "lewis6991/gitsigns.nvim" },
    {
      "mistweaverco/kulala.nvim",
      keys = {
        { "<leader>Rs", desc = "Send request" },
        { "<leader>Ra", desc = "Send all requests" },
        { "<leader>Rb", desc = "Open scratchpad" },
      },
      ft = { "http", "rest" },
      opts = {
        global_keymaps = true,
        global_keymaps_prefix = "<leader>R",
        kulala_keymaps_prefix = "",
      },
    },
    {
      "mason-org/mason.nvim",
      opts = {
        ensure_installed = {
          "biome",
          "shellcheck",
          "gitui",
          "stylelus",
          "shfmt",
          "js-debug-adapter",
          "tflint",
          "rubocop",
          "ruff",
          "sqruff",
          "stylelint",
          "tflint",
          "typos-cli",
          "kulala_ls",
          -- "bacon",
        },
      },
    },
    {
      "mfussenegger/nvim-dap",
      recommended = true,
      desc = "Debugging support. Requires language specific adapters to be configured. (see lang extras)",

      dependencies = {
        "rcarriga/nvim-dap-ui",
        -- virtual text for the debugger
        {
          "theHamsta/nvim-dap-virtual-text",
          opts = {},
        },
      },

      configuration = {
        javascript = {
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
          },
        },
      },
      -- stylua: ignore
      keys = {
	{ "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
	{ "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
	{ "<leader>dc", function() require("dap").continue() end, desc = "Run/Continue" },
	{ "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
	{ "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
	{ "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
	{ "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
	{ "<leader>dj", function() require("dap").down() end, desc = "Down" },
	{ "<leader>dk", function() require("dap").up() end, desc = "Up" },
	{ "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
	{ "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
	{ "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
	{ "<leader>dP", function() require("dap").pause() end, desc = "Pause" },
	{ "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
	{ "<leader>ds", function() require("dap").session() end, desc = "Session" },
	{ "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
	{ "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
      },

      config = function()
        -- load mason-nvim-dap here, after all adapters have been setup
        require("mason-nvim-dap").setup({
          -- Makes a best effort to setup the various debuggers with
          -- reasonable debug configurations
          automatic_installation = true,

          -- You can provide additional configuration to the handlers,
          -- see mason-nvim-dap README for more information
          handlers = {},

          -- You'll need to check that you have the required things installed
          -- online, please don't ask me how to install them :)
          ensure_installed = {
            "js-debug-adapter",
            -- Update this to ensure that you have the debuggers for the langs you want
          },
        })

        vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

        -- for name, sign in pairs(LazyVim.config.icons.dap) do
        --   sign = type(sign) == "table" and sign or { sign }
        --   vim.fn.sign_define("Dap" .. name, {
        --     text = sign[1],
        --     texthl = sign[2] or "DiagnosticInfo",
        --     linehl = sign[3],
        --     numhl = sign[3],
        --   })
        -- end
        --
        -- -- setup dap config by VsCode launch.json file
        -- local vscode = require("dap.ext.vscode")
        -- local json = require("plenary.json")
        -- vscode.json_decode = function(str)
        --   return vim.json.decode(json.json_strip_comments(str))
        -- end
      end,
    },
    {
      "rcarriga/nvim-dap-ui",
      -- virtual text for the debugger
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
      },
    },
    {
      "jay-babu/mason-nvim-dap.nvim",
      dependencies = "mason.nvim",
      cmd = { "DapInstall", "DapUninstall" },
      opts = {
        -- Makes a best effort to setup the various debuggers with
        -- reasonable debug configurations
        automatic_installation = true,

        -- You can provide additional configuration to the handlers,
        -- see mason-nvim-dap README for more information
        handlers = {},

        -- You'll need to check that you have the required things installed
        -- online, please don't ask me how to install them :)
        ensure_installed = {
          "js-debug-adapter",
          "vscode-js-debug",
          -- Update this to ensure that you have the debuggers for the langs you want
        },
      },
      -- mason-nvim-dap is loaded when nvim-dap loads
      config = function() end,
    },
    {
      "rcarriga/nvim-dap-ui",
      dependencies = { "nvim-neotest/nvim-nio" },
  -- stylua: ignore
  keys = {
    { "<leader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
    { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
  },
      opts = {},
      config = function(_, opts)
        local dap = require("dap")
        local dapui = require("dapui")
        dapui.setup(opts)
        dap.listeners.after.event_initialized["dapui_config"] = function()
          dapui.open({})
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
          dapui.close({})
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
          dapui.close({})
        end
      end,
    },
    { "nvim-neotest/nvim-nio" },
    -- {
    -- 	"mrcjkb/rustaceanvim",
    -- 	version = "^6", -- Recommended
    -- 	lazy = false, -- This plugin is already lazy
    -- },
    {
      "ibhagwan/fzf-lua",
      -- optional for icon support
      dependencies = { "nvim-tree/nvim-web-devicons" },
      -- or if using mini.icons/mini.nvim
      -- dependencies = { "echasnovski/mini.icons" },
      opts = {},
    },

    {
      "folke/trouble.nvim",

      opts = {}, -- for default options, refer to the configuration section for custom setup.
      cmd = "Trouble",
      keys = {
        {
          "<leader>xx",
          "<cmd>Trouble diagnostics toggle<cr>",
          desc = "Diagnostics (Trouble)",
        },
        {
          "<leader>xX",
          "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
          desc = "Buffer Diagnostics (Trouble)",
        },
        {
          "<leader>cs",
          "<cmd>Trouble symbols toggle focus=false<cr>",
          desc = "Symbols (Trouble)",
        },
        {
          "<leader>cl",
          "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
          desc = "LSP Definitions / references / ... (Trouble)",
        },
        {
          "<leader>xL",
          "<cmd>Trouble loclist toggle<cr>",
          desc = "Location List (Trouble)",
        },
        {
          "<leader>xQ",
          "<cmd>Trouble qflist toggle<cr>",
          desc = "Quickfix List (Trouble)",
        },
      },
    },
    { "nvim-tree/nvim-web-devicons" },
    { "b0o/schemastore.nvim" },

    { "leafOfTree/vim-svelte-plugin" },
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      config = function()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
          ensure_installed = {
            "json",
            "rust",
            "typescript",
            "javascript",
            "python",
            "c",
            "lua",
            "vim",
            "vimdoc",
            "query",
            "markdown",
            "markdown_inline",
            "svelte",
            "json5",
            "terraform",
            "hcl",
            "bash",
            "c",
            "diff",
            "html",
            "javascript",
            "jsdoc",
            "json",
            "jsonc",
            "lua",
            "luadoc",
            "luap",
            "markdown",
            "markdown_inline",
            "printf",
            "python",
            "query",
            "regex",
            "toml",
            "tsx",
            "typescript",
            "vim",
            "vimdoc",
            "xml",
            "yaml",
            "rust",
            "ron",
          },
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = true },
        })
      end,
      opts = function(_, opts)
        local function add(lang)
          if type(opts.ensure_installed) == "table" then
            table.insert(opts.ensure_installed, lang)
          end
        end

        vim.filetype.add({
          extension = { rasi = "rasi", rofi = "rasi", wofi = "rasi" },
          filename = {
            ["vifmrc"] = "vim",
          },
          pattern = {
            [".*/waybar/config"] = "jsonc",
            [".*/mako/config"] = "dosini",
            [".*/kitty/.+%.conf"] = "kitty",
            [".*/hypr/.+%.conf"] = "hyprlang",
            ["%.env%.[%w_.-]+"] = "sh",
          },
        })
        vim.treesitter.language.register("bash", "kitty")

        add("git_config")
      end,
    },
    {
      "nvimtools/none-ls.nvim",
      dependencies = { "mason.nvim", "nvim-lua/plenary.nvim", "nvimtools/none-ls-extras.nvim" },
      config = function()
        require("null-ls").setup()
      end,
    },
    {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v3.x",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
      },
    },
    {
      "folke/todo-comments.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      opts = {
        signs = true, -- show icons in the signs column
        sign_priority = 8, -- sign priority
        -- keywords recognized as todo comments
        keywords = {
          FIX = {
            icon = " ", -- icon used for the sign, and in search results
            color = "error", -- can be a hex color, or a named color (see below)
            alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
            -- signs = false, -- configure signs for some keywords individually
          },
          TODO = { icon = " ", color = "info", alt = { "@TODO" } },
          HACK = { icon = " ", color = "warning" },
          WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
          PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
          NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
          TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
        },
        gui_style = {
          fg = "NONE", -- The gui style to use for the fg highlight group.
          bg = "BOLD", -- The gui style to use for the bg highlight group.
        },
        merge_keywords = true, -- when true, custom keywords will be merged with the defaults
        -- highlighting of the line containing the todo comment
        -- * before: highlights before the keyword (typically comment characters)
        -- * keyword: highlights of the keyword
        -- * after: highlights after the keyword (todo text)
        highlight = {
          multiline = true, -- enable multine todo comments
          multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
          multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
          before = "", -- "fg" or "bg" or empty
          keyword = "wide", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
          after = "fg", -- "fg" or "bg" or empty
          pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
          comments_only = true, -- uses treesitter to match keywords in comments only
          max_line_len = 400, -- ignore lines longer than this
          exclude = {}, -- list of file types to exclude highlighting
        },
        -- list of named colors where we try to extract the guifg from the
        -- list of highlight groups or use the hex color if hl not found as a fallback
        colors = {
          error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
          warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
          info = { "DiagnosticInfo", "#2563EB" },
          hint = { "DiagnosticHint", "#10B981" },
          default = { "Identifier", "#7C3AED" },
          test = { "Identifier", "#FF00FF" },
        },
        search = {
          command = "rg",
          args = {
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
          },
          -- regex that will be used to match keywords.
          -- don't replace the (KEYWORDS) placeholder
          pattern = [[\b(KEYWORDS):]], -- ripgrep regex
          -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
        },
      },
    },
    {
      "nvim-telescope/telescope.nvim",
      tag = "0.1.8",
      -- or                              , branch = '0.1.x',
      dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
      "nvim-telescope/telescope-file-browser.nvim",
      dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    },
    {
      "folke/which-key.nvim",
      event = "VeryLazy",
      opts = {},
      keys = {
        {
          "<leader>?",
          function()
            require("which-key").show({ global = false })
          end,
          desc = "Buffer Local Keymaps (which-key)",
        },
      },
    },
    {
      "saecki/crates.nvim",
      event = { "BufRead Cargo.toml" },
      tag = "stable",
      config = function()
        require("crates").setup()
      end,
      opts = {
        completion = {
          crates = {
            enabled = true,
          },
        },
        lsp = {
          enabled = true,
          actions = true,
          completion = true,
          hover = true,
        },
      },
    },
    -- colorscheme that will be used when installing plugins.
    --install = { colorscheme = { "habamax" } },
    -- automatically check for plugin updates
  },
  checker = { enabled = true },
  -- { "junegunn/gv.vim" },
  -- { "airblade/vim-gitgutter" },
  -- { "tpope/vim-dadbod" },
  -- { "kristijanhusak/vim-dadbod-ui" },
  -- { "stevearc/dressing.nvim" },@NOTE: deprecated for snacks.vim
  -- { "nvim-lua/plenary.nvim" }, @NOTE: imported as dependey elsewhere
  -- { "MunifTanjim/nui.nvim" }, @NOTE: imported as dependey elsewhere
})

require("todo-comments").setup({})

require("neo-tree").setup({
  filesystem = {
    filtered_items = {
      hide_dotfiles = false,
    },
  },
  window = {
    mappings = {
      ["o"] = "system_open",
    },
  },
  commands = {
    system_open = function(state)
      local node = state.tree:get_node()
      local path = node:get_id()
      vim.fn.jobstart({ "open", path }, { detach = true })
      -- @TODO: validate next line:
      vim.cmd("silent !start explorer " .. p)
    end,
  },
})

local telescope = require("telescope")
local telescopeConfig = require("telescope.config")

-- Clone the default Telescope configuration
local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

-- I want to search in hidden/dot files.
table.insert(vimgrep_arguments, "--hidden")
-- I don't want to search in the `.git` directory.
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!**/.git/*")

telescope.setup({
  defaults = {
    -- `hidden = true` is not supported in text grep commands.
    vimgrep_arguments = vimgrep_arguments,
  },
  pickers = {
    find_files = {
      -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
      find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
    },
  },
  extensions = {
    file_browser = {
      mappings = {},
    },
  },
})
require("telescope").load_extension("file_browser")

require("Comment").setup({
  pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
})
vim.lsp.enable("terraformls")
vim.lsp.enable("ts_ls")
require("lualine").setup()
-- vim.opt.termguicolors = true
-- require("bufferline").setup({})
require("neogen").setup()
require("noice").setup({
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = true, -- use a classic bottom cmdline for search
    command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false, -- add a border to hover docs and signature help
  },
})
require("gitsigns").setup({
  signs = {
    add = { text = "┃" },
    change = { text = "┃" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
    untracked = { text = "┆" },
  },
  signs_staged = {
    add = { text = "┃" },
    change = { text = "┃" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
    untracked = { text = "┆" },
  },
  signs_staged_enable = true,
  signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
  numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    follow_files = true,
  },
  auto_attach = true,
  attach_to_untracked = false,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
    virt_text_priority = 100,
    use_focus = true,
  },
  current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000, -- Disable if file is longer than this (in lines)
  preview_config = {
    -- Options passed to nvim_open_win
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },
})

require("dap").adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = "node",
    -- 💀 Make sure to update this path to point to your installation
    args = { os.getenv("HOME") .. "/.js-debug/src/dapDebugServer.js", "${port}" },
  },
}

require("dap").configurations.typescript = {
  {
    type = "pwa-node",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    cwd = "${workspaceFolder}",
  },
  {
    type = "pwa-node",
    request = "attach",
    name = "Attach to Node app",
    address = "localhost",
    port = 9229,
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
  },
}
require("dap").configurations.javascript = {
  {
    type = "pwa-node",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    cwd = "${workspaceFolder}",
  },
  {
    type = "pwa-node",
    request = "attach",
    name = "Attach to Node app",
    address = "localhost",
    port = 9229,
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
  },
}

vim.lsp.enable("lua-language-server")
vim.lsp.enable("rust_analyzer")
-- vim.lsp.enable("ruby-lsp")
vim.lsp.enable("rubocop")
vim.lsp.enable("kulala_ls")
vim.lsp.enable("biome")
vim.lsp.enable("postgres_lsp")
vim.lsp.config("lua_ls", {})
-- vim.lsp.config("bacon_ls", {
-- 	settings = {
-- 		-- enabled = diagnostics == "bacon-ls",
-- 		-- diagnostics = {
-- 		-- 	enable = true,
-- 		-- },
-- 		-- enabled = true,
-- 		init_options = {
-- 			-- Bacon export filename (default: .bacon-locations).
-- 			locationsFile = ".bacon-locations",
-- 			-- Try to update diagnostics every time the file is saved (default: true).
-- 			updateOnSave = true,
-- 			--  How many milliseconds to wait before updating diagnostics after a save (default: 1000).
-- 			updateOnSaveWaitMillis = 1000,
-- 			-- Try to update diagnostics every time the file changes (default: true).
-- 			updateOnChange = true,
-- 			-- Try to validate that bacon preferences are setup correctly to work with bacon-ls (default: true).
-- 			validateBaconPreferences = true,
-- 			-- f no bacon preferences file is found, create a new preferences file with the bacon-ls job definition (default: true).
-- 			createBaconPreferencesFile = true,
-- 			-- Run bacon in background for the bacon-ls job (default: true)
-- 			runBaconInBackground = true,
-- 			-- Command line arguments to pass to bacon running in background (default "--headless -j bacon-ls")
-- 			runBaconInBackgroundCommandArguments = "--headless -j bacon-ls",
-- 			-- How many milliseconds to wait between background diagnostics check to synchronize all open files (default: 2000).
-- 			synchronizeAllOpenFilesWaitMillis = 2000,
-- 		},
-- 	},
-- })
-- vim.lsp.enable("bacon_ls")
local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.completion.spell,
    null_ls.builtins.formatting.biome,
    require("none-ls.diagnostics.eslint_d"),
  },
})
