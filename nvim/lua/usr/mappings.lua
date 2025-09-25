vim.keymap.set({ 'n', 'v' }, '<a-/>', ':let @/ = "" <CR>') -- clear search
vim.keymap.set({ 'n', 'v' }, '<leader>v', ':e $MYVIMRC<CR>')
vim.keymap.set({ 'n', 'v' }, '<leader>be', ':e ~/.bashrc<CR>')
vim.keymap.set({ 'n', 'v' }, '<leader>nix', ':e /etc/nixos/configuration.nix<CR>')
vim.keymap.set({ 'n', 'v' }, '<leader>o', ':write<CR>:lua ReloadConfig()<CR>')
vim.keymap.set({ 'n', 'v' }, '<leader>w', ':write<CR>')
vim.keymap.set({ 'n', 'v' }, '<leader>q', ':quit<CR>')
vim.keymap.set({ 'n', 'v' }, '<leader>S', ':bot sf #<CR>')
vim.keymap.set({ 'n', 'v' }, '<leader>d', '"+d')
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y')
vim.keymap.set({ 'n', 'v' }, '<leader>p', '"+p')
vim.keymap.set({ 'n', 'v' }, '<leader>?', function()
	require "which-key".show({ global = false })
end)

vim.keymap.set('n', '<leader>f', ':Pick files<CR>')
vim.keymap.set('n', '<leader>e', ':Oil<CR>')
vim.keymap.set('n', '<leader>h', ':Pick help<CR>')
vim.keymap.set('n', '<leader>g', ':Pick buffers<CR>')

vim.keymap.set('n', ';', ':')

vim.keymap.set('n', '<leader>lf', function()
	require("conform").format({ async = true })
end)

-- zk specific mappings
local opts = {silent = true, noremap = true}
-- Create new note with title
vim.keymap.set('n', '<leader>zn', ':ZkNew { title = vim.fn.input("Title: ")}<CR>', opts)
-- Open notes
vim.keymap.set('n', '<leader>zo', ':ZkNotes { sort = { "modified" } }<CR>', opts)
-- Open notes by tag
vim.keymap.set('n', '<leader>zt', ':ZkTags<CR>', opts)
-- Search notes
vim.keymap.set('n', '<leader>zf', ":ZkNotes { sort = { 'modified' }, match = {vim.fn.input('Search: ') } }<CR>", opts)
-- Search for notes matching selection
vim.keymap.set('v', '<leader>zf', ":'<,'>ZkMatch<CR>", opts)

vim.keymap.set('n', '<Tab>', ':bn<CR>');
vim.keymap.set('n', '<S-Tab>', ':bp<CR>');

vim.keymap.set("n", "<BS>", ":b#<CR>", { silent=true })


