# .bash_profile

if [ "$TERM" != "screen" ] && [ "$SSH_CONNECTION" != "" ]; then
   /usr/bin/screen -S sshscreen -d -R && exit
fi

# https://github.com/pyenv/pyenv#basic-github-checkout
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# User specific environment and startup programs
# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

. "$HOME/.cargo/env"
