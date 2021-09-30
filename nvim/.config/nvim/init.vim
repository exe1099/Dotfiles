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
filetype plugin indent on       " needed for nelstrom/vim-markdown-folding

" auto read when a file is changed from the outside
set autoread

let mapleader = "," " map leader key

" }}}
" VIM User Interface ---------------------------------------------{{{

set colorcolumn=89
let g:markdown_fold_override_foldtext = 0

" keep space between coursor and top/bottom
set so=8

" turn on the wild menu
set wildmenu

" tab autocompletion
set wildmode=longest,list,full

" always show current position
set ruler

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
set t_vb=
set tm=500

" }}}
" Folding --------------------------------------------------------{{{

" add a bit extra margin to the left
set foldcolumn=1

" toggle current fold
nnoremap <A-h> za

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
" Plugins --------------------------------------------------------{{{

" autoinstall vim-plug if not installed already
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plug
call plug#begin('~/.vim/plugged')
" Add plugins here
Plug 'sheerun/vim-polyglot'  " synatx highlighting for different languages
Plug 'vim-airline/vim-airline'  " fancy status bar
Plug 'vim-airline/vim-airline-themes'  " themes for fancy status bar
Plug 'scrooloose/nerdcommenter'  " comment/uncomment plugin
Plug 'exe1099/minimalist_2'  " color-scheme
Plug 'lambdalisue/suda.vim'  " write file with sudo
Plug 'PotatoesMaster/i3-vim-syntax'  " syntax for i3 file
Plug 'tpope/vim-surround'  " add surrounding motions
Plug 'vim-scripts/restore_view.vim'  " remembers cursor position and view (folds etc.)
Plug 'plasticboy/vim-markdown' " markdown stuff, use it mostly for markdown folding
Plug 'vim-scripts/Tabmerge' " for going from tabs to splits
" Plug 'takac/vim-hardtime'  " disable repetetive use of h/j/k/l
call plug#end()


" Options for plugins

" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W w suda://%

" vim-hardtime
" let g:hardtime_default_on = 1

" nerdcommenter
nnoremap <c-b> :call NERDComment(0,"toggle")<CR>
vnoremap <c-b> :call NERDComment(0,"toggle")<CR>
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
let g:NERDCustomDelimiters = { 'cpp': { 'left': '/*','right': '*/' } }
"}}}

" airline
let g:airline_powerline_fonts = 1 " needed for status line
" set noshowmode " hide -- INSERT --
let g:airline_theme='minimalist_2'
" let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
" show buffers if only single tab open
let g:airline#extensions#tabline#show_buffers = 0
" formatting of path + file
let g:airline#extensions#tabline#formatter = 'jsformatter'
" hide open splits per tab
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_tab_nr = 0

" }}}
" Tabs, Windows, Splits, Buffers -----------------------------------------{{{

set splitright
set splitbelow

" resize split with + and -
nnoremap + :vertical resize -5<cr>
nnoremap - :vertical resize +5<cr>

" open split and lets you choose buffer
" nnoremap <C-w>v :ls<cr>:vsp<space>\|<space>b<space>

nnoremap <C-w><C-v> :Tabmerge left<cr>

" simpler switching
map <C-h> <C-w>h
map <C-l> <C-w>l

" remove these mappings, need to get them out of muscle memory
" this doesn't work
nnoremap <C-w>o <cr>
nnoremap <C-w><C-o> <cr>


" a buffer becomes hidden when it is abandoned
set hid


" set wildcharm=<C-z>
" nnoremap <leader>b :buffer <C-z><S-Tab>
" nnoremap <leader>B :vsp b <C-z><S-Tab>
" nnoremap <leader>b :ls<CR>:b<Space>
" nnoremap <leader>B :ls<CR>:vert sb<space>
" nnoremap <PageUp>   :bprevious<CR>
" nnoremap <PageDown> :bnext<CR>
" nnoremap <leader>+ :vertical resize +5<cr>
" nnoremap <leader>- :vertical resize -5<cr>
" nnoremap <leader>o :only<cr>
" smart way to move between windows
" map <C-j> <C-W>j
" map <C-k> <C-W>k
" map <C-h> <C-W>h
" map <C-l> <C-W>l

" close the current buffer
" map <leader>bd :Bclose<cr>:tabclose<cr>gT

" close all the buffers
" map <leader>ba :bufdo bd<cr>

" map <leader>l :bnext<cr>
" map <leader>h :bprevious<cr>

" let 'tl' toggle between this and the last accessed tab
" let g:lasttab = 1
" nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
" au TabLeave * let g:lasttab = tabpagenr()

" opens a new tab with the current buffer's path
" super useful when editing files in the same directory
" map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" switch CWD to the directory of the open buffer
" map <leader>cd :cd %:p:h<cr>:pwd<cr>

" specify the behavior when switching between buffers
" try
" set switchbuf=useopen,usetab,newtab
" set stal=2
" catch
" endtry

" }}}
" Colors and Fonts------------------------------------------------{{{
"
colorscheme minimalist_2

" enable syntax highlighting
syntax enable

" set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" use Unix as the standard file type
set ffs=unix,dos,mac

" use truecolor (rgb) in terminal
set termguicolors

" execute :call GetSyntax() when cursor over text to get highlight settings
function! GetSyntaxID()
    return synID(line('.'), col('.'), 1)
endfunction

function! GetSyntaxParentID()
    return synIDtrans(GetSyntaxID())
endfunction

function! GetSyntax()
    echo synIDattr(GetSyntaxID(), 'name')
    exec "hi ".synIDattr(GetSyntaxParentID(), 'name')
endfunction

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

set wrap linebreak nolist " wrap lines

" :Wrap to make softwrap
command! -nargs=* Wrap set wrap linebreak nolist
set breakindent
set breakindentopt=shift:2"}}}
" Searching ------------------------------------------------------{{{

nnoremap <space> /
nnoremap <c-space> ?

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
" Working with Text ----------------------------------------------{{{

" move a line of text using ALT+[jk]
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi

" delete in black hole register
nnoremap <leader>d "_d
vnoremap <leader>d "_d

" use system clipboard
" + clipboard
" * primary selection ("mouse highlight")
vnoremap <c-C> "*y :let @+=@*<CR>
nnoremap <c-V> "+p
inoremap <c-V> <Esc>"+pa

" execute macros with leader
nnoremap <leader>q @q
noremap <leader>w @w

" }}}
" Working with Code ----------------------------------------------{{{

" strip all trailing whitespaces in the current file
" autocmd BufWritePre * %s/\s\+$//e

" compile markdown file
function! CompileMarkdown()
    execute "w"
    execute "! pandoc -o %:p.pdf %:p"
endfunction
:nmap mc :call CompileMarkdown()<CR><CR>

" }}}
" Spell Checking -------------------------------------------------{{{

" toggle spell checking
map <leader>ss :setlocal spell!<cr>

map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

"}}}
" Movement -------------------------------------------------------{{{

" remap to first non-blank character
map 0 ^

" jump 10 lines up or down/characters left/right
nmap <c-j> <c-d>
nmap <c-k> <c-u>

" insert empty line below/above and stay in normal mode
nmap # o<esc>
nmap ' O<esc>

" move along screen lines, not file lines
nnoremap j gj
nnoremap k gk

" useful mappings for managing tabs
map <c-t> :tabnew<cr>
"map <c-w> :tabclose<cr>

" }}}
" Auto-commands --------------------------------------------------{{{

" source init.vim when writing file (no need to restart;
" only overwrites changes --> doesn't forget setting (e.g. if commenting something out)
autocmd bufwritepost Dotfiles/nvim/.config/nvim/init.vim source %

" reload .Xresources with xrdb after editing
autocmd bufwritepost ~/.Xresources !xrdb %

" reload .Xmodmap after editing
autocmd bufwritepost ~/.Xmodmap !xmodmap %

" recompile and istall simple terminal after changing config
autocmd bufwritepost ~/Gits/st_luke/config.h !sudo -A make -C ~/Gits/st_luke/ install

" deactive error highlighting in markdown-files (avoids --> marked as error)
autocmd bufread *.md :highlight Error guibg=None

" }}}
" Unused Stuff ---------------------------------------------------{{{

" Delete trailing white space on save, useful for some filetypes ;)
" fun! CleanExtraSpaces()
" let save_cursor = getpos(".")
" let old_query = getreg('/')
" silent! %s/\s\+$//e
" call setpos('.', save_cursor)
" call setreg('/', old_query)
" endfun
" if has("autocmd")
" autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee,.vimrc :call CleanExtraSpaces()
" endif

" Returns true if paste mode is enabled
" function! HasPaste()
"     if &paste
"         return 'PASTE MODE  '
"     endif
"     return ''
" endfunction
"
" " Don't close window, when deleting a buffer
" command! Bclose call <SID>BufcloseCloseIt()
" function! <SID>BufcloseCloseIt()
"     let l:currentBufNum = bufnr("%")
"     let l:alternateBufNum = bufnr("#")
"
"     if buflisted(l:alternateBufNum)
"         buffer #
"     else
"         bnext
"     endif
"
"     if bufnr("%") == l:currentBufNum
"         new
"     endif
"
"     if buflisted(l:currentBufNum)
"         execute("bdelete! ".l:currentBufNum)
"     endif
" endfunction
"
" function! CmdLine(str)
"     call feedkeys(":" . a:str)
" endfunction
"
" function! VisualSelection(direction, extra_filter) range
"     let l:saved_reg = @"
"     execute "normal! vgvy"
"
"     let l:pattern = escape(@", "\\/.*'$^~[]")
"     let l:pattern = substitute(l:pattern, "\n$", "", "")
"
"     if a:direction == 'gv'
"         call CmdLine("Ack '" . l:pattern . "' " )
"     elseif a:direction == 'replace'
"         call CmdLine("%s" . '/'. l:pattern . '/')
"     endif
"
"     let @/ = l:pattern
"     let @" = l:saved_reg
" endfunction

" insert empty line below/above and stay in normal mode
" nmap # o<esc>
" nmap ' O<esc>
"
" }}}
" Stuff to remember ----------------------------------------------{{{

" <leader>q             @q (macro?)
" <leader>w             @w (macro?)
" <leader>W             remove trailing whitespaces
" <leader>f/za          toggle fold
" zm                    fold more (z looks like folded paper)
" zr                    reduce fold
" <f8>                  run code and create window
" <f9>                  rerun code and update output
" H/M/L                 move to high/middle/low of screen
" Ctrl+D/U / Ctrl+j/k   move half page down/up
" :call GetSyntax()     print currently applied syntax highlighting to cursor position
" <leader>s             substitute (works in normal and visual mode)
" 
"
"
" }}}
" vim:foldmethod=marker
