vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

require("config.lazy")

map <leader>conf :tabe ~/.config/nvim/.vimrc<cr>
autocmd bufwritepost .vimrc source $MYVIMRC
