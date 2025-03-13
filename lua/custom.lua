local M = {}

M.configs = function()
  local map = vim.keymap.set
  map("n", "L", "$") -- skip to line end
  map("n", "H", "0") -- skip to line start
  map('n', '<C-H>', '<C-W>h', { noremap = true, silent = true }) -- swap windows
  map('n', '<C-L>', '<C-W>l', { noremap = true, silent = true }) -- swap windows
end

return M

