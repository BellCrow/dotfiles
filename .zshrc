# start tmux if not already in tmux
if [ -z "$TMUX" ]
then
	tmux
fi


# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
unsetopt autocd beep
setopt appendhistory
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle :compinstall filename '/home/josh/.zshrc'

autoload -Uz compinit
compinit

# End of lines added by compinstall

# need to have brew stuff available
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# i luuuuuv vim
export VISUAL=nvim
export EDITOR="$VISUAL"

# but not THAT much tbh.... 
bindkey -e

# exports
source ~/.zsh_paths

source ~/.zsh_prompt

source ~/.zsh_aliases

source ~/.zsh_gitconfig

# add ssh keys
eval "$(ssh-agent -s)" &> /dev/null
grep -slR "PRIVATE" ~/.ssh/ | xargs -I {} ssh-add -q {} 

# completion for cli tools
autoload -U compinit
compinit -i

# activate fzf keybinds
source <(fzf --zsh)
