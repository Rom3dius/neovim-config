local M = {}

M.plugins = {
  { "gelguy/wilder.nvim" },
  {'akinsho/toggleterm.nvim', version = "*", config = true},
}

M.configs = function()
  local map = vim.keymap.set
  map({'n', 'v'}, "L", "$", { desc = "Skip to line end" }) -- skip to line end
  map({'n', 'v'}, "H", "0", { desc = "Skip to line start" }) -- skip to line start
  map('n', '<leader>gd', vim.lsp.buf.definition, { desc = "LSP Jump to definition" }) -- get definition
  map('n', '<leader>gs', vim.lsp.buf.signature_help, { desc = "LSP Get signature" }) -- get signature
  map('n', '<leader>gh', vim.lsp.buf.hover, { desc = "LSP Get hover information" })
  map('n', '<leader>gr', vim.lsp.buf.references, { desc = "LSP Get references" })
  map('n', '<leader>gi', vim.lsp.buf.implementation, { desc = "LSP Get implementations" })
  map('n', '<leader>go', vim.lsp.buf.type_definition, { desc = "LSP Jump to type definition" })
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
end

M.formatting_servers = {
}
return M

