" set leader key
let g:mapleader = "\<Space>"

filetype plugin indent on

set hidden                              " Required to keep multiple buffers open multiple buffers
set nowrap                              " Display long lines as just one line
set encoding=utf-8                      " The encoding displayed
set pumheight=10                        " Makes popup menu smaller
set fileencoding=utf-8                  " The encoding written to file
set ruler              			        " Show the cursor position all the time
set cmdheight=2                         " More space for displaying messages
set iskeyword+=-                      	" treat dash separated words as a word text object"
set mouse=a                             " Enable your mouse
set splitbelow                          " Horizontal splits will automatically be below
set splitright                          " Vertical splits will automatically be to the right
set t_Co=256                            " Support 256 colors
set conceallevel=0                      " So that I can see `` in markdown files
set tabstop=4                           " Insert 2 spaces for a tab
set shiftwidth=4                        " Change the number of space characters inserted for indentation
set smarttab                            " Makes tabbing smarter will realize you have 2 vs 4
set expandtab                           " Converts tabs to spaces
set smartindent                         " Makes indenting smart
set autoindent                          " Good auto indent
set laststatus=2                        " Always display the status line
set number                              " Line numbers
set relativenumber			            " Relative Line numbers
set cursorline                          " Enable highlighting of the current line
set background=dark                     " tell vim what the background color looks like
set showtabline=2                       " Always show tabs
set noshowmode                          " We don't need to see things like -- INSERT -- anymore
set nobackup                            " This is recommended by coc
set nowritebackup                       " This is recommended by coc
set updatetime=300                      " Faster completion
set timeoutlen=500                      " By default timeoutlen is 1000 ms
set formatoptions-=c formatoptions-=r formatoptions-=o                  " Stop newline continution of comments
set clipboard=unnamedplus               " Copy paste between vim and everything else
set autochdir                           " Your working directory will always be the same as your working directory
set colorcolumn=80,100                  " a ruler at 80th & 100th char column
syntax enable                           " Enables syntax highlighing
set printfont=Monospace:h9              " Set the printfont (used with :hardcopy)
set printoptions=left:15pt,right:15pt,top:15pt,bottom:15pt      " printoptions
set scrollback=100000                   " integrated terminal scrollback
set scrolloff=3                         " start scrolling 3 lines before edge of the viewport (@ greg hurrell)
set noswapfile                          " disable swap files
set lazyredraw                          " disable redrawing when changing text
set modeline                            " because I'm paranoid

" Proper search
set incsearch
set ignorecase
set smartcase
set gdefault

" termguicolors
if has('termguicolors')
    set termguicolors
endif

" gruvbox theme >>
" let g:gruvbox_contrast_dark = 'hard'
" colorscheme gruvbox
" let base16colorspace=256
" colorscheme base16-gruvbox-dark-hard
" Brighter comments
" call Base16hi("Comment", g:base16_gui09, "", g:base16_cterm09, "", "", "")

" everforest theme >>
" let g:everforest_background = 'hard'
colorscheme atlas
" colorscheme everforest

" trim trailing whitespace on save
autocmd FileType c,cpp,java,go,php,python,vim,yaml,rust autocmd BufWritePre <buffer> %s/\s\+$//e

" commentstrings
autocmd FileType c,cpp,cs,java  setlocal commentstring=//\ %s
autocmd FileType fish           setlocal commentstring=#\ %s

" folding based on treesitter
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable

" Let's add custom plugin settings
let g:header_field_author = 'silipwn'
let g:header_field_author_email = 'contact at as-hw.in'
let g:header_field_copyright = 'Finis coronat opus; Run at this code at your own peril ~ silipwn;'
let g:header_auto_add_header = 0
let g:header_field_modified_by = 0
let g:header_field_license_id = 'BSD-3-Clause or GPL-3.0-or-later'
let g:header_field_timestamp_format = '%FT%T%z'

" Modification support
" Based on https://gist.github.com/rkumar/4166881
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
iab notest <c-r>=strftime("[[%b %d(th st nd rd), %Y]] %H:%M")<cr>

""" Add undo magic
"" 2021-07-19T13:11:31+0530: silipwn: Undo
set undofile                " Save undos after file closes
set undodir=$HOME/.nvim/undo " where to save undo histories
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo

" Add support for copying to clipboard
set clipboard=unnamedplus

" automatically enter insert mode on new terminals
autocmd BufWinEnter,WinEnter term://* startinsert

" Tagbar stuff
let g:rust_use_custom_ctags_defs = 1
let g:tagbar_type_rust = {
  \ 'ctagsbin' : '/usr/bin/ctags',
  \ 'ctagstype' : 'rust',
  \ 'kinds' : [
      \ 'n:modules',
      \ 's:structures:1',
      \ 'i:interfaces',
      \ 'c:implementations',
      \ 'f:functions:1',
      \ 'g:enumerations:1',
      \ 't:type aliases:1:0',
      \ 'v:constants:1:0',
      \ 'M:macros:1',
      \ 'm:fields:1:0',
      \ 'e:enum variants:1:0',
      \ 'P:methods:1',
  \ ],
  \ 'sro': '::',
  \ 'kind2scope' : {
      \ 'n': 'module',
      \ 's': 'struct',
      \ 'i': 'interface',
      \ 'c': 'implementation',
      \ 'f': 'function',
      \ 'g': 'enum',
      \ 't': 'typedef',
      \ 'v': 'variable',
      \ 'M': 'macro',
      \ 'm': 'field',
      \ 'e': 'enumerator',
      \ 'P': 'method',
  \ },
\ }
