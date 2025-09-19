vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.swapfile = false
vim.opt.signcolumn = "yes"
vim.opt.winborder = "rounded"
vim.opt.undofile = true
vim.opt.termguicolors = true

vim.g.mapleader = ","


vim.keymap.set({ 'n', 'v' }, '<leader>v', ':e $MYVIMRC<CR>')
vim.keymap.set({ 'n', 'v' }, '<leader>b', ':e ~/.ashrc<CR>')
vim.keymap.set({ 'n', 'v' }, '<leader>nix', ':e /etc/nixos/configuration.nix<CR>')
vim.keymap.set({ 'n', 'v' }, '<leader>o', ':update<CR>:source<CR>')
vim.keymap.set({ 'n', 'v' }, '<leader>w', ':write<CR>')
vim.keymap.set({ 'n', 'v' }, '<leader>q', ':quit<CR>')
vim.keymap.set({ 'n', 'v' }, '<leader>S', ':bot sf #<CR>')
vim.keymap.set({ 'n', 'v' }, '<leader>d', '"+d')
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y')
vim.keymap.set({ 'n', 'v' }, '<leader>p', '"+p')


vim.pack.add({
	{ src = "https://github.com/vague2k/vague.nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/echasnovski/mini.pick" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/chomosuke/typst-preview.nvim" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/lambdalisue/vim-suda" },
})

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client:supports_method('textDocument/completion') then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
	end,
})
vim.cmd("set completeopt+=noselect")

require "mini.pick".setup()
require "oil".setup()
require "conform".setup({
	formatters_by_ft = {
		nix = { "nixfmt" },
	},
})

vim.keymap.set('n', '<leader>f', ':Pick files<CR>')
vim.keymap.set('n', '<leader>e', ':Oil<CR>')
vim.keymap.set('n', '<leader>h', ':Pick help<CR>')

vim.lsp.enable({ "lua_ls", "nil_ls", "autopep8" })

vim.keymap.set('n', '<leader>lf', function()
	require("conform").format({ async = true })
end)

vim.cmd("colorscheme vague")
