if status is-interactive
    # Abbr about git
    abbr -a gitc git commit
    abbr -a gita git add
    abbr -a gitpl git pull
    abbr -a gitps git push

    # Abbr about os
    abbr -a lsa ls -al
    abbr -a cls clear
    abbr -a sudo sudo -E
end

zoxide init fish | source
direnv hook fish | source

