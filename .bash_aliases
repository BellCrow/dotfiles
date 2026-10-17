# navigation
alias repos="cd ~/repos/"
alias vimconfig="cd ~/dotfiles/.config/nvim"
alias config="cd ~/dotfiles/"

function change_dir()
{
	location=$(fd --hidden | fzf --exact)

	if [ -z ${location} ] ; then
		return
	fi

	if [ -f ${location} ] ; then
		location=$(dirname $location)
	fi
	
	cd $location
}

bind '"\C-f":"change_dir\n"'
bind '"\C-h":"cd ~\n"'
bind '"\C-u":"cd ..\n"'

# common unix tools
alias vim=nvim
alias ll="ls -lAh --color=auto"

# tools 
alias k9s="k9s --kubeconfig kubeconfig"
alias lzg="lazygit"
alias lzd="lazydocker"

alias py="python3"
