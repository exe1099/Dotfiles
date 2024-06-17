"__     _____ __  __ ____   ____
"\ \   / /_ _|  \/  |  _ \ / ___|
" \ \ / / | || |\/| | |_) | |
"  \ V /  | || |  | |  _ <| |___
"   \_/  |___|_|  |_|_| \_\\____|
"

" General --------------------------------------------------------{{{

set timeoutlen=1000            " time to wait for next keypress in combos

" turn backup off, since most stuff is in SVN, git et.c anyway...
" set nobackup
" set nowb
set noswapfile

set mouse=a                    " use mouse to switch between panels + scroll
set incsearch                  " show search matches as you type
set nocompatible
set number                     " Show current line number
set relativenumber             " Show relative line numbers
set autoindent
set laststatus=2
set conceallevel=2             " show _italic_ as italic (e.g. in markdown)

" highlight line if in insert mode
autocmd InsertEnter * set cul
autocmd InsertLeave * set nocul

" how many lines of history VIM has to remember
set history=500

" enable filetype plugins
filetype plugin on
filetype indent on

" auto read when a file is changed from the outside
set autoread


map <SPACE> <leader>
" }}}
" VIM User Interface ---------------------------------------------{{{

set colorcolumn=89

" keep space between coursor and top/bottom
set so=8

" turn on the wild menu
set wildmenu

" tab autocompletion
set wildmode=longest,list,full

" always show current position
" set ruler

" height of the command bar
set cmdheight=1

" configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" don't redraw while executing macros (good performance config)
set lazyredraw

" for regular expressions turn magic on
set magic

" show matching brackets when text indicator is over them
set showmatch

" how many tenths of a second to blink when matching brackets
set mat=2

" no annoying sound on errors
set noerrorbells
set novisualbell
set tm=500

" }}}
" Folding --------------------------------------------------------{{{

" custom fold text
function! MyFoldText() " {{{
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let endoflinecount = 85 - len(line) - len(foldedlinecount)
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount) - endoflinecount
    " return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
    return '=> ' . line . ' ' . repeat("-",endoflinecount) . foldedlinecount . ' ' . repeat(' ',fillcharcount)
endfunction " }}}
set foldtext=MyFoldText()

" }}}
" Text, Wrap, Indent ---------------------------------------------{{{

" use spaces instead of tabs
set expandtab

" be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" linebreak on 500 characters
set lbr
set tw=500

set ai " auto indent
set si " smart indent

" wrap lines and properly indent them
set wrap linebreak nolist
set breakindent
set breakindentopt=shift:2"

" }}}
" Searching ------------------------------------------------------{{{

" substitue
nnoremap <leader>s :%s/
vnoremap <leader>s y:%s/<C-R>"/

" disable highlight when pressed
nnoremap <CR> :nohlsearch<cr>

" ignore case when searching
" if it contains upper letter, be case sensitive
set ignorecase
set smartcase

" highlight search results
set hlsearch

" makes search act like search in modern browsers
set incsearch

" }}}
" Plugins --------------------------------------------------------{{{

" autoinstall vim-plug if not installed already
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plug
" :PlugUpdate
" :PlugClean
" :PlugInstall
call plug#begin('~/.vim/plugged')
" Add plugins here
Plug 'NLKNguyen/papercolor-theme'
Plug 'scrooloose/nerdcommenter'  " comment/uncomment plugin
Plug 'lambdalisue/suda.vim'  " write file with sudo
Plug 'PotatoesMaster/i3-vim-syntax'  " syntax for i3 file
Plug 'vim-scripts/restore_view.vim'  " remembers cursor position and view (folds etc.)
Plug 'vim-airline/vim-airline'  " fancy status bar
Plug 'vim-airline/vim-airline-themes'  " themes for fancy status bar
Plug 'rebelot/kanagawa.nvim'
Plug 'rktjmp/lush.nvim'
Plug 'rockyzhang24/arctic.nvim', { 'branch': 'v2' }
call plug#end()

" Options for plugins

" theme
colorscheme arctic

" airline
let g:airline_powerline_fonts = 1 " needed for status line
let g:airline_theme='deus'

" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W w suda://%

" nerdcommenter
nnoremap <c-b> :call nerdcommenter#Comment(0,"toggle")<CR>
vnoremap <c-b> :call nerdcommenter#Comment(0,"toggle")<CR>
" add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" custom formats
" (get filetype of file with: :set filetype?
" let g:NERDCustomDelimiters = { 'cpp': { 'left': '/*','right': '*/' } }
let g:NERDCustomDelimiters = { 
    \ 'cpp': { 'left': '//'},
    \ 'c':  { 'left': '//'},
    \ 'cc': { 'left': '//'},
    \}

" }}}
" Working with Text ----------------------------------------------{{{

" delete in black hole register
nnoremap <leader>d "_dd
vnoremap <leader>d "_d

" use system clipboard always
set clipboard=unnamedplus
" + clipboard
" * primary selection ("mouse highlight")
" using two different clipboards doesn't work properly wit VSCode

" }}}
" vim:foldmethod=marker
