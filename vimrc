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

" Syntastic
Plugin 'vim-syntastic/syntastic'

" NERD tree
Plugin 'scrooloose/nerdtree'

" Nvim-R
Plugin 'jalvesaq/Nvim-R'

" vim-go
" Plugin 'fatih/vim-go'

" Super Tab
" Perform all your vim insert mode completions with Tab
" Plugin 'ervandew/supertab'

" Tagbar
" Vim plugin that displays tags in a window
" Plugin 'majutsushi/tagbar'

" CamelCaseMotion
Plugin 'bkad/CamelCaseMotion'

" bugexplorer (it needs vim patches 1261 and 1264)
Plugin 'jlanzarotta/bufexplorer'

" YankRing
" Maintains a history of previous yanks, changes and deletes
" Plugin 'vim-scripts/YankRing.vim'

" vim-airline for status/tabline
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" vim markdown for markdown syntax
Plugin 'godlygeek/tabular'
" Plugin 'plasticboy/vim-markdown'

" Vim Markdown runtime files
" Plugin 'tpope/vim-markdown'

" fugitive for Git integration
Plugin 'tpope/vim-fugitive'

" commentary
Plugin 'tpope/vim-commentary'

" surround
Plugin 'tpope/vim-surround'

" Vim Slime
Plugin 'jpalardy/vim-slime'

" SLIME
Plugin 'epeli/slimux'

" gruvbox
Plugin 'morhetz/gruvbox'

" increment
Plugin 'triglav/vim-visual-increment'

" incsearch
Plugin 'haya14busa/incsearch.vim'

" vim-snipe
Plugin 'yangmillstheory/vim-snipe'

" vim-pandoc
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'vim-pandoc/vim-pandoc-syntax'

" vim-rmarkdown
Plugin 'vim-pandoc/vim-rmarkdown'

" vim-signify
Plugin 'mhinz/vim-signify'

" grammar check
Plugin 'rhysd/vim-grammarous'

" for languageserver
Plugin 'prabirshrestha/async.vim'
Plugin 'prabirshrestha/vim-lsp'

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

if $WORK == "true"
  source ~/.vimrc.google
endif

" #########################
" languageserver
" #########################
au User lsp_setup call lsp#register_server({
    \ 'name': 'R Language Server',
    \ 'cmd': {server_info->[
    \   'R', '--quiet', '--slave', '-e', 'languageserver::run()']},
    \ 'whitelist': ['r'],
    \})

nnoremap gd :LspDefinition<CR>
nnoremap gr :LspReferences<CR>
nnoremap gh :LspHover<CR>
autocmd FileType r,rmd setlocal omnifunc=lsp#complete
autocmd FileType r,rmd setlocal completeopt=menuone,preview,noselect
let g:lsp_async_completion = 1

" #########################
" syntastic
" #########################
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" #########################
" vim-airline
" #########################

" make status bar always appear
set laststatus=2

" air-line
let g:airline_powerline_fonts = 1

" tabline
let g:airline#extensions#tabline#enabled = 1

" #########################
" vim-snipe
" #########################
map <leader><leader>f <Plug>(snipe-f)

" #########################
" Aesthetics
" #########################

" gruvbox dark theme
syntax enable
set background=dark
" let g:gruvbox_italic=1
" set termguicolors
let g:gruvbox_contrast_dark = 'hard'
colorscheme gruvbox
hi clear SpellBad
hi SpellBad cterm=underline,bold
set t_Co=256

" show line number
set number

" highlight the 80th column
set colorcolumn=80

" highlight search matches
set incsearch

" formatoptions to disable auto comment headers
au FileType * set fo-=c fo-=r fo-=o

" hidden to allow multiple unsaved buffers
set hidden

" backspace to allow using backspace button
set backspace=indent,eol,start

" #########################
" Mappings
" #########################

" easy editing vimrc
nnoremap <leader>ov :edit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" spell
nmap <silent> <leader>s :set spell!<CR>

" mapping settings
let mapleader=","
let maplocalleader=";"
" remap comma key to back slash
nmap \ ,

" map jk to ESC in insert mode
imap jk <esc>

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

" how many columns a tab counts for
set tabstop=2
" tab inserts spaces
set expandtab
" how many columns when Tab in insert mode
set softtabstop=2
" how many columns text is indented
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
" let g:vim_markdown_folding_disabled=1

" #########################
" Nvim-R
" #########################

vmap <Space> <Plug>RDSendSelection
nmap <Space> <Plug>RDSendLine
let R_in_buffer = 0
let R_applescript = 0
let R_tmux_split = 1
" let R_vsplit = 1
let R_assign = 0

function! SendInvisibleV()
    let Rsource = g:rplugin_tmpdir . "/Rsource-" . getpid()
    call writefile(["invisible("] + getline("'<", "'>") + [")"], Rsource)
    call g:SendCmdToR('source("' . Rsource . '")')
    call cursor(line("'>"), 0)
    call GoDown()
endfunction
vmap <silent> <LocalLeader>ri <Esc>:call SendInvisibleV()<CR>

autocmd BufReadPre *.rg.R let R_path='/usr/bin'
autocmd BufReadPre *.rg.R let R_app='R'
autocmd BufReadPre *.rg.R let R_cmd='R'

" #########################
" vim-slime
" #########################

let g:slime_target = "tmux"
let g:slime_paste_file = "$HOME/.slime_paste"

" #########################
" CamelCaseMotion
" #########################

call camelcasemotion#CreateMotionMappings('<leader>')

" #########################
" bufexplorer
" #########################

nnoremap <silent> <F11> :BufExplorer<CR>
nnoremap <silent> <s-F11> :ToggleBufExplorer<CR>
nnoremap <silent> <m-F11> :BufExplorerHorizontalSplit<CR>
nnoremap <silent> <c-F11> :BufExplorerVerticalSplit<CR>

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
" vimdiff
" #########################

map <silent> <leader>1 :diffget 1<CR> :diffupdate<CR>
map <silent> <leader>2 :diffget 2<CR> :diffupdate<CR>
map <silent> <leader>3 :diffget 3<CR> :diffupdate<CR>

" #########################
" vim-go
" #########################
" let g:go_highlight_functions = 1
" let g:go_highlight_methods = 1
" let g:go_highlight_fields = 1
" let g:go_highlight_types = 1
" let g:go_highlight_operators = 1
" let g:go_highlight_build_constraints = 1
" let g:go_fmt_command = "goimports"

" #########################
" incsearch.vim
" #########################
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" #########################
" vim-pandoc
" #########################
" Disable folding module
let g:pandoc#modules#disabled = ["folding"]

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

" Auto-save folds state
" augroup AutoSaveFolds
"   autocmd!
"   autocmd BufWinLeave ?* mkview
"   autocmd BufWinEnter ?* silent loadview
" augroup END
