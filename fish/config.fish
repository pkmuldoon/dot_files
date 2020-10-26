set -gx LC_ALL en_GB.UTF-8
set -gx LANG en_GB.UTF-8
set -gx TERM xterm-256color
set -gx GOROOT /usr/local/opt/go/libexec
set -gx GOPATH $HOME/.go

set -gx PATH /usr/local/opt/qt@5.5/bin:/usr/local/bin:$HOME/bin:$HOME/usr/local/bin:/Users/phillipmuldoon/.cask/bin:$GOPATH/bin:$GOROOT/bin $PATH
set -gx NVM_DIR $HOME/.nvm

set fish_complete_path ~/.config/fish/completions/ \
  /usr/local/share/fish/completions/ \
  /usr/local/share/fish/vendor_completions.d/ \
  $fish_complete_path

function reload
  set -l config (status -f)
  echo "reloading: $config" source $config
end

#source /usr/local/share/chruby/chruby.fish
#source /usr/local/share/chruby/auto.fish

alias rsp='bundle exec rspec'
alias rke='bundle exec rails'
alias agi='ag --ignore-dir=tmp --ignore-dir=log --path-to-ignore ~/.ignore'

alias cat='bat'
set -gx PAGER "bat -p" 
set -gx MANPAGER "sh -c 'col -b | bat -l man -p'"
alias ls='exa'
alias preview="fzf --preview 'bat --color \"always\" {}'"                                                                                                                                    
alias favpn="osascript -e 'tell application \"Viscosity\" to connect \"Corporate VPN V3.0\"'"
alias emacs="/usr/local/opt/emacs-plus/Emacs.app/Contents/MacOS/Emacs"
set -gx EDITOR emacs
set -gx VISUAL $EDITOR

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(emacs {})+abort'
--color=dark
--color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f
--color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7" 

defaults write -g com.apple.mouse.scaling  6.0

export DIRENV_LOG_FORMAT=
direnv hook fish | source
set -g fish_user_paths "/usr/local/sbin" $fish_user_paths

export DISABLE_SPRING=1

# Set pj directories
set -gx PROJECT_PATHS ~/dev/dev-dashboard ~/dev/freeagent ~/

# Increase number of open files to appease chromedriver
ulimit -n 2056
source /usr/local/share/chruby/chruby.fish
#set -gx SKIM_DEFAULT_COMMAND "fd --type f -E ".svg" -E ".csv" -E ".txt" -E ".ofx""
set -gx SKIM_DEFAULT_COMMAND fd --type f || git ls-tree -r --name-only HEAD || rg --files || find .

function rgi
    set rg_command "rg --color=always --line-number $argv"
    echo $rg_command
    sk --ansi -i -c "$rg_command"
end

function codef
    set rg_command "(rg $argv --color=always --line-number -t ruby -t js -t coffeescript -t erb -t html -t css"

    set result (rg $argv --color=always --line-number -t ruby -t js -t coffeescript -t erb -t html -t css  | fzf  --ansi -i | awk -F ": " '{print $1}' | sed s/$rg_command//)
    echo "Opening code with $result"
    code -g $result
end

starship init fish | source

