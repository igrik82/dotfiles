# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi
# # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# # plugins
# source ~/.config/promt/powerlevel10k/powerlevel10k.zsh-theme
#
#==================================================================
# Prompt
#==================================================================
source ~/.config/promt/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/promt/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/fzf/completion.zsh
source /usr/share/fzf/key-bindings.zsh
source ~/.config/promt/chezmoi.zsh

#export DISPLAY=$(w -h $USER | awk '$3 ~ /:[0-9.]*/{print $3}')
export PATH="$HOME/.bin:$PATH"
export PATH="$HOME/.bin/wineDesktop:$PATH"
export PATH="$HOME/Projects/esp-idf/8266/xtensa-lx106-elf/bin:$PATH"
export IDF_PATH="$HOME/Projects/esp-idf/8266/ESP8266_RTOS_SDK"
export CPATH="build/include"
export PATH=/home/igrik/.version_python/.python3.11/bin:$PATH
export PATH=/home/igrik/.local/bin:$PATH
export STARSHIP_CONFIG=~/.config/starship/starship.toml

#==================================================================
# FZF
#==================================================================
export FZF_DEFAULT_OPTS="
--info=inline
--layout reverse
--multi
--height=85%
--border
--preview '([[ -f {} ]] && (bat --style=numbers --color=always --line-range :100 {} || cat {})) || ([[ -d {} ]] && (eza --icons=always --tree --color=always {} | less)) || echo {} 2> /dev/null | head -200' 
# --color='hl:148,hl+:154,pointer:032,marker:010,bg+:237,gutter:008'
--color=hl:#2dd4bf
--prompt='>: ' --pointer='▶' --marker='✓'
--bind '?:toggle-preview'
--bind 'ctrl-a:select-all'
--bind 'ctrl-y:execute-silent(echo {+} | pbcopy)'
--bind 'ctrl-e:execute(echo {+} | xargs nvim)'
--bind 'ctrl-s:execute(echo {+} | xargs sudo nvim)'
--bind 'ctrl-v:execute(code {+})'
"
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git "
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

export FZF_CTRL_T_OPTS="$FZF_DEFAULT_OPTS"
export FZF_CTRL_R_OPTS="$FZF_DEFAULT_OPTS --preview-window hidden"
export FZF_ALT_C_OPTS="$FZF_DEFAULT_OPTS"

# # fzf preview for tmux
# export FZF_TMUX_OPTS=" -p90%,70% "  


export PATH=$PATH:~/.platformio/penv/bin

# Enable color
autoload -U colors && colors

#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
# => CUSTOM HISTORY
#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
HISTSIZE=1000000000
SAVEHIST=$HISTSIZE
HISTFILE=~/.zsh_history
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY            # Add commands to history immediately
setopt share_history                 # Share history between sessions
setopt hist_expire_dups_first        # Remove duplicates first when trimming
setopt hist_ignore_dups              # Ignore duplicates
setopt hist_verify                   # Do not execute immediately upon history expansion

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.
ZSH_AUTOSUGGEST_STRATEGY=( history completion )

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}

# Paste from system primary buffer in normal mode
#bindkey -M vicmd 'j' vi-put-after

# Disable all keys in insert mode except Ctrl+F
bindkey -M viins '^F' vi-cmd-mode

# Restrict input in normal mode
bindkey -M vicmd -r 'a-zA-Z0-9'

# Set a short timeout for key sequences
export KEYTIMEOUT=1


# Preferred editor for local and remote sessions
export EDITOR='nvim'

# Console in english
export LC_ALL=en_US.UTF-8

# Display for xclipboard
export DISPLAY=:0
# Switch comand promt in VIM mode
set -o vi

# Neofetch
if [ -f "/usr/bin/neofetch" ]; then
    neofetch
fi

# Aliases
alias config='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias diffview="nvim -c \"lua require('lazy').load({plugins = 'diffview.nvim'})\" -c \"DiffviewOpen\""
alias l="eza -a --icons=always"
alias ls="eza -a --icons=always"
alias ll="eza -lgha -m --time-style long-iso --icons=always"
alias lt="eza -T --icons=always"
alias svi="sudo vim"
alias v="vim"
alias sv="sudo nvim"
#alias bat="batcat --theme OneHalfLight"
alias ip='ip -c'
alias wifi-connect='sudo wpa_supplicant -D nl80211 -c /etc/wpa_supplicant/work.conf -i wlan0&'
alias vpn-connect='wg-quick down wg0 && wg-quick up wg0 || wg-quick up wg0'
alias re="python3.10 /usr/bin/ranger"
alias lsblk="lsblk --output MODEL,TYPE,NAME,SIZE,MOUNTPOINT,FSTYPE"
alias cd="z"

# Hooks
eval "$(direnv hook zsh)"
eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"
eval "$(starship init zsh)"

# Automate ssh-agent startup
#[ -z "$SSH_AUTH_SOCK" ] && [ -z "$(pgrep ssh-agent)" ] && "$(eval $(ssh-agent -s))" 

#==============================================================
# Yazi wrapper to provide change dir then exit
# =============================================================
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}


#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
# => Systemd functions
#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
rpservs () {
  # STEP 1. List running services using systemctl and format the output
  systemctl list-units --type=service --state=running --no-pager | grep service | sed 's/loaded active running//g' | \
  awk '{print "\n\033[1m" NR " | " $1;

  # STEP 2.  Extract and display the Description of the service
  system("systemctl show -p Description " $1 " | \
  sed \"s/Description=//\" | \
  awk \"{print \\\"\033[0mDesc: \\\" \\$0}\"");

  # STEP 3. Extract and display the ExecStart (binary path) of the service
  system("systemctl cat " $1 " | \
  grep -E \"^ExecStart=\" | \
  sed \"s/ExecStart=//\" | \
  awk \"{gsub(/\\\\.\\\\//, \\\" \\\"); print \\\"Exec: \\\" \\$0}\"");

  # STEP 4. Extract and display the actual binary file path (BinA) using readlink -f
  system("systemctl cat " $1 " | \
  grep -E \"^ExecStart=\" | \
  sed \"s/ExecStart=//\" | \
  awk \"{gsub(/\\\\.\\\\//, \\\" \\\"); system(\\\"readlink 2>/dev/null -f \\\" \\$1)}\" | \
  awk \"{print \\\"BinA: \\\" \\$0}\"");

  # STEP 5. Extract the binary file size (Size) of the service
  system("systemctl cat " $1 " | \
  grep -E \"^ExecStart=\" | \
  sed \"s/ExecStart=//\" | \
  awk \"{gsub(/\\\\.\\\\//, \\\" \\\"); system(\\\"du 2>/dev/null -sh \\\" \\$1)}\" | \
  awk \"{print \\\"Size: \\\" \\$1}\"");

  # STEP 6. Extract and display the startup time of the service using systemd-analyze blame
  # system("systemd-analyze blame | grep " $1 " | \
  # awk \"{print \\\"Time: \\\" \\$1}\"");

  # STEP 7. Extract and display the config file path (FragmentPath) of the service
  system("systemctl show " $1 " -p FragmentPath | \
  sed \"s/FragmentPath=//\" | \
  awk \"{print \\\"Conf: \\\" \\$0}\"");}'
}

rpblame() {
  systemd-analyze blame  --no-pager | nl
}



# bind key
bindkey -s '^o' 'lfcd\n'
# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# Launch colorscript
/opt/shell-color-scripts/colorscript.sh -r

#ESP32
alias get_idf='/opt/micropython/esp-idf/export.sh'

# igrik
# Set tmux for ssh automaticaly
if [ -e /usr/bin/tmux ] && [ -n "$SSH_CONNECTION" ]; then
    /usr/bin/tmux -2 -u new-session -A -s dvinskaya 2>/dev/null
fi

echo -e "\e[38;5;82m
██████╗ ██╗   ██╗██╗███╗   ██╗███████╗██╗  ██╗ █████╗ ██╗   ██╗ █████╗
██╔══██╗██║   ██║██║████╗  ██║██╔════╝██║ ██╔╝██╔══██╗╚██╗ ██╔╝██╔══██╗
██║  ██║██║   ██║██║██╔██╗ ██║███████╗█████╔╝ ███████║ ╚████╔╝ ███████║
██║  ██║╚██╗ ██╔╝██║██║╚██╗██║╚════██║██╔═██╗ ██╔══██║  ╚██╔╝  ██╔══██║
██████╔╝ ╚████╔╝ ██║██║ ╚████║███████║██║  ██╗██║  ██║   ██║   ██║  ██║
╚═════╝   ╚═══╝  ╚═╝╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝
\e[0m" | lolcat
