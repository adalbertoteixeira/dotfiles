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
    -- import your plugins
    --{ import = "plugins" },
    {
	    'tpope/vim-fugitive'

    },
{ 'vim-airline/vim-airline',

                config = function()

        local g = vim.g

        g.airline_theme='simple'
	-- g.airline.extensions.hunks.enabled=0
       -- g:airline#extensions#hunks#enabled = 0
        -- g.airline#extensions#obsession#enabled = 1
        -- g.airline#extensions#obsession#indicator_text = '$Obsession$'
                        end
                },
{ 'vim-airline/vim-airline-themes' },
{ 'junegunn/gv.vim' },
{
  'dense-analysis/ale',
    config = function()
       -- Configuration goes here.
	local g = vim.g

	g.ale_use_neovim_diagnostics_api = 1
	g.ale_disable_lsp = 1
	g.ale_completion_enabled = 0
	g.ale_set_balloons = 1
	g.ale_fix_on_save = 1
	g.ale_lint_on_text_changed = 1
	g.ale_lint_on_insert_leave = 1
	g.ale_set_loclist = 0
	g.ale_set_quickfix = 0
	g.ale_set_highlights = 1
	g.ale_set_signs = 1
	g.ale_open_list = 1
	g.ale_keep_list_window_open = 0
	g.ale_sign_column_always = 1
	g.ale_linters_explicit = 1
	g.ale_lint_delay = 500

    end
},
{ 'tpope/vim-surround' },
{ 'airblade/vim-gitgutter' },
{ 'burntsushi/ripgrep', },
{ 'tpope/vim-obsession' },
{ 'tpope/vim-dadbod' },
{ 'kristijanhusak/vim-dadbod-ui' },

{ 'navarasu/onedark.nvim' },

{ 'https://github.com/adelarsq/vim-devicons-emoji' },
{ 'jxnblk/vim-mdx-js' },
{ 'maxmellon/vim-jsx-pretty' },
{ 'windwp/nvim-autopairs',
      -- event = "InsertEnter",
    config = true
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
},
{ 'cakebaker/scss-syntax.vim' },
{ 'chr4/nginx.vim' },
{ 'mechatroner/rainbow_csv' },
{ 'tpope/vim-commentary' },
-- { 'numToStr/Comment.nvim' },
{ 'jparise/vim-graphql' },
{ 'editorconfig/editorconfig-vim' },
{ 'lukas-reineke/indent-blankline.nvim' },
{ 'hashivim/vim-terraform' },
{ 'folke/trouble.nvim' },
{ 'nvim-tree/nvim-web-devicons' },
{ 'stevearc/dressing.nvim' },
{ 'nvim-lua/plenary.nvim' },
{ 'MunifTanjim/nui.nvim' },

-- tabnine
-- { 'codota/tabnine-nvim', build = "./dl_binaries.sh" },
    -- Build in ~/.local/share/nvim/lazy/tabnine-nvim/chat: cargo build --release
 {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false, -- Never set this value to "*"! Never!
  opts = {
    -- add any opts here
    -- for example
    provider = "gemini",
    openai = {
      endpoint = "https://api.openai.com/v1",
      model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
      timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
      temperature = 0,
      max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
      --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
    },
  claude = {
    endpoint = "https://api.anthropic.com",
    model = "claude-3-7-sonnet-20250219",
    temperature = 0,
    max_tokens = 4096,
  },
  vendors = {
  mistral= {
    __inherited_from = "openai",
    api_key_name = "MISTRAL_API_KEY",
    endpoint = "https://api.mistral.ai/v1/",
    model = "mistral-large-latest",
    max_tokens = 4096, -- to avoid using max_completion_tokens
  },
},},
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "echasnovski/mini.pick", -- for file_selector provider mini.pick
    "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
    "ibhagwan/fzf-lua", -- for file_selector provider fzf
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "zbirenbaum/copilot.lua", -- for providers='copilot'
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
},
{'neoclide/coc.nvim', branch = 'release'},
{"nvim-treesitter/nvim-treesitter", build = ":TSUpdate",
  config = function ()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      ensure_installed = {
	"json", "rust", "typescript", "javascript", "python",
	"c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline"
      },
	sync_install = false,
	highlight = { enable = true },
	indent = { enable = true },
    })
  end
},
{ 'leafOfTree/vim-svelte-plugin' },
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
  }
},
{
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
-- or                              , branch = '0.1.x',
      dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
}, {'mustache/vim-mustache-handlebars'}

  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  --install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
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

local hooks = require "ibl.hooks"
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

require("ibl").setup { indent = { highlight = highlight } }

require('todo-comments').setup({ {

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
    test = { "Identifier", "#FF00FF" }
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

} })

require("neo-tree").setup({
  filesystem = {
    filtered_items = {
      hide_dotfiles = false
    }
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
      vim.fn.jobstart({ "open", path}, {detach = true})
      -- @TODO: validate next line:
      vim.cmd("silent !start explorer " .. p)
    end
  }
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
      mappings = {

      }
    }
  }
})
require("telescope").load_extension "file_browser"

require('render-markdown').setup({
  latex = {
      enabled = false,
  },
  completions = { lsp = { enabled = true} }
})

-- require('tabnine').setup({
--   disable_auto_comment=true,
--   accept_keymap="<C-A>",
--   dismiss_keymap = "<C-S>",
--   debounce_ms = 800,
--   suggestion_color = {gui = "#808080", cterm = 244},
--   exclude_filetypes = {"TelescopePrompt", "NvimTree"},
--   log_file_path = nil, -- absolute path to Tabnine log file
--   ignore_certificate_errors = false,
--   workspace_folders = {
--     paths = { "/Volumes/T5/ben/team" },
--     get_paths = function()
--       return { "/Volumes/T5/ben/team" }
--     end,
--   },
-- })
