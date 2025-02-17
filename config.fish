if status is-interactive
    # Abbr about git
    abbr -a gitc git commit
    abbr -a gita git add
    abbr -a gitpl git pull
    abbr -a gitps git push

    # Abbr about os
    abbr -a lsa ls -al
    abbr -a cls clear
    abbr -a ws cd ~/workspace
    # abbr -a hx sudo -E hx
    abbr -a cd z
    abbr -a reboot sudo reboot
end

zoxide init fish | source
direnv hook fish | source

