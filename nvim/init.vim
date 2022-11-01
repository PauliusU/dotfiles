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

    " fzf - fuzzy find files
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

    " Navigation - have a folder structure and to view or jump to different files
    Plug 'preservim/nerdtree'

    " Themes / color scheme
    Plug 'joshdick/onedark.vim'

    " Git
    Plug 'tpope/vim-fugitive' " Control commits
    Plug 'airblade/vim-gitgutter' " Show a git diff in the sign column

    " ESlint
    Plug 'w0rp/ale'
    
    if is_nvim
        " Nvim-only plugins

        " Better syntax highlighting and syntax support for languages
        Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

        " Telescope - fuzzy find files
        Plug 'nvim-lua/plenary.nvim' " required depencency for Telescope
        Plug 'nvim-telescope/telescope.nvim'

        " Completion
        Plug 'neovim/nvim-lspconfig'
        Plug 'hrsh7th/cmp-nvim-lsp'
        Plug 'hrsh7th/cmp-buffer'
        Plug 'hrsh7th/cmp-path'
        Plug 'hrsh7th/cmp-cmdline'
        Plug 'hrsh7th/nvim-cmp'
        " For vsnip users.
        Plug 'hrsh7th/cmp-vsnip'
        Plug 'hrsh7th/vim-vsnip'
    else
        " Vim-only plugins

        " Fuzzy find files
        Plug 'ctrlpvim/ctrlp.vim'
    endif
" Initialize plugin system
call plug#end()

" Load other configuration files
source $BASE/common.vim
source $BASE/plugins.vim

" Language specific settings
source $BASE/languages/javascript.vim
