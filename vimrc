" #########################
" Vundle
" #########################

" Vundle set up
" set nocompatible
" filetype off

call plug#begin('~/.vim/plugged')

" Syntastic
Plug 'vim-syntastic/syntastic'
" NERD tree
Plug 'scrooloose/nerdtree'
" Nvim-R
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'jalvesaq/Nvim-R'
Plug 'gaalcaras/ncm-R'
" vim-go
" Plug 'fatih/vim-go'
" Super Tab
" Perform all your vim insert mode completions with Tab
" Plug 'ervandew/supertab'
" Tagbar
" Vim plugin that displays tags in a window
Plug 'majutsushi/tagbar'
" CamelCaseMotion
Plug 'bkad/CamelCaseMotion'
" bugexplorer (it needs vim patches 1261 and 1264)
Plug 'jlanzarotta/bufexplorer'
" YankRing
" Maintains a history of previous yanks, changes and deletes
" Plug 'vim-scripts/YankRing.vim'
" vim-airline for status/tabline
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" vim markdown for markdown syntax
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
" Vim Markdown runtime files
" Plug 'tpope/vim-markdown'
" fugitive for Git integration
Plug 'tpope/vim-fugitive'
" commentary
Plug 'tpope/vim-commentary'
" surround
Plug 'tpope/vim-surround'
" Vim Slime
Plug 'jpalardy/vim-slime'
" SLIME
Plug 'epeli/slimux'
" gruvbox
Plug 'morhetz/gruvbox'
" increment
Plug 'triglav/vim-visual-increment'
" incsearch
Plug 'haya14busa/incsearch.vim'
" vim-snipe
Plug 'yangmillstheory/vim-snipe'
" vim-pandoc
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
" vim-rmarkdown
Plug 'vim-pandoc/vim-rmarkdown'
" vim-signify
Plug 'mhinz/vim-signify'
" grammar check
Plug 'rhysd/vim-grammarous'
" lsp
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
" Deoplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" for languageserver
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
" (Optional) Multi-entry selection UI.
Plug 'junegunn/fzf'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
call plug#end()

filetype plugin indent on

if $WORK == "true"
  source ~/.vimrc.google
endif

" #########################
" NCM2
" #########################
" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

" IMPORTANT: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect

" #########################
" languageserver
" #########################
" Required for operations modifying multiple buffers like rename.
" set hidden

" let g:LanguageClient_serverCommands = {
"     \ 'r': ['r', '--slave', '-e', 'languageserver::run()'],
"     \ }

" nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
" nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
" nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
" nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
" nnoremap <silent> fmt :call LanguageClient_textDocument_formatting()<CR>

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
let g:syntastic_cpp_compiler_options = ' -std=c++11'

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
set termguicolors
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
tmap jk <esc>

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

let R_assign = 0
let R_cmd='R0'

vmap <Space> <Plug>RDSendSelection
nmap <Space> <Plug>RDSendLine

function! SendInvisibleV()
    let Rsource = g:rplugin_tmpdir . "/Rsource-" . getpid()
    call writefile(["invisible("] + getline("'<", "'>") + [")"], Rsource)
    call g:SendCmdToR('source("' . Rsource . '")')
    call cursor(line("'>"), 0)
    call GoDown()
endfunction
vmap <silent> <LocalLeader>ri <Esc>:call SendInvisibleV()<CR>

autocmd BufReadPre *.r let $R_HOME='/usr/local/lib/R'
autocmd BufReadPre *.r let R_path='/usr/local/bin'
autocmd BufReadPre *.r let R_app='rtichoke'
autocmd BufReadPre *.r let R_cmd='r'
autocmd BufReadPre *.r let R_hl_term = 0
autocmd BufReadPre *.r let R_bracketed_paste = 1
autocmd BufReadPre *.R let R_app='R'

" Emulate Tmux ^az
function ZoomWindow()
    let cpos = getpos(".")
    tabnew %
    redraw
    call cursor(cpos[1], cpos[2])
    normal! zz
endfunction
nmap gz :call ZoomWindow()<CR>

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
" vim-markdown
" #########################
" Enable TOC autofit
let g:vim_markdown_toc_autofit = 1

" #########################
" youcompleteme
" #########################
" Turn off ycm for R
let g:ycm_filetype_blacklist = {'R': 1, 'r': 1}

" #########################
" ctags
" #########################
let g:tagbar_type_r = {
  \ 'ctagstype' : 'r',
  \ 'kinds'     : [
      \ 'f:Functions',
      \ 'g:GlobalVariables',
      \ 'v:FunctionVariables',
  \ ]
  \ }

" #########################
" Tagbar
" #########################
" Turns on the TagBar
nnoremap <leader>tb :TagbarToggle<CR>
let g:tagbar_left = 1

" #########################
" others
" #########################

" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
if !has('nvim')
  set viminfo='10,\"100,:20,%,n~/.viminfo
endif
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
