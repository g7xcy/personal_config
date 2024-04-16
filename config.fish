if status is-interactive
    # Commands to run in interactive sessions can go here
    set -x COLORTERM truecolor
    set -x fish_charset utf-8

    # Abbr about git
    abbr -a gitc git commit
    abbr -a gita git add
    abbr -a gitaa git add ./*
    abbr -a gitpl git pull
    abbr -a gitps git push

    # Abbr about os
    abbr -a lsa ls -al
    abbr -a cls clear

    # Abbr about lang
    abbr -a py python3
end
