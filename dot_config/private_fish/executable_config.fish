# cat ~/.cache/wal/sequences
set PATH /home/silipwn/Code/code-ql/codeql /usr/local/sbin /usr/local/bin /usr/bin /usr/bin/site_perl /usr/bin/vendor_perl /usr/bin/core_perl /home/silipwn/Developments/TChains/Go/bin /home/silipwn/.cargo/bin /home/silipwn/.local/bin /home/silipwn/Developments/Scripts /home/silipwn/.emacs.d/bin 
# starship init fish | source
set -gx GOPATH /home/silipwn/Developments/TChains/Go
set -g QT_QPA_PLATFORMTHEME qt5ct
set -g FORGIT_COPY_CMD 'xclip -selection clipboard'
# set -gx EDITOR nvim
if status is-interactive
    # https://www.markhansen.co.nz/auto-start-tmux/
    if not set -q TMUX
        read -l -P 'Attach to tmux [Name/l/m] ? ' confirm
        switch $confirm
            case l L
                # https://github.com/junegunn/fzf/issues/1693
                tmux new-session -A -s (tmux list-sessions -F '#{session_name}' | fzf --print-query --bind=enter:replace-query+print-query)
            case ''
                echo "As you wish, sir"
            case m main Main
                tmux new-session -A -s main
            case '*'
                tmux new-session -A -s $confirm
    end
end
set d (date +%Y_%m_%d)
set t (date +%H:%M)
function meet
    # Easy noting stuff
    set file "$HOME/Dropbox/LogSeq/pages/Meeting-$d-$argv[1]-$argv[2].org"
    echo -n "* Meeting with $argv[1] for $argv[2] on "(date +'%a %d %b %Y') >> $file
    vim "$file"
    echo -n "Edited $file"
end
function note
    # Wrapper function for instant markdown notes
    set file $HOME/Dropbox/LogSeq/journals/$d.org
    echo -n "* $t : $argv" >> $file
    echo -n "Added note to $file"
end
function snote
    # Wrapper function for instant markdown notes
    set file $HOME/Dropbox/LogSeq/journals/$d.org
    echo -n "- $t : $argv" >> $file
    echo -n "Added note to $file"
end
function todo
    # Wrapper function for instant markdown notes
    set file $HOME/Dropbox/LogSeq/journals/$d.org
    echo -n "* #TODO : $t $argv" >> $file
    echo -n "Added note to $file"
end
end
source ~/.asdf/asdf.fish
set --universal pure_symbol_prompt '(⊙_⊙)'
