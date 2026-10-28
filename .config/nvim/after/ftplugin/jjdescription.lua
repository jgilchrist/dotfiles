vim.o.cursorline = false

-- Fold diffs
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = [[getline(v:lnum) == 'JJ: ignore-rest' ? '>1' : getline(v:lnum) =~ '^JJ:' ? 0 : '=']]
vim.wo.foldtext = [['JJ: diff (' . (v:foldend - v:foldstart) . ' lines)']]
