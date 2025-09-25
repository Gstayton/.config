vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.swapfile = false
vim.opt.signcolumn = "yes"
vim.opt.winborder = "rounded"
vim.opt.undofile = true
vim.opt.termguicolors = true
vim.opt.autocomplete = false
vim.opt.autocompletedelay = 15 -- prevent autocomplete from eating chars while typing
vim.opt.completeopt = "noselect"
vim.opt.autochdir = true
vim.opt.colorcolumn = "80"

vim.cmd('filetype off')
vim.cmd('filetype plugin indent on')

vim.g.suda_smart_edit = true

vim.g.mapleader = ","

-- plugins
vim.pack.add({
	{ src = "https://github.com/vague2k/vague.nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/echasnovski/mini.pick" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/chomosuke/typst-preview.nvim" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/lambdalisue/vim-suda" },
	{ src = "https://github.com/RedsXDD/neopywal.nvim" },
	{ src = "https://github.com/folke/which-key.nvim" },
	{ src = "https://github.com/mason-org/mason.nvim.git" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/kaarmu/typst.vim" },
	{ src = "https://github.com/SirVer/ultisnips" },
	{ src = "https://github.com/zk-org/zk-nvim" },
	{ src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
})

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client == nil then
			return
		end
		if client:supports_method('textDocument/completion') then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
	end,
})

-- plugin setups
require("mason").setup()
require("mini.pick").setup()
require("render-markdown").setup({
	file_types = {"markdown"}
})
require("conform").setup({
	formatters_by_ft = {
		nix = { "nixfmt" },
	},
})

-- user lua files
require('usr/oil')
require('usr/zk')
require('usr/reload')
require('usr/mappings')
require('usr/lsp/lua_ls')


-- vim.lsp.config('*', {
-- 	root_markers= {'.git'},
-- })
vim.lsp.enable({ "lua_ls", "alejandra", "autopep8", "bashls", "ast-grep", "clang" })

vim.opt.termguicolors = true
vim.cmd.colorscheme("neopywal")
