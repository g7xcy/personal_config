if status is-interactive
    # Commands to run in interactive sessions can go here
    set -U PATH /home/frederica/.local/bin /home/frederica/bin $PATH
    set -x COLORTERM truecolor
    set -x fish_charset utf-8
    abbr -a ws cd /mnt/e/Workspace
    abbr -a lsa ls -al
    abbr -a gitc git commit
    abbr -a gita git add
end
