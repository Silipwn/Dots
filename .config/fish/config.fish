set -g FORGIT_COPY_CMD 'xclip -selection clipboard'
set -gx EDITOR vim
if status is-interactive
    if not set -q TMUX
        read -l -P 'Attach to tmux [Name/l/m] ?' confirm
        switch $confirm
            case l L
                tmux attach-session -t (tmux list-sessions -F '#{session_name}' | fzf)
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
    echo "* Meeting with $argv[1] about $argv[2] on "(date) >> $file
    vim "$file"
    echo "Edited $file"
    end
function note
    # Wrapper function for instant markdown notes
    set file $HOME/Dropbox/LogSeq/journals/$d.org
    echo "* $t : $argv" >> $file
    echo "Added note to $file"
end
function snote
    # Wrapper function for instant markdown notes
    set file $HOME/Dropbox/LogSeq/journals/$d.org
    echo "- $t : $argv" >> $file
    echo "Added note to $file"
end
function todo
    # Wrapper function for instant markdown notes
    set file $HOME/Dropbox/LogSeq/journals/$d.org
    echo "* TODO : $t $argv" >> $file
    echo "Added note to $file"
end
end
