if status is-interactive
    # Commands to run in interactive sessions can go here
function meet
      # Easy noting stuff
      set d (date '+%Y-%m-%d')
      set t (date +"%Y-%m-%d %H:%M:%S")
      set mfile $HOME/Dropbox/plain-text/meetings/meeting-$d-$argv[1].md
      echo -n "* Meeting with $argv[1] on $d" >> $mfile
      vim "$mfile"
      echo "Edited $mfile"
end
function dark -d "Set dark theme"
    kitty +kitten themes --reload-in=all zenbones_dark
    sed -i "s/solarized-light/solarized-dark/g" ~/.config/i3status-rs/config.toml
    sed -i "s/solarized-light/solarized-dark/g" ~/.config/i3status-rs/sec-config.toml
    i3-msg restart
    echo "Set dark theme"
end
function light -d "Set light theme"
    kitty +kitten themes --reload-in=all zenbones_light
    sed -i "s/solarized-dark/solarized-light/g" ~/.config/i3status-rs/config.toml
    sed -i "s/solarized-dark/solarized-light/g" ~/.config/i3status-rs/sec-config.toml
    i3-msg restart
    echo "Set light theme"
end
# Setup Z
zoxide init fish | source
# Let's load our custom scripts 
if test -d /home/$USER/.local/custom 
    set -gx PATH $PATH /home/$USER/.local/custom/bin
end

end
