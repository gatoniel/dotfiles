# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi
if [ "$TERM" != "screen" ] && [ "$SSH_CONNECTION" != "" ]; then
   /usr/bin/screen -S sshscreen -d -R && exit
fi
# User specific environment and startup programs
