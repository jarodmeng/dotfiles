" If there is a master.vimrc file, load it
try
  source $LOCAL_ADMIN_SCRIPTS/master.vimrc
catch
  " No such file? No problem; just ignore it.
endtry

" #########################
" vim-plug
" #########################

call plug#begin('~/.vim/plugged')

" Nvim-R
Plug 'jalvesaq/Nvim-R'
Plug 'jalvesaq/cmp-nvim-r'
" nvim-cmp
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'onsails/lspkind.nvim'
" For vsnip users.
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
" vim-airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" gruvbox
Plug 'morhetz/gruvbox'
" commentary
Plug 'tpope/vim-commentary'
" surround
Plug 'tpope/vim-surround'
" languageserver
" Plug 'REditorSupport/languageserver'
" Plug 'autozimu/LanguageClient-neovim', {
"     \ 'branch': 'next',
"     \ 'do': 'bash install.sh',
"     \ }
" bufferliine
Plug 'nvim-tree/nvim-web-devicons' " Recommended (for coloured icons)
Plug 'akinsho/bufferline.nvim', { 'tag': '*' }
" Tabular
Plug 'godlygeek/tabular'
" Git integration
Plug 'tpope/vim-fugitive'

call plug#end()

" #########################
" vim-airline
" #########################

" air-line
let g:airline_powerline_fonts = 1
let g:airline_theme='bubblegum'

" #########################
" Aesthetics
" #########################

colorscheme gruvbox

" gruvbox dark theme
set background=dark
set termguicolors
let g:gruvbox_contrast_dark = 'hard'
set t_Co=256

syntax enable
hi clear SpellBad
hi SpellBad cterm=underline,bold

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
" Nvim-R
" #########################

autocmd BufNewFile *.R 0r ~/.vim/skeletons/r-blank.R

" Execute command when a .R file is written
autocmd BufWritePre *.R,*.r,*.qmd,*.rmd,*.Qmd,*.Rmd :%s/%>%/|>/ge | write

let R_assign = 0

nmap <silent> <LocalLeader>cn :call RAction("colnames")<CR>
nmap <silent> <LocalLeader>tl :call RAction("tally")<CR>
nmap <silent> <LocalLeader>sq :call RAction("show_query")<CR>
nmap <silent> <LocalLeader>do :call RAction("debugonce")<CR>
nmap <silent> <LocalLeader>ph :call RAction("print", ", n = 100")<CR>
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

lua <<EOF
  local ok, lspkind = pcall(require, "lspkind")
  if not ok then
    return
  end

  -- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup {
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "vsnip" },
    }, {
      { name = "path" },
      { name = "buffer", keyword_length = 5 },
    }, {
      { name = 'cmp_nvim_r' },
    }),
    formatting = {
      format = lspkind.cmp_format {
        with_text = true,
        menu = {
          buffer = "[buf]",
          nvim_lsp = "[LSP]",
          path = "[path]",
          vsnip = "[snip]",
          cmp_nvim_r = "[NvimR]",
        },
      },
    },
  }

  require("bufferline").setup{}
EOF

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
if !has('nvim')
  set viminfo='10,\"100,:20,%,n~/.viminfo
endif
" Restore cursor position
:au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

" #########################
" languageserver
" #########################
" let g:LanguageClient_serverCommands = {
"     \ 'r': ['R', '--slave', '-e', 'languageserver::run()'],
"     \ }
