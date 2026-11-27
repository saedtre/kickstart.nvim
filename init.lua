--[[

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================
========                                    .-----.          ========
========         .----------------------.   | === |          ========
========         |.-""""""""""""""""""-.|   |-----|          ========
========         ||                    ||   | === |          ========
========         ||   KICKSTART.NVIM   ||   |-----|          ========
========         ||                    ||   | === |          ========
========         ||                    ||   |-----|          ========
========         ||:Tutor              ||   |:::::|          ========
========         |'-..................-'|   |____o|          ========
========         `"")----------------(""`   ___________      ========
========        /::::::::::|  |::::::::::\  \ no mouse \     ========
========       /:::========|  |==hjkl==:::\  \ required \    ========
========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========
========                                                     ========
=====================================================================
=====================================================================

What is Kickstart?

  Kickstart.nvim is *not* a distribution.

  Kickstart.nvim is a starting point for your own configuration.
    The goal is that you can read every line of code, top-to-bottom, understand
    what your configuration is doing, and modify it to suit your needs.

    Once you've done that, you can start exploring, configuring and tinkering to
    make Neovim your own! That might mean leaving Kickstart just the way it is for a while
    or immediately breaking it into modular pieces. It's up to you!

    If you don't know anything about Lua, I recommend taking some time to read through
    a guide. One possible example which will only take 10-15 minutes:
      - https://learnxinyminutes.com/docs/lua/

    After understanding a bit more about Lua, you can use `:help lua-guide` as a
    reference for how Neovim integrates Lua.
    - :help lua-guide
    - (or HTML version): https://neovim.io/doc/user/lua-guide.html

Kickstart Guide:

  TODO: The very first thing you should do is to run the command `:Tutor` in Neovim.

    If you don't know what this means, type the following:
      - <escape key>
      - :
      - Tutor
      - <enter key>

    (If you already know the Neovim basics, you can skip this step.)

  Once you've completed that, you can continue working through **AND READING** the rest
  of the kickstart init.lua.

  Next, run AND READ `:help`.
    This will open up a help window with some basic information
    about reading, navigating and searching the builtin help documentation.

    This should be the first place you go to look when you're stuck or confused
    with something. It's one of my favorite Neovim features.

    MOST IMPORTANTLY, we provide a keymap "<space>sh" to [s]earch the [h]elp documentation,
    which is very useful when you're not exactly sure of what you're looking for.

  I have left several `:help X` comments throughout the init.lua
    These are hints about where to find more information about the relevant settings,
    plugins or Neovim features used in Kickstart.

   NOTE: Look for lines like this

    Throughout the file. These are for you, the reader, to help you understand what is happening.
    Feel free to delete them once you know what you're doing, but they should serve as a guide
    for when you are first encountering a few different constructs in your Neovim config.

If you experience any errors while trying to install kickstart, run `:checkhealth` for more info.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now! :)
--]]

-- ============================================================
-- SECTION 1: OPTIONS
-- Core Neovim settings, leaders, options
-- ============================================================
do
  -- Enable faster startup by caching compiled Lua modules
  vim.loader.enable()

  -- Set <space> as the leader key
  -- See `:help mapleader`
  --  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
  vim.g.mapleader = ' '
  vim.g.maplocalleader = ' '

  -- Set to true if you have a Nerd Font installed and selected in the terminal
  vim.g.have_nerd_font = false

  -- [[ Setting options ]]
  --  See `:help vim.o`
  -- NOTE: You can change these options as you wish!
  --  For more options, you can see `:help option-list`

  -- Make line numbers default
  vim.o.number = true
  -- You can also add relative line numbers, to help with jumping.
  --  Experiment for yourself to see if you like it!
  -- vim.o.relativenumber = true

  -- Enable mouse mode, can be useful for resizing splits for example!
  vim.o.mouse = 'a'

  -- Don't show the mode, since it's already in the status line
  vim.o.showmode = false

  -- Sync clipboard between OS and Neovim.
  --  Schedule the setting after `UiEnter` because it can increase startup-time.
  --  Remove this option if you want your OS clipboard to remain independent.
  --  See `:help 'clipboard'`
  vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

  -- Enable break indent
  vim.o.breakindent = true

  -- Enable undo/redo changes even after closing and reopening a file
  vim.o.undofile = true

  -- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
  vim.o.ignorecase = true
  vim.o.smartcase = true

  -- Don't keep search matches highlighted after a search (equivalent to `:set nohlsearch`).
  -- 'incsearch' (on by default) still highlights the match while you type the pattern.
  vim.o.hlsearch = false

  -- Keep signcolumn on by default
  vim.o.signcolumn = 'yes'

  -- Decrease update time
  vim.o.updatetime = 250

  -- Decrease mapped sequence wait time
  vim.o.timeoutlen = 300

  -- Configure how new splits should be opened
  vim.o.splitright = true
  vim.o.splitbelow = true

  -- Sets how neovim will display certain whitespace characters in the editor.
  --  See `:help 'list'`
  --  and `:help 'listchars'`
  --
  --  Notice listchars is set using `vim.opt` instead of `vim.o`.
  --  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
  --   See `:help lua-options`
  --   and `:help lua-guide-options`
  vim.o.list = true
  vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

  -- Preview substitutions live, as you type!
  vim.o.inccommand = 'split'

  -- Show which line your cursor is on
  vim.o.cursorline = true

  -- Show a column marker at column 80
  vim.o.colorcolumn = '80'

  -- Minimal number of screen lines to keep above and below the cursor.
  vim.o.scrolloff = 10

  -- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
  -- instead raise a dialog asking if you wish to save the current file(s)
  -- See `:help 'confirm'`
  vim.o.confirm = true
end

-- ============================================================
-- SECTION 2: KEYMAPS & AUTOCMDS
-- basic keymaps, basic autocmds
-- ============================================================
do
  -- [[ Basic Keymaps ]]
  --  See `:help vim.keymap.set()`

  -- Clear highlights on search when pressing <Esc> in normal mode
  --  See `:help hlsearch`
  vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

  -- Diagnostic Config & Keymaps
  --  See `:help vim.diagnostic.Opts`
  vim.diagnostic.config {
    update_in_insert = false,
    severity_sort = true,
    float = { border = 'rounded', source = 'if_many' },
    underline = { severity = { min = vim.diagnostic.severity.WARN } },

    -- Can switch between these as you prefer
    -- Inline diagnostics: show the message at the end of the offending line
    virtual_text = {
      source = 'if_many', -- Prefix with the source name when there are several
      spacing = 2,
      prefix = '●',
    },
    virtual_lines = false, -- Text shows up underneath the line, with virtual lines

    -- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
    jump = {
      on_jump = function(_, bufnr)
        vim.diagnostic.open_float {
          bufnr = bufnr,
          scope = 'cursor',
          focus = false,
        }
      end,
    },
  }

  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

  -- Open Netrw in the directory of the current file (cursor lands on that file)
  vim.keymap.set('n', '<leader>pv', vim.cmd.Ex, { desc = '[P]roject [V]iew (Netrw)' })

  -- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
  -- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
  -- is not what someone will guess without a bit more experience.
  --
  -- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
  -- or just use <C-\><C-n> to exit terminal mode
  vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

  -- TIP: Disable arrow keys in normal mode
  -- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
  -- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
  -- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
  -- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

  -- Keybinds to make split navigation easier.
  --  Use CTRL+<hjkl> to switch between windows
  --
  --  See `:help wincmd` for a list of all window commands
  vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
  vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
  vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
  vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

  -- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
  -- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
  -- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
  -- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
  -- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

  -- [[ Basic Autocommands ]]
  --  See `:help lua-guide-autocommands`

  -- Highlight when yanking (copying) text
  --  Try it with `yap` in normal mode
  --  See `:help vim.hl.on_yank()`
  vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function() vim.hl.on_yank() end,
  })
end

-- ============================================================
-- SECTION 3: PLUGIN MANAGER INTRO
-- vim.pack intro, build hooks
-- ============================================================
do
  -- [[ Intro to `vim.pack` ]]
  -- `vim.pack` is a new plugin manager built into Neovim,
  --  which provides a Lua interface for installing and managing plugins.
  --
  --  See `:help vim.pack`, `:help vim.pack-examples` or the
  --  excellent blog post from the creator of vim.pack and mini.nvim:
  --  https://echasnovski.com/blog/2026-03-13-a-guide-to-vim-pack
  --
  --  To inspect plugin state and pending updates, run
  --    :lua vim.pack.update(nil, { offline = true })
  --
  --  To update plugins, run
  --    :lua vim.pack.update()
  --
  --
  --  Throughout the rest of the config there will be examples
  --  of how to install and configure plugins using `vim.pack`.
  --
  --  In this section we set up some autocommands to run build
  --  steps for certain plugins after they are installed or updated.

  local function run_build(name, cmd, cwd)
    local result = vim.system(cmd, { cwd = cwd }):wait()
    if result.code ~= 0 then
      local stderr = result.stderr or ''
      local stdout = result.stdout or ''
      local output = stderr ~= '' and stderr or stdout
      if output == '' then output = 'No output from build command.' end
      vim.notify(('Build failed for %s:\n%s'):format(name, output), vim.log.levels.ERROR)
    end
  end

  -- This autocommand runs after a plugin is installed or updated and
  --  runs the appropriate build command for that plugin if necessary.
  --
  -- See `:help vim.pack-events`
  vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(ev)
      local name = ev.data.spec.name
      local kind = ev.data.kind
      if kind ~= 'install' and kind ~= 'update' then return end

      if name == 'telescope-fzf-native.nvim' and vim.fn.executable 'make' == 1 then
        run_build(name, { 'make' }, ev.data.path)
        return
      end

      if name == 'nvim-treesitter' then
        if not ev.data.active then vim.cmd.packadd 'nvim-treesitter' end
        vim.cmd 'TSUpdate'
        return
      end
    end,
  })
end

--- Because most plugins are hosted on GitHub, you can use the helper
--- function to have less repetition in the following sections.
---@param repo string
---@return string
local function gh(repo) return 'https://github.com/' .. repo end

-- ============================================================
-- SECTION 4: UI / CORE UX PLUGINS
-- guess-indent, gitsigns, which-key, colorscheme, todo-comments, mini modules
-- ============================================================
do
  -- [[ Installing and Configuring Plugins ]]
  --
  -- To install a plugin simply call `vim.pack.add` with its git url.
  -- This will download the default branch of the plugin, which will usually be `main` or `master`
  -- You can also have more advanced specs, which we will talk about later.
  --
  -- For most plugins its not enough to install them, you also need to call their `.setup()` to start them.
  --
  -- For example, lets say we want to install `guess-indent.nvim` - a plugin for
  -- automatically detecting and setting the indentation.
  --
  -- We first install it from https://github.com/NMAC427/guess-indent.nvim
  -- and then call its `setup()` function to start it with default settings.
  vim.pack.add { gh 'NMAC427/guess-indent.nvim' }
  require('guess-indent').setup {}

  -- Here is a more advanced configuration example that passes options to `gitsigns.nvim`
  --
  -- See `:help gitsigns` to understand what each configuration key does.
  -- Adds git related signs to the gutter, as well as utilities for managing changes
  vim.pack.add { gh 'lewis6991/gitsigns.nvim' }
  local gitsigns = require 'gitsigns'
  gitsigns.setup {
    signs = {
      add = { text = '+' }, ---@diagnostic disable-line: missing-fields
      change = { text = '~' }, ---@diagnostic disable-line: missing-fields
      delete = { text = '_' }, ---@diagnostic disable-line: missing-fields
      topdelete = { text = '‾' }, ---@diagnostic disable-line: missing-fields
      changedelete = { text = '~' }, ---@diagnostic disable-line: missing-fields
    },
    -- gitsigns.nvim's recommended keymaps:
    on_attach = function(bufnr)
      -- Navigation
      vim.keymap.set('n', ']c', function()
        if vim.wo.diff then
          vim.cmd.normal { ']c', bang = true }
        else
          gitsigns.nav_hunk 'next'
        end
      end, { desc = 'Jump to next git [c]hange', buf = bufnr })

      vim.keymap.set('n', '[c', function()
        if vim.wo.diff then
          vim.cmd.normal { '[c', bang = true }
        else
          gitsigns.nav_hunk 'prev'
        end
      end, { desc = 'Jump to previous git [c]hange', buf = bufnr })

      -- Visual mode actions
      vim.keymap.set('v', '<leader>hs', function() gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end, { desc = 'git [s]tage hunk', buf = bufnr })
      vim.keymap.set('v', '<leader>hr', function() gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end, { desc = 'git [r]eset hunk', buf = bufnr })
      -- Normal mode actions
      vim.keymap.set('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk', buf = bufnr })
      vim.keymap.set('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk', buf = bufnr })
      vim.keymap.set('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer', buf = bufnr })
      vim.keymap.set('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer', buf = bufnr })
      vim.keymap.set('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'git [p]review hunk', buf = bufnr })
      vim.keymap.set('n', '<leader>hi', gitsigns.preview_hunk_inline, { desc = 'git preview hunk [i]nline', buf = bufnr })
      vim.keymap.set('n', '<leader>hb', function() gitsigns.blame_line { full = true } end, { desc = 'git [b]lame line', buf = bufnr })
      vim.keymap.set('n', '<leader>hd', gitsigns.diffthis, { desc = 'git [d]iff against index', buf = bufnr })
      vim.keymap.set('n', '<leader>hD', function() gitsigns.diffthis '~' end, { desc = 'git [D]iff against last commit', buf = bufnr })
      vim.keymap.set('n', '<leader>hQ', function() gitsigns.setqflist 'all' end, { desc = 'git hunk [Q]uickfix list (all files in repo)', buf = bufnr })
      vim.keymap.set('n', '<leader>hq', gitsigns.setqflist, { desc = 'git hunk [q]uickfix list (all changes in this file)', buf = bufnr })
      -- Toggles
      vim.keymap.set('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line', buf = bufnr })
      vim.keymap.set('n', '<leader>tw', gitsigns.toggle_word_diff, { desc = '[T]oggle git intra-line [w]ord diff', buf = bufnr })
      -- Text object
      vim.keymap.set({ 'o', 'x' }, 'ih', gitsigns.select_hunk, { desc = 'text object [i]nside [h]unk', buf = bufnr })
    end,
  }

  -- Useful plugin to show you pending keybinds.
  vim.pack.add { gh 'folke/which-key.nvim' }
  require('which-key').setup {
    -- Delay between pressing a key and opening which-key (milliseconds)
    delay = 0,
    icons = { mappings = vim.g.have_nerd_font },
    -- Document existing key chains
    spec = {
      { '<leader>s', group = '[S]earch', mode = { 'n', 'v' } },
      { '<leader>t', group = '[T]oggle' },
      { '<leader>p', group = '[P]roject' },
      { '<leader>c', group = '[C]/C++ & CMake' },
      { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } }, -- Enable gitsigns recommended keymaps first
      -- Neovim's default description for `gx` is very long, which forces the `g` popup into a single
      -- column that overflows shorter windows and hides entries (such as the `gr` group) below the fold.
      { 'gx', desc = 'Open file/URI under cursor', mode = { 'n', 'x' } },
    },
  }

  -- [[ Colorscheme ]]
  -- You can easily change to a different colorscheme.
  -- Change the name of the colorscheme plugin below, and then
  -- change the command under that to load whatever the name of that colorscheme is.
  --
  -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
  vim.pack.add { gh 'ellisonleao/gruvbox.nvim' }
  ---@diagnostic disable-next-line: missing-fields
  require('gruvbox').setup {
    transparent_mode = true,
    italic = {
      comments = true,
    },
  }

  -- Load the colorscheme here.
  -- Gruvbox follows 'background', so set it to 'light' for the light variant.
  vim.o.background = 'dark'
  vim.cmd.colorscheme 'gruvbox'

  -- Highlight todo, notes, etc in comments
  vim.pack.add { gh 'folke/todo-comments.nvim' }
  require('todo-comments').setup { signs = false }

  -- [[ mini.nvim ]]
  --  A collection of various small independent plugins/modules
  vim.pack.add { gh 'nvim-mini/mini.nvim' }

  -- If a nerd font is available, load the icons module for pretty icons in various plugins.
  if vim.g.have_nerd_font then
    require('mini.icons').setup()
    -- Used for backwards compatibility with plugins that require `nvim-web-devicons` (e.g. telescope.nvim)
    MiniIcons.mock_nvim_web_devicons()
  end

  -- Better Around/Inside textobjects
  --
  -- Examples:
  --  - va)  - [V]isually select [A]round [)]paren
  --  - yiiq - [Y]ank [I]nside [I]+1 [Q]uote
  --  - ci'  - [C]hange [I]nside [']quote
  require('mini.ai').setup {
    -- NOTE: Avoid conflicts with the built-in incremental selection mappings on Neovim>=0.12 (see `:help treesitter-incremental-selection`)
    mappings = {
      around_next = 'aa',
      inside_next = 'ii',
    },
    n_lines = 500,
  }

  -- Add/delete/replace surroundings (brackets, quotes, etc.)
  --
  -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
  -- - sd'   - [S]urround [D]elete [']quotes
  -- - sr)'  - [S]urround [R]eplace [)] [']
  require('mini.surround').setup()

  -- Simple and easy statusline.
  --  You could remove this setup call if you don't like it,
  --  and try some other statusline plugin
  local statusline = require 'mini.statusline'
  -- Set `use_icons` to true if you have a Nerd Font
  statusline.setup { use_icons = vim.g.have_nerd_font }

  -- You can configure sections in the statusline by overriding their
  -- default behavior. For example, here we set the section for
  -- cursor location to LINE:COLUMN
  ---@diagnostic disable-next-line: duplicate-set-field
  statusline.section_location = function() return '%2l:%-2v' end

  -- ... and there is more!
  --  Check out: https://github.com/nvim-mini/mini.nvim
end

-- ============================================================
-- SECTION 5: SEARCH & NAVIGATION
-- Telescope setup and keymaps
-- ============================================================
do
  -- [[ Fuzzy Finder (files, lsp, etc) ]]
  --
  -- Telescope is a fuzzy finder that comes with a lot of different things that
  -- it can fuzzy find! It's more than just a "file finder", it can search
  -- many different aspects of Neovim, your workspace, LSP, and more!
  --
  -- There are lots of other alternative pickers (like snacks.picker, or fzf-lua)
  -- so feel free to experiment and see what you like!
  --
  -- The easiest way to use Telescope, is to start by doing something like:
  --  :Telescope help_tags
  --
  -- After running this command, a window will open up and you're able to
  -- type in the prompt window. You'll see a list of `help_tags` options and
  -- a corresponding preview of the help.
  --
  -- Two important keymaps to use while in Telescope are:
  --  - Insert mode: <c-/>
  --  - Normal mode: ?
  --
  -- This opens a window that shows you all of the keymaps for the current
  -- Telescope picker. This is really useful to discover what Telescope can
  -- do as well as how to actually do it!

  ---@type (string | vim.pack.Spec)[]
  local telescope_plugins = {
    gh 'nvim-lua/plenary.nvim',
    gh 'nvim-telescope/telescope.nvim',
    gh 'nvim-telescope/telescope-ui-select.nvim',
  }
  if vim.fn.executable 'make' == 1 then table.insert(telescope_plugins, gh 'nvim-telescope/telescope-fzf-native.nvim') end

  -- NOTE: You can install multiple plugins at once
  vim.pack.add(telescope_plugins)

  -- See `:help telescope` and `:help telescope.setup()`
  require('telescope').setup {
    -- You can put your default mappings / updates / etc. in here
    --  All the info you're looking for is in `:help telescope.setup()`
    --
    -- defaults = {
    --   mappings = {
    --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
    --   },
    -- },
    -- pickers = {}
    extensions = {
      ['ui-select'] = { require('telescope.themes').get_dropdown() },
    },
  }

  -- Enable Telescope extensions if they are installed
  pcall(require('telescope').load_extension, 'fzf')
  pcall(require('telescope').load_extension, 'ui-select')

  -- See `:help telescope.builtin`
  local builtin = require 'telescope.builtin'
  vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
  vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
  vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
  vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
  vim.keymap.set({ 'n', 'v' }, '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
  vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
  vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
  vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
  vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
  vim.keymap.set('n', '<leader>sc', builtin.commands, { desc = '[S]earch [C]ommands' })
  vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

  -- Fuzzy find functions, types, variables etc. in the current buffer, using treesitter
  -- (the LSP-free stand-in for "document symbols")
  vim.keymap.set('n', '<leader>st', builtin.treesitter, { desc = '[S]earch [T]reesitter symbols' })

  -- Override default behavior and theme when searching
  vim.keymap.set('n', '<leader>/', function()
    -- You can pass additional configuration to Telescope to change the theme, layout, etc.
    builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
      winblend = 10,
      previewer = false,
    })
  end, { desc = '[/] Fuzzily search in current buffer' })

  -- It's also possible to pass additional configuration options.
  --  See `:help telescope.builtin.live_grep()` for information about particular keys
  vim.keymap.set(
    'n',
    '<leader>s/',
    function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end,
    { desc = '[S]earch [/] in Open Files' }
  )

  -- Shortcut for searching your Neovim configuration files
  vim.keymap.set('n', '<leader>sn', function() builtin.find_files { cwd = vim.fn.stdpath 'config', follow = true } end, { desc = '[S]earch [N]eovim files' })
end

-- ============================================================
-- SECTION 6: EXTERNAL TOOLS
-- Mason installs the command-line formatters used below. No language servers.
-- ============================================================
do
  -- NOTE: This config deliberately runs without language servers: no completion
  -- popups, hover, go-to-definition or LSP diagnostics. Editing relies on
  -- treesitter, grep/Telescope and plain Vim motions; formatters keep code tidy.
  --
  -- The full LSP setup (clangd, gopls, rust-analyzer, lua_ls, blink.cmp...) was saved
  -- with `git stash` before it was removed. `git stash list` shows it.

  vim.pack.add {
    gh 'mason-org/mason.nvim',
    gh 'WhoIsSethDaniel/mason-tool-installer.nvim',
  }

  -- PATH = 'append': system binaries (rustup's rustfmt, nix's Go tools) take precedence
  -- over Mason's copies.
  require('mason').setup { PATH = 'append' }

  -- Formatters that Mason installs. rustfmt comes from rustup instead.
  --   :Mason shows what is installed (press `g?` for help)
  require('mason-tool-installer').setup {
    ensure_installed = {
      'stylua', -- Lua
      'goimports', -- Go: adds missing and removes unused imports
      'gofumpt', -- Go: stricter gofmt
      'clang-format', -- C/C++: also sorts #includes
    },
  }
end

-- ============================================================
-- SECTION 7: FORMATTING & IMPORTS
-- conform.nvim: format (and fix imports) on save
-- ============================================================
do
  -- [[ Formatting ]]
  vim.pack.add { gh 'stevearc/conform.nvim' }
  require('conform').setup {
    notify_on_error = true,
    -- Format on save with the formatters below. Filetypes without one are left alone.
    -- <leader>tf toggles it for the session.
    format_on_save = function()
      if vim.g.disable_autoformat then return end
      return { timeout_ms = 1000 }
    end,
    default_format_opts = {
      lsp_format = 'never', -- No language servers in this config
    },
    -- Formatters run in order; import handling happens as part of formatting.
    formatters_by_ft = {
      lua = { 'stylua' },
      -- goimports adds missing imports and removes unused ones, then gofumpt formats
      go = { 'goimports', 'gofumpt' },
      -- rustfmt groups and sorts `use` statements, but can't add or remove them
      rust = { 'rustfmt' },
      -- clang-format sorts #include blocks (configure via .clang-format)
      c = { 'clang-format' },
      cpp = { 'clang-format' },
    },
  }

  vim.keymap.set({ 'n', 'v' }, '<leader>f', function() require('conform').format { async = true } end, { desc = '[F]ormat buffer' })
  vim.keymap.set('n', '<leader>tf', function()
    vim.g.disable_autoformat = not vim.g.disable_autoformat
    vim.notify('Format on save ' .. (vim.g.disable_autoformat and 'disabled' or 'enabled'))
  end, { desc = '[T]oggle [F]ormat on save' })
end

-- ============================================================
-- SECTION 8: TREESITTER
-- Parser installation, syntax highlighting, folds, indentation
-- ============================================================
do
  -- [[ Configure Treesitter ]]
  --  Used to highlight, edit, and navigate code
  --
  --  See `:help nvim-treesitter-intro`

  -- NOTE: You can also specify a branch or a specific commit
  vim.pack.add { { src = gh 'nvim-treesitter/nvim-treesitter', version = 'main' } }

  -- Ensure basic parsers are installed
  local parsers = {
    'bash',
    'c',
    'cpp',
    'cmake',
    'doxygen',
    'diff',
    'go',
    'gomod',
    'gosum',
    'gowork',
    'html',
    'lua',
    'luadoc',
    'markdown',
    'markdown_inline',
    'query',
    'vim',
    'vimdoc',
  }
  require('nvim-treesitter').install(parsers)

  ---@param buf integer
  ---@param language string
  local function treesitter_try_attach(buf, language)
    -- Check if the buffer is valid (might not be after install completes)
    if not vim.api.nvim_buf_is_valid(buf) then return end

    -- Check if a parser exists and load it
    if not vim.treesitter.language.add(language) then return end

    -- Enable syntax highlighting and other treesitter features
    vim.treesitter.start(buf, language)

    -- Enable treesitter based folds
    -- For more info on folds see `:help folds`
    -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    -- vim.wo.foldmethod = 'expr'

    -- Check if treesitter indentation is available for this language, and if so enable it
    -- in case there is no indent query, the indentexpr will fallback to the vim's built in one
    local has_indent_query = vim.treesitter.query.get(language, 'indents') ~= nil

    -- Enable treesitter based indentation
    if has_indent_query then vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" end
  end

  local available_parsers = require('nvim-treesitter').get_available()
  vim.api.nvim_create_autocmd('FileType', {
    callback = function(args)
      local buf, filetype = args.buf, args.match

      local language = vim.treesitter.language.get_lang(filetype)
      if not language then return end

      local installed_parsers = require('nvim-treesitter').get_installed 'parsers'

      if vim.tbl_contains(installed_parsers, language) then
        -- Enable the parser if it is already installed
        treesitter_try_attach(buf, language)
      elseif vim.tbl_contains(available_parsers, language) then
        -- If a parser is available in `nvim-treesitter`, auto-install it and enable it after the installation is done
        require('nvim-treesitter').install(language):await(function() treesitter_try_attach(buf, language) end)
      else
        -- Try to enable treesitter features in case the parser exists but is not available from `nvim-treesitter`
        treesitter_try_attach(buf, language)
      end
    end,
  })
end

-- ============================================================
-- SECTION 9: GO TO DEFINITION (CTAGS)
-- Project tags via universal-ctags, gd / gD with fallbacks
-- ============================================================
do
  -- Universal Ctags indexes every definition in the project into a tags file, which
  -- Neovim's tag commands read natively. Matches are by name, not by type, so a name
  -- defined in several places shows a list to pick from.
  --
  --   gd          Go to definition (falls back to the built-in local `gd`)
  --   gD          Go to declaration: C/C++ prototypes and extern declarations,
  --               otherwise the definition (falls back to the built-in `gD`)
  --   <C-]>       Plain tag jump, <C-t> jumps back (also after gd / gD)
  --   <leader>sT  Fuzzy search every tag in the project
  --   :Ctags      Regenerate the tags for the current project
  --
  -- Two kinds of tags file, both in stdpath('cache')/ctags so repositories stay clean:
  --   * Project: the files in the git repository (respecting .gitignore). Rebuilt on save.
  --   * Go dependencies: every package the module imports, standard library included
  --     (from `go list -deps`), so `gd` works on `fmt.Println` or a `go get` library.
  --     Rebuilt when go.mod or go.sum is saved.
  --   * C/C++ dependencies: every header the project's sources include, outside the project:
  --     the C/C++ standard library, the platform SDK, third-party libraries. Found by running
  --     each compile_commands.json command with `-M`, so it needs a compile_commands.json in
  --     a directory above the file (or its build/), e.g. from :CMakeConfigure. Rebuilt when
  --     compile_commands.json changes, after :CMakeConfigure, and by :Ctags (e.g. after
  --     including a header the project hasn't used before).
  --
  -- Files outside a project (such as a standard library header reached with gd) keep the
  -- tags of the buffer they were opened from, so gd keeps working inside them.

  local tags_dir = vim.fs.joinpath(vim.fn.stdpath 'cache', 'ctags')

  local function cache_file(root, suffix) return vim.fs.joinpath(tags_dir, (root:gsub('[/\\:]', '%%')) .. suffix) end

  -- Only git repositories are indexed, so opening a file in ~ never tags the whole home directory
  local function project_root(buf) return vim.fs.root(buf, '.git') end
  local function go_module_root(buf) return vim.fs.root(buf, 'go.mod') end

  -- compile_commands.json in the file's directory or a parent (or their build/), up to the project root
  local function compile_commands(buf, root)
    local dir = vim.fs.dirname(vim.fs.normalize(vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ':p')))
    while dir do
      for _, file in ipairs { dir .. '/compile_commands.json', dir .. '/build/compile_commands.json' } do
        if vim.uv.fs_stat(file) then return file end
      end
      local parent = vim.fs.dirname(dir)
      dir = dir ~= root and parent ~= dir and parent or nil
    end
  end

  -- --fields=+s records each Go tag's package, which gd uses to resolve `pkg.Func`
  -- (and each C++ tag's namespace or class); {specialization} marks C++ template specializations
  local ctags_opts = { '--tag-relative=never', '--fields=+s', '--fields-C++=+{specialization}', '--kinds-C=+px', '--kinds-C++=+px' }
  local ctags_args = 'ctags -L - ' .. table.concat(ctags_opts, ' ') .. ' -f "$2" 2>/dev/null'

  -- For system headers: libc++ headers have no extension (<vector>), and a few macros that
  -- wrap declarations confuse ctags' parser (libc++, macOS SDK, glibc, libstdc++)
  local c_dep_ctags_opts = {
    '--langmap=C++:+.',
    '-D_LIBCPP_BEGIN_NAMESPACE_STD=namespace std {',
    '-D_LIBCPP_END_NAMESPACE_STD=}',
    '-I_LIBC_SINGLE_BY_DEFAULT+,__BEGIN_DECLS,__END_DECLS,__printflike+,__scanflike+,__THROW,__wur,__nonnull+',
    '-I_GLIBCXX_BEGIN_NAMESPACE_VERSION,_GLIBCXX_END_NAMESPACE_VERSION,_GLIBCXX_VISIBILITY+',
  }

  -- Absolute paths of the project's files, since the tags file lives outside the project
  local project_files = [[git ls-files -co --exclude-standard | sed "s|^|$1/|"]]

  -- Absolute paths of the Go files (for this platform, no tests) of every package the module
  -- depends on, standard library included, excluding the module's own packages
  local go_dep_files = [[go list -e -deps -f '{{$d := .Dir}}{{$dep := .Standard}}{{with .Module}}{{if not .Main}}{{$dep = true}}{{end}}{{end}}{{if $dep}}{{range .GoFiles}}{{$d}}/{{.}}{{"\n"}}{{end}}{{range .CgoFiles}}{{$d}}/{{.}}{{"\n"}}{{end}}{{end}}' ./... 2>/dev/null]]

  -- Splits a compile_commands.json "command" string into arguments, the way sh would
  local function shell_split(cmd)
    local args, cur, quote, i = {}, nil, nil, 1
    while i <= #cmd do
      local c = cmd:sub(i, i)
      if quote == "'" then
        if c == "'" then
          quote = nil
        else
          cur = cur .. c
        end
      elseif quote == '"' then
        if c == '"' then
          quote = nil
        elseif c == '\\' and cmd:sub(i + 1, i + 1):match '["\\$`]' then
          i = i + 1
          cur = cur .. cmd:sub(i, i)
        else
          cur = cur .. c
        end
      elseif c:match '%s' then
        if cur then table.insert(args, cur) end
        cur = nil
      else
        cur = cur or ''
        if c == "'" or c == '"' then
          quote = c
        elseif c == '\\' then
          i = i + 1
          cur = cur .. cmd:sub(i, i)
        else
          cur = cur .. c
        end
      end
      i = i + 1
    end
    if cur then table.insert(args, cur) end
    return args
  end

  -- A compile command turned into one that prints the headers it includes (-M), instead of
  -- compiling. -MG lists missing (e.g. not yet generated) headers rather than failing.
  local function deps_command(args)
    local out, i = {}, 1
    while i <= #args do
      local a = args[i]
      if a == '-o' or a == '-MF' or a == '-MT' or a == '-MQ' then
        i = i + 1
      elseif not (a == '-c' or a:match '^%-M[MDPG]*$' or a:match '^%-M[FTQ].' or a:match '^%-o.') then
        table.insert(out, a)
      end
      i = i + 1
    end
    vim.list_extend(out, { '-M', '-MG' })
    return out
  end

  -- Adds each path in Make dependency output (`out.o: a.c b.h \`) to `deps`
  local function parse_deps(out, dir, deps)
    out = out:gsub('\\\n', ' '):gsub('\\ ', '\0')
    for word in out:gmatch '%S+' do
      if not word:match ':$' then
        local path = word:gsub('%z', ' ')
        if not path:match '^/' then path = vim.fs.joinpath(dir, path) end
        deps[vim.fs.normalize(path)] = true
      end
    end
  end

  -- Calls `done` with the absolute paths of the headers that compile_commands.json's sources
  -- include, outside the project's own files (already in the project tags), or nil on error
  local function c_dep_files(cc_json, root, done)
    local fd = io.open(cc_json)
    if not fd then return done(nil) end
    local ok, entries = pcall(vim.json.decode, fd:read '*a')
    fd:close()
    if not ok or type(entries) ~= 'table' then return done(nil) end

    vim.system({ 'git', 'ls-files', '-co', '--exclude-standard', '-z' }, { cwd = root }, function(git)
      local project = {}
      for f in (git.stdout or ''):gmatch '[^%z]+' do
        project[vim.fs.joinpath(root, f)] = true
      end

      local deps, next_entry, active = {}, 1, 0
      local function finish()
        local files = {}
        for path in pairs(deps) do
          if not project[path] and not path:find('/__cxx03/', 1, true) and vim.uv.fs_stat(path) then table.insert(files, path) end
        end
        table.sort(files)
        done(files)
      end

      -- Runs the commands in parallel, one per CPU
      local jobs = vim.uv.available_parallelism()
      local function run_next()
        while active < jobs and next_entry <= #entries do
          local entry = entries[next_entry]
          next_entry = next_entry + 1
          local args = entry.arguments or shell_split(entry.command or '')
          local dir = entry.directory or root
          active = active + 1
          local started = #args > 0
            and pcall(vim.system, deps_command(args), { cwd = dir, text = true }, function(res)
              parse_deps(res.stdout or '', dir, deps)
              active = active - 1
              run_next()
            end)
          if not started then active = active - 1 end
        end
        if active == 0 and next_entry > #entries then finish() end
      end
      run_next()
    end)
  end

  local running, pending = {}, {}

  -- Writes the tags file `file` with `produce(tmp, done)`, which writes `tmp` and calls
  -- `done(ok)`; it's then renamed into place, so a lookup never reads a half-written file.
  -- Overlapping requests rerun once at the end.
  local function generate(file, produce)
    if vim.fn.executable 'ctags' ~= 1 then return end
    if running[file] then
      pending[file] = true
      return
    end
    running[file] = true
    vim.fn.mkdir(tags_dir, 'p')
    local tmp = file .. '.tmp'
    produce(tmp, function(ok)
      if ok then vim.uv.fs_rename(tmp, file) end
      running[file] = nil
      if pending[file] then
        pending[file] = nil
        vim.schedule(function() generate(file, produce) end)
      end
    end)
  end

  -- Tags the files that the shell command `list_files` prints, run in `root` (also its $1)
  local function from_file_list(root, list_files)
    return function(tmp, done)
      vim.system({ 'sh', '-c', list_files .. ' | ' .. ctags_args, 'sh', root, tmp }, { cwd = root }, function(res) done(res.code == 0) end)
    end
  end

  local function generate_project(root) generate(cache_file(root, '.tags'), from_file_list(root, project_files)) end

  local function generate_go_deps(mod_root)
    if vim.fn.executable 'go' == 1 then generate(cache_file(mod_root, '.godeps.tags'), from_file_list(mod_root, go_dep_files)) end
  end

  local function c_deps_tags(cc_json) return cache_file(vim.fs.dirname(cc_json), '.cdeps.tags') end

  local function generate_c_deps(cc_json, root)
    generate(c_deps_tags(cc_json), function(tmp, done)
      c_dep_files(cc_json, root, function(files)
        if not files then return done(false) end
        local list = tmp .. '.files'
        local fd = io.open(list, 'w')
        if not fd then return done(false) end
        fd:write(table.concat(files, '\n'), '\n')
        fd:close()
        local cmd = vim.list_extend({ 'ctags', '-L', list, '-f', tmp }, ctags_opts)
        vim.system(vim.list_extend(cmd, c_dep_ctags_opts), {}, function(res)
          os.remove(list)
          done(res.code == 0)
        end)
      end)
    end)
  end

  local c_extensions = { c = true, cc = true, cpp = true, cxx = true, ['c++'] = true, h = true, hh = true, hpp = true, hxx = true, ipp = true, inl = true }

  local group = vim.api.nvim_create_augroup('custom-ctags', { clear = true })

  -- Point each buffer at its tags files (project first), generating them on first use
  vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
    group = group,
    callback = function(args)
      if vim.bo[args.buf].buftype ~= '' then return end
      local root = project_root(args.buf)
      if not root then
        -- Outside a project (e.g. a library file reached with gd): keep the previous buffer's tags
        local prev = vim.fn.bufnr '#'
        if prev > 0 and prev ~= args.buf and vim.api.nvim_buf_is_loaded(prev) then vim.bo[args.buf].tags = vim.bo[prev].tags end
        return
      end
      local files = { cache_file(root, '.tags') }
      if not vim.uv.fs_stat(files[1]) then generate_project(root) end

      -- By extension: filetype detection hasn't run yet when this autocmd fires
      local ext = vim.api.nvim_buf_get_name(args.buf):match '%.([^./]+)$'
      local mod_root = ext == 'go' and go_module_root(args.buf)
      if mod_root then
        local file = cache_file(mod_root, '.godeps.tags')
        table.insert(files, file)
        if not vim.uv.fs_stat(file) then generate_go_deps(mod_root) end
      end

      local cc_json = c_extensions[ext] and compile_commands(args.buf, root)
      if cc_json then
        local file = c_deps_tags(cc_json)
        table.insert(files, file)
        -- Regenerate when missing, or older than compile_commands.json
        local tags_stat, cc_stat = vim.uv.fs_stat(file), vim.uv.fs_stat(cc_json)
        if not tags_stat or (cc_stat and cc_stat.mtime.sec > tags_stat.mtime.sec) then generate_c_deps(cc_json, root) end
      end

      -- Escape spaces and commas: they separate entries in 'tags'
      vim.bo[args.buf].tags = table.concat(vim.tbl_map(function(f) return vim.fn.escape(f, ' ,\\') end, files), ',')
    end,
  })

  -- Keep tags current: the project on every save, Go dependencies when they change
  vim.api.nvim_create_autocmd('BufWritePost', {
    group = group,
    callback = function(args)
      local root = project_root(args.buf)
      if not root then return end
      generate_project(root)
      local name = vim.fs.basename(args.file)
      if name == 'go.mod' or name == 'go.sum' then generate_go_deps(vim.fs.dirname(vim.fs.normalize(vim.fn.fnamemodify(args.file, ':p')))) end
    end,
  })

  vim.api.nvim_create_user_command('Ctags', function()
    local root = project_root(0)
    if not root then return vim.notify('Not in a git repository', vim.log.levels.WARN) end
    generate_project(root)
    local mod_root = go_module_root(0)
    if mod_root then generate_go_deps(mod_root) end
    local cc_json = compile_commands(0, root)
    if cc_json then generate_c_deps(cc_json, root) end
  end, { desc = 'Regenerate ctags for the current project (and its Go or C/C++ dependencies)' })

  -- :CMakeConfigure rewrote compile_commands.json
  vim.api.nvim_create_autocmd('User', {
    group = group,
    pattern = 'CMakeConfigured',
    callback = function(args)
      local cc_json = args.data.build .. '/compile_commands.json'
      local root = vim.fs.root(args.data.build, '.git')
      if root and vim.uv.fs_stat(cc_json) then generate_c_deps(cc_json, root) end
    end,
  })

  -- C/C++ tag kinds that declare rather than define: function prototypes, extern variables
  local declaration_kinds = { p = true, x = true }

  -- Set while gd / gD run, so 'tagfunc' only filters their matches; every other tag
  -- command keeps Neovim's default lookup.
  local lookup -- { kind = 'definition' | 'declaration', qualifier = 'pkg' in `pkg.Name`, or nil }

  -- Narrows `tags` to those matching `keep`, unless that would leave none
  local function prefer(tags, keep)
    local kept = vim.tbl_filter(keep, tags)
    return #kept > 0 and kept or tags
  end

  ---@diagnostic disable-next-line: duplicate-set-field
  function _G.CustomTagfunc(pattern, _, info)
    if not lookup then return vim.NIL end
    -- taglist() inside 'tagfunc' uses the normal lookup (tagfunc isn't called recursively)
    local tags = vim.fn.taglist('^' .. vim.fn.escape(pattern, [[\.*[]~^$/]]) .. '$', info.buf_ffname)
    local ft = vim.bo.filetype

    -- C/C++: definitions for gd, prototypes/extern declarations for gD. Elsewhere (and for
    -- static C functions) the definition is the declaration.
    if ft == 'c' or ft == 'cpp' then
      local want_declaration = lookup.kind == 'declaration'
      tags = prefer(tags, function(tag) return (declaration_kinds[tag.kind] == true) == want_declaration end)

      -- C++: `ns::Name` / `Class::Name` means Name in that namespace or class
      local function in_scope(scope, name) return scope ~= nil and (scope == name or vim.endswith(scope, '::' .. name)) end
      if lookup.qualifier then
        tags = prefer(tags, function(tag) return in_scope(tag.namespace or tag.class or tag.struct or tag.union or tag.enum, lookup.qualifier) end)
      end
      -- A class's constructors share its name: prefer the class itself
      tags = prefer(tags, function(tag) return not in_scope(tag.class or tag.struct, pattern) end)
      -- ...and the primary template over specializations such as vector<bool>
      tags = prefer(tags, function(tag) return tag.specialization == nil end)
    end

    -- Go: `pkg.Name` means Name in package pkg. A bare `Name` is in the current package,
    -- which is the current file's directory.
    if ft == 'go' then
      if lookup.qualifier then
        tags = prefer(tags, function(tag) return tag.package == lookup.qualifier end)
      else
        local dir = vim.fs.dirname(info.buf_ffname)
        tags = prefer(tags, function(tag) return vim.fs.dirname(vim.fs.normalize(tag.filename)) == dir end)
      end
    end

    return tags
  end
  vim.o.tagfunc = 'v:lua.CustomTagfunc'

  -- The identifier before a `.` or `::` directly preceding the word under the cursor: `fmt` in
  -- fmt.Println, `std` in std::vector
  local function qualifier_under_cursor()
    local line, col = vim.api.nvim_get_current_line(), vim.fn.col '.'
    local start = col
    while start > 1 and line:sub(start - 1, start - 1):match '[%w_]' do
      start = start - 1
    end
    local before = line:sub(1, start - 1)
    return before:match '([%a_][%w_]*)%.$' or before:match '([%a_][%w_]*)::$'
  end

  local function goto_tag(kind, fallback)
    return function()
      local word = vim.fn.expand '<cword>'
      if word == '' then return end
      lookup = { kind = kind, qualifier = qualifier_under_cursor() }
      local ok = pcall(vim.cmd.tjump, word) -- jumps directly with one match, lists several
      lookup = nil
      if not ok then vim.cmd.normal { fallback, bang = true } end
    end
  end

  vim.keymap.set('n', 'gd', goto_tag('definition', 'gd'), { desc = '[G]oto [D]efinition (ctags)' })
  vim.keymap.set('n', 'gD', goto_tag('declaration', 'gD'), { desc = '[G]oto [D]eclaration (ctags)' })
  vim.keymap.set('n', '<leader>sT', function() require('telescope.builtin').tags() end, { desc = '[S]earch project [T]ags' })
end

-- ============================================================
-- C/C++ & CMAKE
-- header/source switching, CMake build integration
-- ============================================================
do
  -- Switch between foo.c/foo.cpp and foo.h/foo.hpp: looks next to the file first,
  -- then anywhere under the working directory (e.g. src/ <-> include/).
  local source_exts = { 'c', 'cc', 'cpp', 'cxx' }
  local header_exts = { 'h', 'hh', 'hpp', 'hxx' }
  vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('custom-switch-header', { clear = true }),
    pattern = { 'c', 'cpp' },
    callback = function(args)
      vim.keymap.set('n', '<leader>ch', function()
        local path = vim.api.nvim_buf_get_name(0)
        local stem, ext = vim.fn.fnamemodify(path, ':t:r'), vim.fn.fnamemodify(path, ':e')
        local targets = vim.tbl_contains(header_exts, ext) and source_exts or header_exts
        local names = vim.tbl_map(function(e) return stem .. '.' .. e end, targets)
        local found = vim.fs.find(names, { path = vim.fs.dirname(path), limit = 1 })[1]
          or vim.fs.find(names, { path = vim.fn.getcwd(), type = 'file', limit = 1 })[1]
        if found then
          vim.cmd.edit(vim.fn.fnameescape(found))
        else
          vim.notify('No matching source/header for ' .. stem, vim.log.levels.WARN)
        end
      end, { buffer = args.buf, desc = 'Switch source/[H]eader' })
    end,
  })

  -- Top-most directory containing a CMakeLists.txt (subdirectories often have their own)
  local function cmake_root(path)
    local found = vim.fs.find('CMakeLists.txt', { upward = true, path = path, limit = math.huge })
    if #found == 0 then return nil end
    return vim.fs.dirname(found[#found])
  end

  local function current_cmake_root()
    local root = cmake_root(vim.fs.dirname(vim.api.nvim_buf_get_name(0))) or cmake_root(vim.fn.getcwd())
    if not root then vim.notify('No CMakeLists.txt found', vim.log.levels.WARN) end
    return root
  end

  -- In CMake projects, `:make` builds into <root>/build and loads errors into the quickfix list
  vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('custom-cmake-makeprg', { clear = true }),
    pattern = { 'c', 'cpp', 'cmake' },
    callback = function(args)
      local root = cmake_root(vim.fs.dirname(vim.api.nvim_buf_get_name(args.buf)))
      if root then vim.bo[args.buf].makeprg = 'cmake --build ' .. vim.fn.fnameescape(root .. '/build') end
    end,
  })

  -- :CMakeConfigure [build type] – configure <root>/build with Ninja and export compile_commands.json
  vim.api.nvim_create_user_command('CMakeConfigure', function(opts)
    local root = current_cmake_root()
    if not root then return end
    local build_type = opts.args ~= '' and opts.args or 'Debug'
    local cmd = { 'cmake', '-S', root, '-B', root .. '/build', '-G', 'Ninja', '-DCMAKE_BUILD_TYPE=' .. build_type, '-DCMAKE_EXPORT_COMPILE_COMMANDS=ON' }
    vim.notify('Configuring ' .. root .. ' (' .. build_type .. ')...')
    vim.system(cmd, { text = true }, function(res)
      vim.schedule(function()
        if res.code == 0 then
          vim.notify 'CMake configure finished'
          vim.api.nvim_exec_autocmds('User', { pattern = 'CMakeConfigured', data = { build = root .. '/build' } })
        else
          vim.notify('CMake configure failed:\n' .. (res.stderr or ''), vim.log.levels.ERROR)
        end
      end)
    end)
  end, { nargs = '?', complete = function() return { 'Debug', 'Release', 'RelWithDebInfo', 'MinSizeRel' } end, desc = 'Configure CMake project' })

  vim.keymap.set('n', '<leader>cc', '<cmd>CMakeConfigure<CR>', { desc = '[C]Make [C]onfigure' })
  vim.keymap.set('n', '<leader>cb', '<cmd>make | cwindow<CR>', { desc = '[C]Make [B]uild' })
end

-- ============================================================
-- SECTION 10: OPTIONAL EXAMPLES / NEXT STEPS
-- kickstart.plugins.* examples
-- ============================================================
do
  -- The following comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  require 'kickstart.plugins.debug'
  require 'kickstart.plugins.indent_line'
  -- require 'kickstart.plugins.lint'
  require 'kickstart.plugins.autopairs'
  -- require 'kickstart.plugins.neo-tree'

  -- NOTE: You can add your own plugins, configuration, etc. in `lua/custom/plugins/*.lua`.
  --
  -- For independent modules, uncomment the convenience loader:
  -- require 'custom.plugins'
  --
  -- `custom.plugins` automatically loads files from that directory, but their
  -- order is unspecified. If plugins depend on each other, keep them in the same
  -- file and put their `vim.pack.add()` and `setup()` calls in the required order.
  --
  -- If separate modules need a specific order, require them explicitly instead:
  -- require 'custom.plugins.colorscheme'
  -- require 'custom.plugins.ui'
  -- require 'custom.plugins.git'
end

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
