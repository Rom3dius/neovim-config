local M = {}

-- This is custom.lua! This nvim installation is based on ntk148v/neovim-config
-- These are the changes Romedius made.
-- Not all plugins and keybinds are listed here, checkout mappings.lua and plugins/init.lua
--
--
--
--
--

M.plugins = {
  { "goolord/alpha-nvim" },
  { "gelguy/wilder.nvim" },
  {'akinsho/toggleterm.nvim', version = "*", config = true},
}

M.configs = function()
  local map = vim.keymap.set
  local unmap = vim.keymap.del
  -- unmap keybinds I don't like from mappings.lua
  unmap("n", "<leader>q")
  unmap("n", "<leader>wh")
  unmap("n", "<leader>wj")
  unmap("n", "<leader>wk")
  unmap("n", "<leader>wl")
  unmap("n", "<leader>cm")

  -- quit out
  map("n", "<leader>q", ":qa!<CR>", { desc = "Close nvim" })

  -- normal navigation
  map({'n', 'v'}, "L", "$", { desc = "Skip to line end" }) -- skip to line end
  map({'n', 'v'}, "H", "0", { desc = "Skip to line start" }) -- skip to line start
  map('n', '<C-H>', "<C-w>h", { desc = "switch window left" })
  map('n', '<C-J>', "<C-w>j", { desc = "switch window right" })
  map('n', '<C-K>', "<C-w>k", { desc = "switch window up" })
  map('n', '<C-L>', "<C-w>l", { desc = "switch window down" })

  -- terminal navigation
  map('t', '<C-H>', '<C-\\><C-n><C-w>h', { desc = "switch window left" })
  map('t', '<C-J>', '<C-\\><C-n><C-w>j', { desc = "switch window down" })
  map('t', '<C-K>', '<C-\\><C-n><C-w>k', { desc = "switch window up" })
  map('t', '<C-L>', '<C-\\><C-n><C-w>l', { desc = "switch window right" })
  map('t', '<Esc>', '<C-\\><C-n>', { desc = "Exit terminal mode" })

  -- manage windows
  map('n', '<leader>wv', ':vsplit<CR>', { desc = "Split window vertically "})
  map('n', '<leader>wq', ':q<CR>', { desc = "Close window" })
  map('n', '<leader>wh', ':vertical resize +12<CR>', { desc = "Increase window size left" })
  map('n', '<leader>wl', ':vertical resize -12<CR>', { desc = "Increase window size right" })
  map('n', '<leader>wk', ':resize +12<CR>', { desc = "Increase window size up" })
  map('n', '<leader>wj', ':resize -12<CR>', { desc = "Increase window size down" })

  -- manage terminals
  map('n', '<leader>th', '<Cmd>ToggleTerm direction=horizontal<CR>', { desc = "Open terminal horizontally" })
  map('n', '<leader>tv', '<Cmd>ToggleTerm direction=vertical<CR>', { desc = "Open terminal vertically" })
  map('n', '<leader>t1', '<Cmd>ToggleTerm 1<CR>', { desc = "Open terminal 1" })
  map('n', '<leader>t2', '<Cmd>ToggleTerm 2<CR>', { desc = "Open terminal 2" })
  map('n', '<leader>t3', '<Cmd>ToggleTerm 3<CR>', { desc = "Open terminal 3" })
  map('n', '<leader>t4', '<Cmd>ToggleTerm 4<CR>', { desc = "Open terminal 4" })

  -- LSP shortcuts
  map('n', '<leader>gd', vim.lsp.buf.definition, { desc = "LSP Jump to definition" }) -- get definition
  map('n', '<leader>gs', vim.lsp.buf.signature_help, { desc = "LSP Get signature" }) -- get signature
  map('n', '<leader>gh', vim.lsp.buf.hover, { desc = "LSP Get hover information" })
  map('n', '<leader>gr', vim.lsp.buf.references, { desc = "LSP Get references" })
  map('n', '<leader>gi', vim.lsp.buf.implementation, { desc = "LSP Get implementations" })
  map('n', '<leader>go', vim.lsp.buf.type_definition, { desc = "LSP Jump to type definition" })

  -- buffer navigation
  map('n', '<Tab>', ':bnext<CR>', { desc = "Go to next buffer" })
  map('n', '<S-Tab>', ':bprevious<CR>', { desc = "Go to previous buffer" })
  map('n', '<leader>qb', ':bd<CR>', { desc = "Close current buffer" })

  -- pull up which-key
  map('n', '<leader>h', ':WhichKey<CR>', { desc = "Open WhichKey to see keybindings" })

  -- pull up alpha
  map('n', '<leader>a', ':Alpha<CR><CR>', { silent = true, desc = "Opens the Alpha dashboard" })

  -- setup wilder
  local wilder = require('wilder')
  wilder.setup({modes = {':', '/', '?'}})
  wilder.set_option('renderer', wilder.popupmenu_renderer(
    wilder.popupmenu_palette_theme({
      -- 'single', 'double', 'rounded' or 'solid'
      -- can also be a list of 8 characters, see :h wilder#popupmenu_palette_theme() for more details
      border = 'rounded',
      max_height = '75%',      -- max height of the palette
      min_height = 0,          -- set to the same as 'max_height' for a fixed height window
      prompt_position = 'top', -- 'top' or 'bottom' to set the location of the prompt
      reverse = 0,             -- set to 1 to reverse the order of the list, use in combination with 'prompt_position'
    })
  ))

  -- setup alpha (greeting screen)
  local telescope_f = require("telescope.builtin")
  local alpha = require'alpha'
  local dashboard = require'alpha.themes.dashboard'
  dashboard.section.header.val = {
    [[     ⠀⠀⠀ ⣀⣤⣴⣶⣾⣿⣿⣿⣿⣷⣶⣦⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀ ]],
    [[ ⠀⠀⠀⠀⠀⣠⣴⣿⠿⢛⣩⣥⣶⠶⠶⠶⠶⣶⣬⣍⡛⠿⣿⣦⣄⠀⠀⠀⠀⠀ ]],
    [[ ⠀⠀⠀⣠⣾⡿⢋⣥⠞⠋⠈⣿⣿⠀⠀⠀⠀⣿⣿⠉⠙⠳⣬⡛⢿⣷⣄⠀⠀⠀ ]],
    [[ ⠀⠀⣴⣿⠏⣴⠋⠀⠀⠀⠀⣿⣿⡆⠀⠀⢸⣿⣿⠀⠀⠀⠀⢹⣦⠻⣿⣦⠀⠀ ]],
    [[ ⠀⣼⣿⢃⣾⣿⣏⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⣹⣿⣷⡘⣿⣧⠀ ]],
    [[ ⢰⣿⠇⡾⠻⡅⠉⠛⢦⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⡴⠛⠉⢨⠟⣧⢸⣿⡆ ]],
    [[ ⣾⣿⢸⡇⠀⠹⣄⠀⠀⠈⢻⣿⡿⢿⣿⣿⡿⢿⣿⡟⠁⠀⠀⣰⠋⠀⢸⡆⣿⣷ ]],
    [[ ⣿⣿⢸⡇⠀⠀⣘⣆⠀⠀⠀⠻⣷⣦⠀⠀⣴⣾⠏⠀⠀⠀⣰⣃⠀⠀⢸⡇⣿⣿ ]],
    [[ ⢿⣿⢸⣷⣾⣿⡿⠟⢦⠀⠀⠀⠹⣿⣇⣸⣿⠏⠀⠀⠀⡼⠻⢿⣿⣷⣾⠇⣿⡟ ]],
    [[ ⠸⣿⡆⢿⡉⠁⠀⠀⠈⢧⠀⠀⠀⠙⣿⣿⠃⠀⠀⢀⡜⠁⠀⠀⠈⢙⡟⣸⣿⠇ ]],
    [[ ⠀⢻⣿⡌⢷⡀⠀⣠⣴⣿⣷⡀⠀⠀⢸⡇⠀⠀⢀⣾⣿⣦⣄⠀⢀⡾⣡⣿⡟⠀ ]],
    [[ ⠀⠀⠻⣿⣦⠻⣿⣿⠿⠋⠀⠳⡄⠀⢸⡇⠀⢠⠎⠀⠙⢿⣿⣿⢟⣴⣿⠟⠀⠀ ]],
    [[ ⠀⠀⠀⠙⢿⣷⣬⡛⢦⣄⡀⠀⠹⣄⣸⣇⣠⠏⠀⢀⣠⡴⢛⣵⣾⡿⠃⠀⠀⠀ ]],
    [[ ⠀⠀⠀⠀⠀⠉⠻⣿⣶⣬⣉⣛⠲⠿⠿⠿⠿⠖⣛⣩⣥⣾⣿⠟⠉⠀⠀⠀⠀⠀ ]],
    [[ ⠀⠀⠀⠀⠀⠀⠀⠀⠉⠛⠻⠿⠿⣿⣿⣿⣿⠿⠿⠟⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀ ]],
    [[                                ]],
    [[  I have found through painful  ]],
    [[  experience, that the most     ]],
    [[  important step a person can   ]],
    [[  take is the next one.         ]],
  }
  dashboard.section.buttons.val = {
      dashboard.button( "e", "  New file" , ":ene <BAR> startinsert <CR>"),
      dashboard.button( "f", "  Find File", ":Telescope find_files<CR>"),
      dashboard.button( "g", "󰦨  Find text", ":Telescope live_grep<CR>"),
      dashboard.button( "h", "  Show keybindings", ":WhichKey<CR>"),
      dashboard.button( "s", "  Configure NVIM", ":cd ~/.config/nvim | :edit lua/custom.lua<CR><CR>"),
  }
  if vim.fn.isdirectory("~/.config/hypr") then
    local hypr_button = dashboard.button("d", "󰍹  Configure Hyprland", ":cd ~/.config/hypr | :edit ~/.config/hypr/UserConfigs/UserKeybinds.conf<CR><CR>")
    table.insert(dashboard.section.buttons.val, hypr_button)
  end
  local quit_button = dashboard.button( "q", "  Quit NVIM" , ":qa<CR>")
  table.insert(dashboard.section.buttons.val, quit_button)
  local handle = io.popen('fortune')
  local fortune = handle:read("*a")
  handle:close()
  dashboard.section.footer.val = fortune
  dashboard.config.opts.noautocmd = true
  vim.cmd[[autocmd User AlphaReady echo 'ready']]
  alpha.setup(dashboard.config)

  -- reconfigure telescope
  require("telescope").setup {
    defaults = {
      mappings = {
        n = {
          ['<C-d>'] = require('telescope.actions').delete_buffer
        },
        i = {
          ["<C-d>"] = require('telescope.actions').delete_buffer
        }
      }
    }
  }

  -- reconfigure nvimtree to find hidden files
  require("nvim-tree").setup {
    git = {
      ignore = false
    },
    filters = {
      dotfiles = false
    }
  }

end

M.formatting_servers = {
  basedpyright = {
    settings = {
      basedpyright = {
        typeCheckingMode = "standard",
        venvPath = ".",
        venv = ".venv",
      }
    }
  }
}
return M

