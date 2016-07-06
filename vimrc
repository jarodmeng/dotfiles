" #########################
" Vundle
" #########################

" Vundle set up
set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" vim-airline for status/tabline
Plugin 'bling/vim-airline'

" vim markdown for markdown syntax
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'

" fugitive for Git integration
Plugin 'tpope/vim-fugitive'

" Nvim-R
Plugin 'jalvesaq/Nvim-R'

" Vim Slime
Plugin 'jpalardy/vim-slime'

" all plugins must be added BEFORE the following line
call vundle#end()
filetype plugin indent on
" brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put non-Plugin stuff after this line

" #########################
" vim-airline
" #########################

" make status bar always appear
set laststatus=2

" use powerline fonts
let g:airline_powerline_fonts = 1

" #########################
" Aesthetics
" #########################

" solarized dark theme
syntax enable
set background=dark
colorscheme solarized

" show line number
set nu

" highlight the 80th column
set colorcolumn=80

" highlight search matches
set incsearch

" #########################
" Mappings
" #########################

" easy editing vimrc
nnoremap <leader>ev :edit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" map jk to ESC in insert mode
imap jk <esc>

" mapping settings
let mapleader=","
" remap comma key to back slash
nmap \ ,

" Copy into the end of line
nmap Y y$
" Copy until the end of line into system clipboard
nmap <C-Y> "+y$
" Copy an entire line and paste before the current line
nmap _ ggY``P
" Copy to clipboard
vmap <C-c> "+y

" Map ctrl+Del to delete until the end of line in insert mode
imap <C-Del> <C-\><C-O>D

" Keep the visual block intact after indenting
vmap > >gv
vmap < <gv

" split pane settings
set splitbelow
set splitright
nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
nmap <C-L> <C-W><C-L>
nmap <C-H> <C-W><C-H>

" invisible character mapping
nmap <leader>l :set list!<CR>
set listchars=tab:▸\ ,eol:¬

" edit mappings
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

" #########################
" Tab/indentation
" #########################

set tabstop=2
set softtabstop=2
set expandtab
set shiftwidth=2

" #########################
" Tab completion
" #########################

" enable a menu at the bottom
set wildmenu

" first tab = command will be completed to the longest common command
" second tab = show all completion matches
set wildmode=longest,list,full

" #########################
" vim markdown
" #########################

" disable folding
let g:vim_markdown_folding_disabled=1

" #########################
" stripping trailing whitespaces
" #########################

function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

nmap <silent> <F5> :call <SID>StripTrailingWhitespaces()<CR>

" #########################
" others
" #########################

" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo
" Restore cursor position
:au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

" F2 toggles paste mode and insert mode
set pastetoggle=<F2>

" maximum number of tabs
set tabpagemax=100

" use par to format
set formatprg=par\ -w80
