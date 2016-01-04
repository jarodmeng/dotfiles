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

" vim-airline configuration
" make status bar always appear
set laststatus=2

" aesthetics settings
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

" mappings
" map jk to ESC in insert mode
imap jk <esc>

" tab/indentation settings
set ts=8 sts=8 sw=8 expandtab

" tab completion settings
" enable a menu at the bottom
set wildmenu
" first tab = command will be completed to the longest common command
" second tab = show all completion matches
set wildmode=longest,list

" mapping settings
let mapleader=","
" remap comma key to back slash
nmap \ ,

" copy settings
" Y copies until the end of line
nmap Y y$
" Ctrl-y copies until the end of line into system clipboard
nmap <C-y> "+y$
" Ctrl-c copy into system clipboard
vmap <C-c> "+y

" invisible character mapping
nmap <leader>l :set list!<CR>
set listchars=tab:▸\ ,eol:¬

" edit mappings
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

" Ex command history settings
set history=200

" Enable matchit
runtime macros/matchit.vim

" vim markdown settings
" disable folding
let g:vim_markdown_folding_disabled=1

" stripping trailing whitespaces
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
