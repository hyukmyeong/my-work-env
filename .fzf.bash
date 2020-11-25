# Setup fzf
# ---------
#if [[ ! "$PATH" == */home/hyuk.myeong/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/hyuk.myeong/.fzf/bin"
#fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/hyuk.myeong/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/hyuk.myeong/.fzf/shell/key-bindings.bash"
