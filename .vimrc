" Finis coronat opus; Run at your own PERIL @SILipwn;
" File              : .vimrc
" License           : BSD-3-Clause
" Author            : silipwn <(contact at as-hw.in)>
" Date              : 2019-09-24T00:00:00+0530
" Last-Modified     : 2021-09-13T15:42:53-0400
" Changelog :
"   Mon Jul 19 05:40:38 PM IST 2021 : Add support for misc things
"   Tue Jul 20 06:16:24 PM IST 2021 : Add ALE/COC ; Disabled by default ;)
"   Wed Jul 21 01:44:37 PM IST 2021 : Add fix for kitty
"   2021-09-07T23:26:09-0400 : Remove ranger, use nerdtree
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
iab timest <c-r>=strftime("%c: silipwn: <why>")<cr>

"" TODO 2021-08-04T10:21:49+0530: silipwn: Header

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
" 2021-08-03T09:24:38+0530: silipwn: Add nice looks
"eol:↲ : Eww, pretty in the face
set showbreak=↪\ 
set listchars=tab:│·,trail:·,nbsp:␣,extends:›,precedes:‹
" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif
" Call plugin
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-commentary'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/syntastic'
Plug 'alpertuna/vim-header'
Plug 'whatyouhide/vim-gotham'
Plug 'junegunn/fzf.vim'
Plug 'sheerun/vim-polyglot'
Plug 'dense-analysis/ale'
Plug 'axvr/org.vim', { 'for': 'org' }
Plug 'neoclide/coc.nvim', {'branch': 'release'} 
Plug 'tpope/vim-fugitive', { 'on': ['Git','Gdiffsplit'] }
Plug 'preservim/nerdtree'
Plug 'easymotion/vim-easymotion'
Plug 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'
Plug 'roman/golden-ratio'

call plug#end()

"Customization 4 Plugins
let g:lightline = {
      \ 'colorscheme': 'gotham256',
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

""" vim ALE stuff"""
let g:ale_disable_lsp = 1 " make ale work better with coc
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
let g:ale_sign_error = '●'
let g:ale_sign_warning = '.'
""" End Vim Ale

""" vim coc stuff
" always show signcolumns
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

set background=dark

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" required by coc
set cmdheight=1
set updatetime=300
set shortmess+=c
set signcolumn=yes
" """ End vim coc

""" Coc Extensions
let g:coc_global_extensions = ['coc-json', 'coc-pyright', 'coc-clangd', 'coc-snippets']

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

" Split
map <leader>wv :vsp<CR>
map <leader>ws :sp<CR>

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <C-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Pressing ,sc will toggle and untoggle spell checking
map <leader>sc :setlocal spell!<cr>

" Toggle paste mode on and off:
map <leader>pp :setlocal paste!<cr>
" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=
" Fast saving
nmap <leader>w :w!<cr>
" Fugitive
map <leader>gg :Git<CR>
map <leader>gd :Gdiffsplit<CR>
map <leader>gb :Git blame<CR>
" NerdTree
map <leader>nf :NERDTreeFocus<CR>
map <leader>no :NERDTree<CR>
map <leader>nt :NERDTreeToggle<CR>
map <leader>ns :NERDTreeFind<CR>

" Start NERDTree, unless a file or session is specified, eg. vim -S session_file.vim.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') && v:this_session == '' | NERDTree | endif
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

let NERDTreeQuitOnOpen=3
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

" Jump fast
" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)

" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)
" Clear highlights
map <leader>// :noh<CR>
" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" :W sudo saves the file 
" (useful for handling the permission-denied error)
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

" Colors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
" fixes glitch? in colors when using vim with tmux
set t_Co=256
" Fix weird glitches in kitty
if &term == 'xterm-kitty'
    let &t_ut=''
endif
set termguicolors     " enable true colors support
colorscheme gotham

" Italics suppots
highlight Comment cterm=italic
