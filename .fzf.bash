# Setup fzf
# ---------
if [[ ! "$PATH" == */home/bro/.vim/plugged/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/bro/.vim/plugged/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/bro/.vim/plugged/fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/bro/.vim/plugged/fzf/shell/key-bindings.bash"
