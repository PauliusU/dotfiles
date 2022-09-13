set colorcolumn=80 " Show at 80 column a border for good code style
highlight ColorColumn ctermbg=0 guibg=lightgrey " Use more gentle column highlight
set number " show line numbers
set relativenumber " show relative line numbers

" PLUGINS
" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" Navigation - have a folder structure and to view or jump to different files
Plug 'preservim/nerdtree'

" Fuzzy find files
Plug 'ctrlpvim/ctrlp.vim'

" Code completion - conquer of completion (coc)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Themes / color scheme
Plug 'joshdick/onedark.vim'

" Initialize plugin system
call plug#end()

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
