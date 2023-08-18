function map(mode, key, action, opts)
    opts = opts or { noremap = true, silent = true }
    vim.api.nvim_set_keymap(mode, key, action, opts)
  end
  
  
  -- Normal mode mappings
  map('n', '<C-h>', '<C-w>h') -- Move to window left
  map('n', '<C-l>', '<C-w>l') -- Move to window right
  map('n', '<C-j>', '<C-w>j') -- Move to window down
  map('n', '<C-k>', '<C-w>k') -- Move to window up
  
  
  map('n', '<leader>w', '<cmd>call VSCodeNotify("workbench.action.files.save")<CR>') -- Save file
  map('n', '<leader>x', '<cmd>call VSCodeNotify("workbench.action.closeActiveEditor")<CR>') -- Close current buffer

  
-- Search

-- Normal mode mappings
map('n', '<leader>ff', '<cmd>call VSCodeNotify("workbench.action.quickOpen")<CR>') -- Find files
map('n', '<leader>fg', '<cmd>call VSCodeNotify("workbench.action.findInFiles")<CR>') -- Live grep
map('n', '<leader>fb', '<cmd>call VSCodeNotify("workbench.action.openRecent")<CR>') -- Find buffers
map('n', '<leader>fh', '<cmd>call VSCodeNotify("workbench.action.showCommands")<CR>') -- Help page

-- Git
map('n', '<leader>cm', '<cmd>call VSCodeNotify("git.showAllCommits")<CR>') -- Git commits
map('n', '<leader>gt', '<cmd>call VSCodeNotify("workbench.view.scm")<CR>') -- Git status

