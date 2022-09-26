" Shared Neovim and Vim config

let is_vim = !has('nvim')
let is_nvim = has('nvim')

if is_nvim
    let $BASE = stdpath('config')
else
    let $BASE = '$HOME/.vim'
endif

""" PLUGINS
" Specify a directory for plugins
call plug#begin($BASE.'/plugged')

    " Navigation - have a folder structure and to view or jump to different files
    Plug 'preservim/nerdtree'

    " Themes / color scheme
    Plug 'joshdick/onedark.vim'

    " Git
    Plug 'airblade/vim-gitgutter'

    " ESlint
    Plug 'w0rp/ale'
    
    if is_nvim
        " Nvim-only plugins
        
        " Better syntax highlighting and syntax support for languages
        Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

        " Telescope - fuzzy find files
        Plug 'nvim-lua/plenary.nvim' " required depencency for Telescope
        Plug 'nvim-telescope/telescope.nvim'
    else
        " Vim-only plugins

        " Fuzzy find files
        Plug 'ctrlpvim/ctrlp.vim'
    endif
" Initialize plugin system
call plug#end()

""" THEME AND COLORS

colorscheme onedark

" Load other configuration files
source $BASE/common.vim
source $BASE/plugins.vim

" Language specific settings
source $BASE/languages/javascript.vim
