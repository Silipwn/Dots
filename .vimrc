" Finis coronat opus; Run at your own peril @silipwn;
" File              : .vimrc
" License           : BSD-3-Clause
" Author            : silipwn <(contact at as-hw.in)>
" Date              : 2019-09-24T00:00:00+0530
" Last-Modified     : 2021-07-19T17:43:05+0530
" Changelog :
"   Mon Jul 19 05:40:38 PM IST 2021 : Add support for misc things
" 
set nocompatible

syntax enable                  " Enable syntax highlighting.

set autoindent             " Indent according to previous line.
set expandtab              " Use spaces instead of tabs.
set softtabstop =4         " Tab key indents by 4 spaces.
set shiftwidth  =4         " >> indents by 4 spaces.
set shiftround             " >> indents to next multiple of 'shiftwidth'.

set backspace   =indent,eol,start  " Make backspace work as you would expect.
set hidden                 " Switch between buffers without having to save first.
set laststatus  =2         " Always show statusline.
set display     =lastline  " Show as much as possible of the last line.

set showmode               " Show current mode in command-line.
set showcmd                " Show already typed keys when more are expected.

set incsearch              " Highlight while searching with / or ?.
set hlsearch               " Keep matches highlighted.

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

set ttyfast                " Faster redrawing.
set lazyredraw             " Only redraw when necessary.

set splitbelow             " Open new windows below the current window.
set splitright             " Open new windows right of the current window.

set cursorline             " Find the current line quickly.
set wrapscan               " Searches wrap around end-of-file.
set report      =0         " Always report changed lines.
set synmaxcol   =200       " Only highlight the first 200 columns.


set list                   " Show non-printable characters.

set nu

" Turn on the Wild menu
set wildmenu
" Show partial commands in the last line of the screen
set showcmd
" A buffer becomes hidden when it is abandoned
set hid

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
set nocompatible

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
if has('filetype')
  filetype indent plugin on
endif

" Enable syntax highlighting
if has('syntax')
  syntax on
endif

" Ruler for editor
execute "set colorcolumn=80," . join(range(120,150), ",")

highlight ColorColumn ctermbg=235 guibg=#2c2d27

set numberwidth=3
set cpoptions+=n
if has('multi_byte') && &encoding ==# 'utf-8'
  let &listchars = 'tab:▸ ,extends:❯,precedes:❮,nbsp:±'
else
  let &listchars = 'tab:> ,extends:>,precedes:<,nbsp:.'
endif

" The fish shell is not very compatible to other shells and unexpectedly
" breaks things that use 'shell'.
if &shell =~# 'fish$'
  set shell=/bin/bash
endif

" Update time from emacs
autocmd! BufWritePre * :call s:timestamp()
" to update timestamp when saving if its in the first 20 lines of a file
function! s:timestamp()
    let pat = '\(\(Last\)\?\s*\([Cc]hanged\?\|[Mm]odified\|[Uu]pdated\?\)\s*:\s*\).*'
    let rep = '\1' . strftime("%FT%T%z")
    call s:subst(1, 20, pat, rep)
endfunction
" subst taken from timestamp.vim
" {{{ subst( start, end, pat, rep): substitute on range start - end.
function! s:subst(start, end, pat, rep)
    let lineno = a:start
    while lineno <= a:end
	let curline = getline(lineno)
	if match(curline, a:pat) != -1
	    let newline = substitute( curline, a:pat, a:rep, '' )
	    if( newline != curline )
		" Only substitute if we made a change
		"silent! undojoin
		keepjumps call setline(lineno, newline)
	    endif
	endif
	let lineno = lineno + 1
    endwhile
endfunction
" }}}

"" 2021-06-18T05:55:11+0000 : Added macro for adding time : silipwn
iab cmtime <c-r>=strftime("%FT%T%z: silipwn: <why>")<cr>


""" Add undo magic
"" 2021-07-19T13:11:31+0530: silipwn: Undo
set undofile                " Save undos after file closes
set undodir=$HOME/.vim/undo " where to save undo histories
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo

" Add support for copying to clipboard
set clipboard=unnamedplus

" 2021-07-19T12:56:02+0530: silipwn: Port things to plugged
" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif
" Call plugin
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/syntastic'
Plug 'alpertuna/vim-header'
Plug 'rafaqz/ranger.vim'
Plug 'ayu-theme/ayu-vim'
Plug 'junegunn/fzf.vim'
Plug 'sheerun/vim-polyglot'
Plug 'axvr/org.vim'

call plug#end()

"Customization 4 Plugins
let g:lightline = {
      \ 'colorscheme': 'ayu_dark',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }
let g:header_field_author = 'silipwn'
let g:header_field_author_email = '(contact at as-hw.in)'
let g:header_field_copyright = 'Finis coronat opus; Run at your own peril @silipwn;' 
let g:header_auto_add_header = 0
let g:header_field_modified_by = 0
let g:header_field_license_id = 'BSD-3-Clause'
let g:header_field_timestamp_format = '%FT%T%z'


"Leader magic
noremap <SPACE> <Nop>
let mapleader=" "
" Close the current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT

" Close all the buffers
map <leader>ba :bufdo bd<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 
map <leader>wh :wincmd h<CR>
map <leader>wj :wincmd j<CR>
map <leader>wk :wincmd k<CR>
map <leader>wl :wincmd l<CR>

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <C-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=
" Fast saving
nmap <leader>w :w!<cr>
" Fugitive
map <leader>gg :G<CR>
" Ranger
map <leader>rr :RangerEdit<cr>
map <leader>rv :RangerVSplit<cr>
map <leader>rs :RangerSplit<cr>
map <leader>rt :RangerTab<cr>
map <leader>ri :RangerInsert<cr>
map <leader>ra :RangerAppend<cr>
map <leader>rc :set operatorfunc=RangerChangeOperator<cr>g@
map <leader>rd :RangerCD<cr>
map <leader>rld :RangerLCD<cr>

" fzf.vim
map <leader>ff :Files<cr>
map <leader>fr :History<cr>
map <leader>fg :GFiles<cr>
map <leader>bb :Buffers<cr>
map <leader>ss :BLines<cr>
map <leader>sl :Lines<cr>
map <leader>sd :Rg<cr>

" Reload vimrc
map <leader>rr :source $HOME/.vimrc<cr>

" Clear highlights
map <leader>// :noh<CR>
" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Colors
set termguicolors     " enable true colors support
let ayucolor="dark"   " for dark version of theme
set background="dark"
colorscheme ayu
