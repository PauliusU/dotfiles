" Neovim and Vim common config

" General
set scrolloff=8         " Scrooll with leaving some space below (avoid pressing zz)

" Lines and columns
set colorcolumn=81      " Show after 80 column a border for good code style
set number              " Show line numbers
set relativenumber      " Show relative line numbers
set cursorline          " Highlight the screen line of the cursor

" Tabs and indent
set tabstop=4           " Number of visual spaces per TAB
set softtabstop=4       " Number of spaces in tab when editing
set expandtab           " Tabs are spaces i.e. use spaces instead of tabs    
set smarttab            " Inserts as many spaces as needed to tab
set shiftwidth=4
set smartindent         " Do smart autoindenting when starting a new line
set autoindent          " Copy the indent when starting a new line

" Search
set ignorecase          " Ignore case in search patterns
set smartcase           " Override the 'ignorecase' if search contains an uppercase characters

""" REMAPS

" Change the leader key from "\" to space (";" and "," are also popular)
let mapleader=" "

" Reload config
nnoremap <silent> <leader>r :source $MYVIMRC<cr>
nnoremap <leader><CR> :so ~/.config/nvim/init.vim<cr>
"  nnoremap <silent> <leader><leader> :source $MYVIMRC<cr>
" Edit THIS configuration file: (e)dit (c)onfiguration
nnoremap <silent> <leader>ec :edit $MYVIMRC<CR>

" Use two semicolons ;; for escape
" ref: http://vim.wikia.com/wiki/Avoid_the_escape_key
:imap ;; <Esc>
:imap ii <Esc>
:imap jk <Esc>

""" Shortcuts common in other editors (save, quit, copy, paste, undo, redo, etc)

" Save with Ctrl+S
map <C-s> :update<CR>
map! <C-s> <esc>:update<CR><esc>i

" Quit without saving with Ctrl+Q
nnoremap <C-q> :q<CR>
command QQ :q!

" Select all with Ctrl+A
map <silent> <C-a> <esc>ggVG<CR>

" System copy-paste
vnoremap <silent> <C-x> "+x
vnoremap <silent> <C-c> "+y
map      <silent> <C-v> "+gP
map!     <silent> <C-v> <esc>

" Undo and redo with Ctrl+Z/Ctrl+Y
map <silent> <C-y> <C-r>
map! <silent> <C-y> <esc><C-r>i
map <silent> <C-z> u
map! <silent> <C-z> <esc>ui

nnoremap <leader>x :!chmod +x %<CR>

""" Lines

" Insert a newline without entering in insert mode
nmap <silent> <leader>o o<Esc>k " new line below 
nmap <silent> <leader>O O<Esc>j " new line above

" Move lines / swap lines with Ctrl+J/K
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Move lines / swap lines with Alt+J/K
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=v

""" Panes

" Split screen
map <leader>d :vs<CR>
map <leader>D :split<CR>
nnoremap <leader>pv :Vex<CR>

" Pane navigation
nmap <silent> <C-Up> :wincmd k<CR>
nmap <silent> <C-Down> :wincmd j<CR>
nmap <silent> <C-Left> :wincmd h<CR>
nmap <silent> <C-Right> :wincmd l<CR>

nmap <silent> <leader>k :wincmd k<CR>
nmap <silent> <leader>j :wincmd j<CR>

nmap <silent> <leader>h :wincmd h<CR>
nmap <silent> <leader>l :wincmd l<CR>

""" Tabs

" Open tabs
map <silent> <C-t> :tabnew<CR>
map! <silent> <C-t> <Esc>:tabnew<CR>

" Close tabs
map <C-w> :tabc<CR>
map! <C-w> <Esc>:tabc<CR>

" Navigate tabs
map <C-Tab> :tabnext<CR>
map <C-S-Tab> :tabprev<CR>
map! <C-Tab> <Esc>:tabnext<CR>
map! <C-S-Tab> <Esc>:tabprev<CR>

" Switch to specific tab numbers with number
nmap <silent> <leader>1 :tabn 1<CR>
nmap <silent> <leader>2 :tabn 2<CR>
nmap <silent> <leader>3 :tabn 3<CR>
nmap <silent> <leader>4 :tabn 4<CR>
nmap <silent> <leader>5 :tabn 5<CR>
nmap <silent> <leader>6 :tabn 6<CR>
nmap <silent> <leader>7 :tabn 7<CR>
nmap <silent> <leader>8 :tabn 8<CR>

" Leader-9 goes to the last tab
nmap <leader>9 :tablast<CR>

" Errors (quickfix) and issues
nnoremap <leader>] :cnext<CR>
nnoremap <leader>[ :cprev<CR>
"  nnoremap <leader>cc :cclose<CR>
nnoremap <leader>} :lnext<CR>
nnoremap <leader>{ :lprev<CR>
"  nnoremap <leader>cc :lclose<CR>
nnoremap <leader>cc :cclose :lclose<CR>

fun! TrimWhiteSpace()
    " Strip trailing whitespace from all lines in a file
    " ref: https://vi.stackexchange.com/questions/454/whats-the-simplest-way-to-strip-trailing-whitespace-from-all-lines-in-a-file/456#456
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

