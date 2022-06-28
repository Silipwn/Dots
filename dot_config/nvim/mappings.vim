" ; as :
" nnoremap ; :

" Jump to start and end of line using the home row keys
" map H ^
" map L $

" use alt+hjkl to move between split/vsplit panels
nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l

" indent / outdent
vnoremap < <gv
vnoremap > >gv

" Use ctrl + hjkl to resize windows
nnoremap <C-k>    :resize -2<CR>
nnoremap <C-j>    :resize +2<CR>
nnoremap <C-h>    :vertical resize -2<CR>
nnoremap <C-l>    :vertical resize +2<CR>

" X clipboard integration
" <Space>c will copy entire buffer into clipboard
" <Space>p will paste clipboard into buffer
noremap <leader>c :w !xsel -ib<CR><CR>
noremap <leader>p :read !xsel --clipboard --output<CR>

" No arrow keys --- force yourself to use the home row
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
" inoremap <up> <nop>
" inoremap <down> <nop>
" inoremap <left> <nop>
" inoremap <right> <nop>

" No backspace in insert mode --- force yourself to use normal mode for
" deletion
inoremap <BS> <nop>
inoremap <Del> <nop>

" Left and right can switch buffers
" nnoremap <left> :bp<CR>
" nnoremap <right> :bn<CR>

" [b and ]b can switch buffers
nnoremap [b :bp!<CR>
nnoremap ]b :bn!<CR>

" close buffer (miguel grinberg: https://gist.github.com/miguelgrinberg/527bb5a400791f89b3c4da4bd61222e4)
nnoremap <leader>x :bp<bar>bd#<CR>

" Leader + tab to toggle between buffers
noremap <leader><tab> <C-^><CR>

" Search results centered please
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" Use :Rg as a global search
" noremap <leader>g :Rg<CR>
" noremap <leader>G :Rgh<CR>

" vim-commentary
nnoremap <space>/ :Commentary<CR>
vnoremap <space>/ :Commentary<CR>

" vim-which-key
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

" Ctrl-P for quick searching files
map <C-p> :Files<CR>

" <space>; for quick search buffers
nmap <leader>b :Buffers<CR>

" remove highlights
vnoremap <leader>h :nohlsearch<CR>
nnoremap <leader>h :nohlsearch<CR>

" Leader + g + o to git-open the current repository page
" nnoremap <leader>go :!git-open<CR>

" Save and quit mapped to <leader>w and <leader>q
nnoremap <leader>w :w<CR>
vnoremap <leader>w :w<CR>
" nnoremap <leader>q :q<CR>
" vnoremap <leader>q :q<CR>

" Save and quit mapped to ;w and ;q
nnoremap ;q :q<CR>
vnoremap ;q :q<CR>
" nnoremap ;w :w<CR>
" vnoremap ;w :w<CR>

" tagbar (miguel grinberg: https://gist.github.com/miguelgrinberg/527bb5a400791f89b3c4da4bd61222e4)
map <leader>t :TagbarToggle<CR>

" vsplit
noremap <leader>v :vsplit<CR>

" exit the terminal mode
tnoremap <Esc> <C-\><C-n>

" send <Esc> in terminal mode
tnoremap <A-[> <Esc>

" command for enable/disable line-wrapping
command! -nargs=* Wrap set wrap! linebreak!

" generate header block
nnoremap <leader>#  :AddHeader<CR>
" goto file but in a vertical split
nnoremap gv :vertical wincmd f<CR>

" reload config
nnoremap <leader>r :source ~/.config/nvim/init.vim<CR>

" relative path (src/foo.txt)
nnoremap <leader>yf :let @+=expand("%")<CR>

" absolute path (/something/src/foo.txt) (mnemonic -> <y>ank <p>ath)
nnoremap <leader>yp :let @+=expand("%:p").':'.line(".")<CR>

" filename (foo.txt)
nnoremap <leader>yt :let @+=expand("%:t")<CR>

" OSC Yank
nnoremap <leader>yy :OSCYank<CR>
vnoremap <leader>yy :OSCYank<CR>

" close the split
nnoremap <leader>sc :close<CR>

" close all buffers except the current one
" https://salferrarello.com/vim-close-all-buffers-except-the-current-one/
command! BufOnly execute '%bdelete|edit #|normal `"'

" close fzf windows on <esc>
" https://github.com/junegunn/fzf/issues/1393#issuecomment-426576577
autocmd! FileType fzf tnoremap <buffer> <esc> <c-c>

" Let's make it easy to switch term windows
" https://old.reddit.com/r/neovim/comments/5usi1q/how_to_change_tab_or_window_once_in_terminal/
tnoremap <C-w>h <C-\><C-n><C-w>h
tnoremap <C-w>j <C-\><C-n><C-w>j
tnoremap <C-w>k <C-\><C-n><C-w>k
tnoremap <C-w>l <C-\><C-n><C-w>l
