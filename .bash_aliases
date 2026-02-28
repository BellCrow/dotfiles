# navigation
alias repos="cd ~/repos/"
alias studies="cd ~/repos/studies/"
alias vimconfig="cd ~/dotfiles/.config/nvim"
alias config="cd ~/dotfiles/"

# common unix tools
alias vim=nvim
alias ll="ls -lAh --color=auto"

# tools 
alias k9s="k9s --kubeconfig kubeconfig"
alias lzg="lazygit"
alias lzd="lazydocker"
alias fd="fdfind"


# new task folder
alias newtask="pipx run cookiecutter ~/dev/cookiecutter_templates/task"

# fzf
function cf() {
    local dirname
    dirname=$(find -type d  | fzf) || return
    cd "$dirname"
}
function cff() {
    local dirname
    dirname=$(find ~ -type d  | fzf) || return
    cd "$dirname"
}
alias py="python3"
alias discordInstall="cd ~/Downloads && sudo dpkg -i discord* && rm discord*"
