# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# https://unix.stackexchange.com/a/154431
# test if the prompt var is not set
if [ -z "$PS1" ]; then
    # prompt var is not set, so this is *not* an interactive shell
    return
fi

# User specific environment
PATH="$HOME/.local/bin:$HOME/bin:$PATH"
export PATH

# https://serverfault.com/a/311405
if [[ -n "$PS1" ]]; then
    cat /etc/motd
fi;

# https://wiki.archlinux.org/index.php/GnuPG#gpg-agent
# unset SSH_AGENT_PID
# if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
#   export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
# fi
# export GPG_TTY=$(tty)
# gpg-connect-agent updatestartuptty /bye >/dev/null
# We will use the standard ssh-agent on sciCORE as the newest version of gpg is not available.
eval `ssh-agent`

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# conda
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$("$HOME/miniconda3/bin/conda" "shell.bash" "hook" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

files=(proxies)
path="$HOME/dotfiles_local/bash/"
for file in ${files[@]}
do 
    file_to_load=$path$file
    if [ -f "$file_to_load" ];
    then
        . $file_to_load
        echo "loaded $file_to_load"
    fi
done

# load new git version
module load git/2.23.0-GCCcore-8.3.0-nodocs

# set PYTHONUNBUFFERED in cluster environment
export PYTHONUNBUFFERED=1
