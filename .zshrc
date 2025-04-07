# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="juanghurtado"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(history copypath kubectl git tmux github npm node emoji-clock zsh-autosuggestions jsontools sudo)
export GITHUB_USER="your-email@example.com"

#export GITHUB_USER=your-email@example.com

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH":

# You may need to manually set your language environment
export LANG=en_US.UTF-8
# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
#!


export PATH="$HOME/.local/bin:$PATH"
export PATH="/usr/local/bin:$PATH"

export NODE_OPTIONS=--max-old-space-size=4096

export GOPATH=$HOME/go
export GO111MODULE=on
export PATH=$GOPATH/bin:$PATH
export PATH=$PATH:/usr/local/go/bin

# for weechat
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

export NOTES_DIR=$HOME/notes
export EDITOR=nvim
export VISUAL=nvim
export PAGER='nvim -R'
export SHELL=/bin/zsh
export SUDO_EDITOR=nvim
export BROWSER=brave

# set env vars
source $HOME/.env

# add luamake to path
alias luamake=$HOME/sumneko/3rd/luamake/luamake
export PATH=~/sumneko/bin/:$PATH

# add npmjs to path
export PATH=~/.local/.npm-global/bin:$PATH
export ANSIBLE_COW_SELECTION=random

# add aws cli to path
export PATH="/usr/local/aws-cli/v2/2.13.3/bin":$PATH
export PATH="$HOME/.cargo/bin/":$PATH

### Function extract for common file formats ###
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

function extract {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
 else
    for n in "$@"
    do
      if [ -f "$n" ] ; then
          case "${n%,}" in
            *.cbt|*.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar)
                         tar xvf "$n"       ;;
            *.lzma)      unlzma ./"$n"      ;;
            *.bz2)       bunzip2 ./"$n"     ;;
            *.cbr|*.rar)       unrar x -ad ./"$n" ;;
            *.gz)        gunzip ./"$n"      ;;
            *.cbz|*.epub|*.zip)       unzip ./"$n"       ;;
            *.z)         uncompress ./"$n"  ;;
            *.7z|*.arj|*.cab|*.cb7|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.pkg|*.rpm|*.udf|*.wim|*.xar)
                         7z x ./"$n"        ;;
            *.xz)        unxz ./"$n"        ;;
            *.exe)       cabextract ./"$n"  ;;
            *.cpio)      cpio -id < ./"$n"  ;;
            *.cba|*.ace)      unace x ./"$n"      ;;
            *)
                         echo "extract: '$n' - unknown archive method"
                         return 1
                         ;;
          esac
      else
          echo "'$n' - file does not exist"
          return 1
      fi
    done
fi
}

IFS=$SAVEIFS

export AWS_PROFILE=default
# export ANDROID_HOME=/usr/lib/android-sdk
export ANDROID_HOME="$HOME/Library/Android/sdk"
# export ANDROID_HOME=$HOME/Library/Android/sdk
export ANDROID_SDK_ROOT="$HOME/Library/Android/sdk"
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
export PATH=$ANDROID_HOME:$PATH

export JAVA_HOME='/path/to/java/home'
export PATH="/opt/homebrew/opt/openjdk@11/bin:$PATH"


# Aliases
alias kwAws='AWS_PROFILE=kw aws'
alias akwAws='AWS_PROFILE=akw aws'
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME' # git bare repo  for dotfiles config
alias grep='grep --color=auto'
alias ls='ls -l --color'
alias lsa='ls -la --color'
alias yay=paru
#alias ls='ls -asSh --color'
alias du='dust -d 1'
alias dg='dragon'
# alias gc='google-chrome &'
alias gcd='$HOME/scripts/utils/gcd'
alias bcd='$HOME/scripts/utils/bcd'
# alias bcd='brave-browser --disable-web-security --user-data-dir=$HOME/braveTemp &'
# alias gcd='google-chrome --disable-web-security --disable-gpu  &'

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm=trash

alias v=openNvim
alias vi=openNvim
alias vim=openNvim
alias nvim=openNvim
alias lg=lazygit
alias r=ranger
alias mk="minikube kubectl --"
alias k=kubectl

alias python3='python3.10'
alias profile="nvim $HOME/.zshrc"
alias notes="cd $HOME/notes/"
alias enotes="nvim $HOME/notes/"

# Function to open a note file using fzf/gum
# function open_note() {
#     # Ensure notes directory exists
#     if [[ ! -d "$NOTES_DIR" ]]; then
#         echo "Notes directory not found: $NOTES_DIR"
#         return 1
#     }
# 
#     # Find all files in notes directory and its subdirectories
#     selected_file=$(find -L "$NOTES_DIR" -type f | \
#         # Remove the base notes directory path for cleaner display
#         sed "s|^$NOTES_DIR/||" | \
#         # Use gum to select a file
#         gum filter --placeholder "Select a note to open...")
# 
#     # If no file was selected (user pressed ESC or empty result), exit
#     if [[ -z "$selected_file" ]]; then
#         return 0
#     fi
# 
#     # Construct the full path to the selected file
#     local full_path="$NOTES_DIR/$selected_file"
# 
#     # Verify the file exists before opening
#     if [[ ! -f "$full_path" ]]; then
#         echo "Error: File not found: $full_path"
#         return 1
#     fi
# 
#     # Open the file in nvim
#     nvim "$full_path"
# }

# Alias for the function
alias onotes='open_note'

alias evim="nvim $HOME/.config/nvim"
alias gp='git push origin $(git branch --list | tr -d "* " | gum filter)'
alias gcp='git cherry-pick -m 1 '
alias gbm='gitBranchManager'
alias jt='jest --setupFiles dotenv/config  -t '
alias getNextTSCErrorFile='tsc | awk "NR==1{print $1}" | cut -f1 -d"("'
alias tscNext='nvim $(getNextTSCErrorFile)'


function exportEnvironmentVariableFile()
{
  if [ ! -z "$1" ]; then
    awk '/^[^#]/{system("echo export "$1) }' "$1"
  elif [ ! -z /dev/stdin ]; then
    awk '/^[^#]/{system("echo export "$1) }' /dev/stdin
  else
    echo "No file provided"
  fi
}

function gitCheckout()
{
  if [ ! -z "$1" ]; then
    git checkout $1 $2
  else
    git checkout $(git branch --list | tr -d "* " | gum filter)
  fi
}
alias gc='gitCheckout' # workaround to override the git plugin's gc alias

# BEGIN Work ############################

alias stagingBE="ssh -i ~/.ssh/id_rsa user@example.com"
alias mountStagingBE="sshfs user@example.com:/home/user [MOUNT_POINT]"

function esNvim()
{
  nvim $(eslint "src/**" | awk 'NR==2{print $1}')
}

function tscW()
{
    d=$(pwd)
    cd $HOME/Projects/backend-ts
    tsc -w
    cd $d
}

# END Work ############################

alias vn="cat $NOTES_DIR/notes.md | nvim -R"
alias on="openNvim $NOTES_DIR/notes.md"
function cn()
{
  echo "date: $(date)" >> $NOTES_DIR/notes.md
  echo "$@" >> $NOTES_DIR/notes.md
  echo "" >> $NOTES_DIR/notes.md
}

function runFrontEnd()
{
  d=$(pwd)
  app="frontend"
  if [ ! -z "$1" ]; then
    app="$1";
  fi

  if [[ "$app" == "frontend" ]]; then
    cd $HOME/Projects/frontend
    npm i --legacy-peer-deps
    npm run start:local
  elif [[ "$app" == "admin" ]]; then
    cd $HOME/Projects/frontend
    npm i --legacy-peer-deps
    npm run start:admin:local
  elif [[ "$app" == "dev" ]]; then
    cd $HOME/Projects/frontend
    npm i --legacy-peer-deps
    npm run start:developer:local
  elif [[ "$app" == "hue" ]]; then
    cd $HOME/Projects/hue-controller-frontend/
    npm i
    npm run dev
  else
    echo "Invalid app name"
  fi

  cd $d
}

function runNativeApp()
{
  d=$(pwd)
  app="native"
  if [ ! -z "$1" ]; then
    app="$1";
  fi
  
  if [[ "$app" == "native" ]]; then
    cd $HOME/Projects/native-app
    npm i && cd ios && pod install && cd .. && npm run ios 
  else
    echo "Invalid app name"
  fi
  cd $d
}

function runBackEnd()
{
  d=$(pwd)
  app="backend"
  if [ ! -z "$1" ]; then
    app="$1";
  fi

  if [[ "$app" == "backend" ]]; then
    cd $HOME/Projects/backend-ts
    npm i && npm run dev
  elif [[ "$app" == "hue" ]]; then
    cd $HOME/Projects/hue-controller-backend/
    ./pocketbase serve
  elif [[ "$app" == "test" ]]; then
    worktree=$(/usr/bin/ls -la  $HOME/Projects/backend-ts.git/worktrees/ | awk 'NR>3{print $9}' | fzf )
    if [ ! -z "$worktree" ]; then
      cd $HOME/Projects/backend-ts.git/$worktree
      npm i && tsc && npm run start
    fi
  else
    echo "Invalid app name"
  fi
  cd $d
}

alias dps="docker ps"
alias t="tmux"
alias tls="tmux ls"
alias tq="tmux kill-session -t"
alias tqa="tmux kill-session -a"
alias ta="tmux a -t"


function ta() {
    tmux a -t $1
}

function tn() {
    if [ ! -z "$1" ]; then
      tmux new -s $1
    else
      tmux new -s $(pwd | sed 's/.*\///g')
    fi
}

s () {
    d=$(pwd)
    cd $NOTES_DIR

    current_time=$(date "+%Y.%m.%d-%H.%M.%S")
    new_file_name=$current_time.scratch
    if [ ! -z "$1" ]; then
            new_file_name="$current_time.$1";
    fi
    if [ ! -z "$2" ]; then
        new_file_name="$2.$1";
    fi
    mkdir -p $(date '+%Y-%m-%d')

    newfile="$NOTES_DIR/$(date '+%Y-%m-%d')/$new_file_name"
    touch $newfile && nvim $newfile
    cd $d
}

countdown () {
    start="$(( $(date '+%s') + $1))"
    while [ $start -ge $(date +%s) ]; do
        time="$(( $start - $(date +%s) ))"
        printf '%s\r' "$(date -u -d "@$time" +%H:%M:%S)"
        sleep 0.1
    done
}

stopwatch () {
    start=$(date +%s)
    while true; do
        time="$(( $(date +%s) - $start))"
        printf '%s\r' "$(date -u -d "@$time" +%H:%M:%S)"
        sleep 0.1
    done
}

dockerAttach () {
  docker exec -it `docker ps | awk 'NR>1{print $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$6"\t"$7}' | gum filter | awk '{print $1}'` /bin/bash
}

alias dred="docker-compose up -d redis"
alias dcdb="docker-compose up -d cockroachdb"
alias dcu="docker-compose up"
alias dvr="docker volume rm"

# print key bindings
alias kb='qtile cmd-obj -o cmd -f display_kb'

bindkey -s ^s "tmux-sessionizer\n"
bindkey -s ^ag "tmux neww lazygit\n"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
fi

export PIP_BIN="/opt/homebrew/lib/python3.11/site-packages"
export PATH="$PIP_BIN:$PATH"
alias python='python3.11'
alias python3='python3.11'
alias pip3='pip3.11'
alias pip='pip3.11'
# set pyenv init in terminal
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
fi

# Activate zsh completions
if type brew &>/dev/null; then
 FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
 autoload -Uz compinit
 compinit
fi

###-begin-pm2-completion-###
### credits to npm for the completion file model
#
# Installation: pm2 completion >> ~/.bashrc  (or ~/.zshrc)
#

COMP_WORDBREAKS=${COMP_WORDBREAKS/=/}
COMP_WORDBREAKS=${COMP_WORDBREAKS/@/}
export COMP_WORDBREAKS

if type complete &>/dev/null; then
  _pm2_completion () {
    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$COMP_CWORD" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           pm2 completion -- "${COMP_WORDS[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
  }
  complete -o default -F _pm2_completion pm2
elif type compctl &>/dev/null; then
  _pm2_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       pm2 completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K _pm2_completion + -f + pm2
fi
###-end-pm2-completion-###


export PATH="/opt/homebrew/opt/openjdk@11/bin:$PATH"
export CPPFLAGS="-I/opt/homebrew/opt/openjdk@11/include"

## end
export PATH="/opt/homebrew/opt/curl/bin:$PATH"
export PATH=/opt/homebrew/bin:$PATH
export NVM_DIR="$HOME/.nvm"
[ -s "$(brew --prefix nvm)/nvm.sh" ] && \. "$(brew --prefix nvm)/nvm.sh"
[ -s "$(brew --prefix nvm)/etc/bash_completion.d/nvm" ] && \. "$(brew --prefix nvm)/etc/bash_completion.d/nvm"
export NODE_OPTIONS="--no-experimental-fetch"
