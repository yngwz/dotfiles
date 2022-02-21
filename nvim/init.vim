"------------------------------------------------------------------------------
" General Settings
"------------------------------------------------------------------------------
set hidden
set termguicolors
set tabstop=4
set softtabstop=4
set expandtab
set smartindent
set exrc
set guicursor=
set nu
set relativenumber
set nohlsearch
set noerrorbells
set undodir=~/.vim/undodir
set scrolloff=8
set incsearch
set cmdheight=2
set updatetime=50
set signcolumn
set clipboard=unnamed
set ignorecase

"------------------------------------------------------------------------------
" Keymaps 
"------------------------------------------------------------------------------
let mapleader = "\<space>"

nmap <leader>ve :edit ~/.config/nvim/init.vim<cr>
nmap <leader>vc :edit ~/.config/nvim/coc-settings.vim<cr>
nmap <leader>vr :source ~/.config/nvim/init.vim<cr>
nmap <leader>pi :PlugInstall <cr>

nmap <leader>k :nohlsearch<CR>

" substitution
nmap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>
nmap <Leader>sf :%s/\<<C-r><C-w>\>//gc<Left><Left><Left>

:nnoremap <Tab> :bnext<CR>
:nnoremap <S-Tab> :bprevious<CR>

"------------------------------------------------------------------------------
" Plugins 
"------------------------------------------------------------------------------

"Automatically install vim plug
let data_dir = has('nvim') ? stdpath('data') . '/site': '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


call plug#begin(data_dir . '/plugins')

source ~/.config/nvim/plugins/plenary.vim " Common nvim plugin dependency
source ~/.config/nvim/plugins/nvim-treesitter.vim " Common nvim plugin dependency
source ~/.config/nvim/plugins/dracula.vim
source ~/.config/nvim/plugins/airline.vim
source ~/.config/nvim/plugins/coc.vim
source ~/.config/nvim/plugins/fzf.vim
source ~/.config/nvim/plugins/telescope.vim
source ~/.config/nvim/plugins/dashboard-nvim.vim
source ~/.config/nvim/plugins/nerdtree.vim
source ~/.config/nvim/plugins/polyglot.vim
source ~/.config/nvim/plugins/prisma.vim
source ~/.config/nvim/plugins/floaterm.vim
source ~/.config/nvim/plugins/commentary.vim
" source ~/.config/nvim/plugins/javascript.vim
" source ~/.config/nvim/plugins/typescript.vim
source ~/.config/nvim/plugins/surround.vim

call plug#end()

doautocmd User PlugLoaded

