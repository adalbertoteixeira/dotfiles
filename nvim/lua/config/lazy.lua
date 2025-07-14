-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
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

-- Setup lazy.nvim
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

		-- { "junegunn/gv.vim" },
		{
			"danymat/neogen",
			config = true,
			-- Uncomment next line if you want to follow only stable versions
			-- version = "*"
		},
		{
			"saghen/blink.cmp",
			-- optional: provides snippets for the snippet source
			-- dependencies = { "rafamadriz/friendly-snippets" },

			-- use a release tag to download pre-built binaries
			version = "1.*",
			-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
			-- build = 'cargo build --release',
			-- If you use nix, you can build from source using latest nightly rust with:
			-- build = 'nix run .#build-plugin',

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
				keymap = { preset = "default" },

				appearance = {
					-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
					-- Adjusts spacing to ensure icons are aligned
					nerd_font_variant = "mono",
				},

				-- (Default) Only show the documentation popup when manually triggered
				completion = { documentation = { auto_show = false } },

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
		-- Linting / formatting
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
			-- 	-- This will provide type hinting with LuaLS
			-- 	---@module "conform"
			-- 	---@type conform.setupOpts
			opts = {
				-- Define your formatters
				formatters_by_ft = {
					lua = { "stylua" },
					python = { "isort", "black" },
					javascript = { "biome", stop_after_first = true },
					typescript = { "biome" },
					svelte = { "biome", "prettier", stop_after_first = true },
					hcl = { "packer_fmt" },
					terraform = { "terraform_fmt" },
					tf = { "terraform_fmt" },
					-- rust = { "rust_analyser", lsp_format = "fallback" },
					["terraform-vars"] = { "terraform_fmt" },
				},
				-- Set default options
				default_format_opts = {
					lsp_format = "fallback",
				},
				-- Set up format-on-save
				format_on_save = { timeout_ms = 500 },
				-- Customize formatters
				formatters = {
					shfmt = {
						prepend_args = { "-i", "2" },
					},
				},
			},
			-- 	init = function()
			-- 		-- If you want the formatexpr, here is the place to set it
			-- 		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
			-- 	end,
		},
		-- { "akinsho/bufferline.nvim", version = "*", dependencies = "nvim-tree/nvim-web-devicons" },
		{
			"mfussenegger/nvim-lint",
			opts = {
				-- Event to trigger linters
				events = { "BufWritePost", "BufReadPost", "InsertLeave" },
				linters_by_ft = {
					typescript = { "biome" },
					svelte = { "svelte_language_server" },
					-- Use the "*" filetype to run linters on all filetypes.
					-- ['*'] = { 'global linter' },
					-- Use the "_" filetype to run linters on filetypes that don't have other linters configured.
					-- ['_'] = { 'fallback linter' },
					-- ["*"] = { "typos" },
					terraform = { "terraform_validate" },
					tf = { "terraform_validate" },
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

		-- { 'neoclide/coc.nvim',           branch = 'release' },
		-- {
		-- 	"dense-analysis/ale",
		-- 	config = function()
		-- 		-- Configuration goes here.
		-- 		local g = vim.g
		--
		-- 		g.ale_use_neovim_diagnostics_api = 1
		-- 		-- g.ale_disable_lsp = 1
		-- 		g.ale_completion_enabled = 0
		-- 		g.ale_set_balloons = 1
		-- 		g.ale_fix_on_save = 1
		-- 		g.ale_lint_on_text_changed = 1
		-- 		g.ale_lint_on_insert_leave = 1
		-- 		g.ale_set_loclist = 0
		-- 		g.ale_set_quickfix = 0
		-- 		g.ale_set_highlights = 1
		-- 		g.ale_set_signs = 1
		-- 		g.ale_open_list = 1
		-- 		g.ale_keep_list_window_open = 0
		-- 		g.ale_sign_column_always = 1
		-- 		g.ale_linters_explicit = 1
		-- 		g.ale_lint_delay = 500
		-- 	end,
		-- },
		{ "tpope/vim-surround" },
		-- { "airblade/vim-gitgutter" },
		{ "burntsushi/ripgrep" },
		{ "tpope/vim-obsession" },
		-- { "tpope/vim-dadbod" },
		-- { "kristijanhusak/vim-dadbod-ui" },
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

		{ "lukas-reineke/indent-blankline.nvim" },
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
					--"rust_analyzer",
					-- "codelldb"
					-- "bacon",
				},
			},
		},
		{ "lewis6991/gitsigns.nvim" },
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
					-- "bacon",
				},
			},
		},
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
		{ "stevearc/dressing.nvim" },
		{ "nvim-lua/plenary.nvim" },
		{ "MunifTanjim/nui.nvim" },
		{ "b0o/schemastore.nvim" },

		-- tabnine
		-- { 'codota/tabnine-nvim', build = "./dl_binaries.sh" },
		-- Build in ~/.local/share/nvim/lazy/tabnine-nvim/chat: cargo build --release
		-- {
		-- 	"yetone/avante.nvim",
		-- 	event = "VeryLazy",
		-- 	version = false, -- Never set this value to "*"! Never!
		-- 	opts = {
		-- 		providers = {
		-- 			openai = {
		-- 				endpoint = "https://api.openai.com/v1",
		-- 				model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
		-- 				timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
		-- 				extra_request_body = {
		-- 					temperature = 0,
		-- 					max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
		-- 					--reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
		-- 				},
		-- 			},
		-- 			gemini = {
		-- 				__inherited_from = "gemini",
		-- 				model = "gemini-2.5-pro-preview-03-25",
		-- 			},
		-- 			claude = {
		-- 				endpoint = "https://api.anthropic.com",
		-- 				model = "claude-sonnet-4-20250514",
		-- 				extra_request_body = {
		-- 					temperature = 0,
		-- 					max_tokens = 4096,
		-- 				},
		-- 			},
		-- 			mistral = {
		-- 				__inherited_from = "openai",
		-- 				api_key_name = "MISTRAL_API_KEY",
		-- 				endpoint = "https://api.mistral.ai/v1/",
		-- 				model = "mistral-large-latest",
		-- 				extra_request_body = {
		-- 					max_tokens = 4096, -- to avoid using max_completion_tokens
		-- 				},
		-- 			},
		-- 		},
		-- 	},
		-- 	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
		-- 	build = "make",
		-- 	-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
		-- 	dependencies = {
		-- 		"nvim-treesitter/nvim-treesitter",
		-- 		"stevearc/dressing.nvim",
		-- 		"nvim-lua/plenary.nvim",
		-- 		"MunifTanjim/nui.nvim",
		-- 		--- The below dependencies are optional,
		-- 		"echasnovski/mini.pick", -- for file_selector provider mini.pick
		-- 		"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
		-- 		"ibhagwan/fzf-lua", -- for file_selector provider fzf
		-- 		"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
		-- 		"zbirenbaum/copilot.lua", -- for providers='copilot'
		-- 		{
		-- 			-- support for image pasting
		-- 			"HakonHarnes/img-clip.nvim",
		-- 			event = "VeryLazy",
		-- 			opts = {
		-- 				-- recommended settings
		-- 				default = {
		-- 					embed_image_as_base64 = false,
		-- 					prompt_for_file_name = false,
		-- 					drag_and_drop = {
		-- 						insert_mode = true,
		-- 					},
		-- 					-- required for Windows users
		-- 					use_absolute_path = true,
		-- 				},
		-- 			},
		-- 		},
		-- 		{
		-- 			-- Make sure to set this up properly if you have lazy=true
		-- 			"MeanderingProgrammer/render-markdown.nvim",
		-- 			opts = {
		-- 				file_types = { "markdown", "Avante" },
		-- 			},
		-- 			ft = { "markdown", "Avante" },
		-- 		},
		-- 	},
		-- },
		-- { "lua-language-server" },
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
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
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
		-- { "mustache/vim-mustache-handlebars" },
		{
			"folke/which-key.nvim",
			event = "VeryLazy",
			opts = {
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			},
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
		-- 	    {
		-- 		"folke/flash.nvim", event = "VeryLazy",
		--   -- -@type Flash.Config
		--   opts = {},
		--   -- stylua: ignore
		--   keys = {
		--     { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
		--     { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
		--     { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
		--     { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
		--     { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
		--   },
		-- }

		-- Configure any other settings here. See the documentation for more details.
		-- colorscheme that will be used when installing plugins.
		--install = { colorscheme = { "habamax" } },
		-- automatically check for plugin updates
	},
	checker = { enabled = true },
})

local highlight = {
	"RainbowRed",
	"RainbowYellow",
	"RainbowBlue",
	"RainbowOrange",
	"RainbowGreen",
	"RainbowViolet",
	"RainbowCyan",
}

local hooks = require("ibl.hooks")
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
	vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
	vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
	vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
	vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
	vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
	vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
	vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)

require("ibl").setup({ indent = { highlight = highlight } })

require("todo-comments").setup({
	{
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
})

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

-- require("render-markdown").setup({
-- 	-- render_modes = true,
-- 	code = { border = "thin" },
-- 	-- pipe_table = { style = 'normal' },
-- 	latex = {
-- 		enabled = false,
-- 	},
-- 	completions = { lsp = { enabled = true } },
-- })

require("Comment").setup({
	pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
})
-- vim.lsp.enable("biome")
vim.lsp.enable("terraformls")
-- vim.lsp.enable("tsserver")
vim.lsp.enable("ts_ls")
-- vim.lsp.enable("tsserver")
require("lualine").setup()
vim.opt.termguicolors = true
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

-- vim.lsp.config("rust_analyzer", {
-- 	-- settings = {
-- 	["rust-analyzer"] = {
-- 		-- enabled = false,
-- 		diagnostics = {
-- 			enable = false,
-- 		},
-- 		checkOnSave = {
-- 			enable = false,
-- 		},
-- 	},
-- 	-- },
-- })
vim.lsp.enable("rust_analyzer")
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
		null_ls.builtins.formatting.prettier,
		require("none-ls.diagnostics.eslint"),
	},
})
