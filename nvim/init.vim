" Shared Neovim and Vim config

let is_vim = !has('nvim')
let is_nvim = has('nvim')

if is_nvim
    let $BASE = stdpath('config')
else
    let $BASE = '$HOME/.vim'
endif

" Lines and columns
set colorcolumn=80     " Show at 80 column a border for good code style 
set number             " Show line numbers
set relativenumber     " Show relative line numbers
" Search
set ignorecase         " Ignore case in search patterns
set smartcase          " Override the 'ignorecase' option if the search pattern contains upper case characters

""" PLUGINS
" Specify a directory for plugins
call plug#begin($BASE.'/plugged')

    " Navigation - have a folder structure and to view or jump to different files
    Plug 'preservim/nerdtree'

    " Fuzzy find files
    Plug 'ctrlpvim/ctrlp.vim'

    " Themes / color scheme
    Plug 'joshdick/onedark.vim'

" Initialize plugin system
call plug#end()

source $BASE/common.vim
source $BASE/plugins.vim

""" THEME AND COLORS

colorscheme onedark

""" KEYBINDS

" Change the leader key from "\" to space (";" and "," are also popular)
let mapleader=" "

" Reload config
nnoremap <silent> <leader>r :source $MYVIMRC<cr>
"  nnoremap <silent> <leader><leader> :source $MYVIMRC<cr>
" Edit THIS configuration file: (e)dit (c)onfiguration
nnoremap <silent> <leader>ec :edit $MYVIMRC<CR>

" Use two semicolons ;; for escape
" ref: http://vim.wikia.com/wiki/Avoid_the_escape_key
:imap ;; <Esc>
:imap ii <Esc>
:imap jk <Esc>

" Save with Ctrl+S
nnoremap <C-s> :w<CR>

" Quit without saving with Ctrl+Q
nnoremap <C-q> :q<CR>

" Select all
map <silent> <C-a> <esc>ggVG<CR>

" Insert a newline without entering in insert mode
nmap oo o<Esc>k " new line below 
nmap OO O<Esc>j " new line above

" Move lines with Ctrl+J/K
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Move lines with Alt+J/K
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=v
