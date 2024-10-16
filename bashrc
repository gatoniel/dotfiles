# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
PATH="$HOME/.local/bin:$HOME/bin:$PATH"
export PATH

# https://serverfault.com/a/311405
if [[ -n "$PS1" ]]; then
    cat /etc/motd
fi;

# https://wiki.archlinux.org/index.php/GnuPG#gpg-agent
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi
export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# conda
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/niklas/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/niklas/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/niklas/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/niklas/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Poetry Python Package Management
export PATH="$HOME/.poetry/bin:$PATH"

# Go Path
export PATH="$PATH:/usr/local/go/bin"

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
. "$HOME/.cargo/env"

# pyenv from https://cookiecutter-hypermodern-python.readthedocs.io/en/2021.7.15/guide.html#getting-python
# from https://stackoverflow.com/a/45578839/10106730
eval "$(pyenv init --path)"
# from https://github.com/pyenv/pyenv-virtualenv/issues/387
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# ruby-install ruby-3.2.2
export PATH="$HOME/.rubies/ruby-3.2.2/bin:$PATH"

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba shell init' !!
export MAMBA_EXE='/home/niklas/miniconda3/bin/mamba';
export MAMBA_ROOT_PREFIX='/home/niklas/miniconda3';
__mamba_setup="$("$MAMBA_EXE" shell hook --shell bash --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias mamba="$MAMBA_EXE"  # Fallback on help from mamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<
