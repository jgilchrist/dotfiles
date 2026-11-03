vim.o.cursorline = false

-- Fold diffs
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = [[getline(v:lnum) == 'JJ: ignore-rest' ? '>1' : getline(v:lnum) =~ '^JJ:' ? 0 : '=']]
vim.wo.foldtext = [['JJ: diff (' . (v:foldend - v:foldstart) . ' lines)']]

-- Expand folds by default if there's only a single diff
local diffs = vim.iter(vim.api.nvim_buf_get_lines(0, 0, -1, false))
    :filter(function(line) return line == "JJ: ignore-rest" end)
    :totable()

vim.wo.foldlevel = #diffs > 1 and 0 or 99
