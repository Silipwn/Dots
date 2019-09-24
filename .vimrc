" File              : .vimrc
" Author            : silipwn <c2lsaXB3bmVkQGdtYWlsLmNvbQ==>
" Date              : 24.09.2019
" Last Modified Date: 24.09.2019
" Last Modified By  : silipwn <c2lsaXB3bmVkQGdtYWlsLmNvbQ==>
set nocompatible

filetype off  		   " Load plugins according to detected filetype.
syntax on                  " Enable syntax highlighting.

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
set numberwidth=3
set cpoptions+=n
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
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



"Vundle Stuff
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
"NERDTree File 
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'xolox/vim-notes'
Plugin 'xolox/vim-misc'
Plugin 'scrooloose/syntastic'
Plugin 'honza/vim-snippets'
Plugin 'davidhalter/jedi-vim'
Bundle 'zhaocai/GoldenView.Vim'
Plugin 'junegunn/goyo.vim'
Plugin 'alpertuna/vim-header'

"Customization 4 Plugins
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'default'
map <C-f> :NERDTreeToggle<CR>
let g:airline_theme='wombat'
map <C-w> :tabclose<CR>
map <C-g> :tabnew<CR>
let g:deoplete#enable_at_startup = 1
let g:header_field_author = 'silipwn'
let g:header_field_author_email = 'c2lsaXB3bmVkQGdtYWlsLmNvbQ=='
map <C-h> :AddHeader<CR>

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


