" " This is the default extra key bindings
" let g:fzf_action = {
"   \ 'ctrl-t': 'tab split',
"   \ 'ctrl-s': 'split',
"   \ 'ctrl-v': 'vsplit' }

" " Customize fzf colors to match your color scheme
" let g:fzf_colors = {
"   \ 'fg':      ['fg', 'GruvboxFg1'],
"   \ 'bg':      ['fg', 'GruvboxBg0'],
"   \ 'hl':      ['fg', 'GruvboxYellow'],
"   \ 'fg+':     ['fg', 'GruvboxFg1'],
"   \ 'bg+':     ['fg', 'GruvboxBg1'],
"   \ 'hl+':     ['fg', 'GruvboxYellow'],
"   \ 'info':    ['fg', 'GruvboxBlue'],
"   \ 'prompt':  ['fg', 'GruvboxFg4'],
"   \ 'pointer': ['fg', 'GruvboxBlue'],
"   \ 'marker':  ['fg', 'GruvboxOrange'],
"   \ 'spinner': ['fg', 'GruvboxYellow'],
"   \ 'header':  ['fg', 'GruvboxBg3']
"   \ }

" ripgrep including hidden files
command! -bang -nargs=* Rgh
  \ call fzf#vim#grep(
  \   'rg --hidden --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)
