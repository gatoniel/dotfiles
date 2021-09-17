# .bash_profile

if [ "$TERM" != "screen" ] && [ "$SSH_CONNECTION" != "" ]; then
   /usr/bin/screen -S sshscreen -d -R && exit
fi
# User specific environment and startup programs
# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

export PATH="$HOME/.poetry/bin:$PATH"
