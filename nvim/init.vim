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
