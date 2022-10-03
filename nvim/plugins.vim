" Neovim and Vim plug-in configuration used in both

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

" Themes and colors
colorscheme onedark

""" Nerd tree 
" Open with Ctrl+R
nnoremap <C-e> :NERDTreeToggle<CR>

""" Telescope
" Find files using Telescope command-line sugar
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fd <cmd>Telescope git_files<cr>

""" fzf
" Git files
nnoremap <C-p> :GFiles<cr> 
nnoremap <leager>pf :Files<cr> " Project files

""" ALE (ESlint)
"  Set ESLint as plugging manager
let g:ale_fixers = {
 \ 'javascript': ['eslint']
 \ }
" Pimp linter symbols
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'
" Fix the file your are working on on save
let g:ale_fix_on_save = 1

""" vim-gitgutter
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)

