########################################
# Reference
########################################

# https://github.com//tmux-config
# https://github.com/tony/tmux-config
# https://github.com/seebi/tmux-colors-solarized/blob/master/tmuxcolors-256.conf
# https://github.com/edkolev/dots/blob/master/tmux.conf





########################################
# Style
########################################

set-option -g status-style bg=colour235,fg=colour136,default # bg=base02, fg=yellow
set -g default-terminal "screen-256color"
#set -g default-terminal "xterm-256color"
set-window-option -g window-status-style fg=colour244,bg=default,dim # fg=base0
set-window-option -g window-status-current-style fg=colour166,bg=default,bright # fg=orange
set-option -g pane-border-style fg=colour235 #fg=base02
set-option -g pane-active-border-style fg=colour240 #fg=base01
set-option -g message-style bg=colour235,fg=colour166 # bg=base02, fg=orange
set-option -g display-panes-active-colour colour33 #blue
set-option -g display-panes-colour colour166 #orange
set-window-option -g clock-mode-colour green #green

## status bar
if-shell '\( #{$TMUX_VERSION_MAJOR} -eq 2 -a #{$TMUX_VERSION_MINOR} -lt 2\) -o #{$TMUX_VERSION_MAJOR} -le 1' 'set-option -g status-utf8 on'

# How to use true colors in vim under tmux? #1246 for 2.6 and higher
# https://github.com/tmux/tmux/issues/1246:
# set -g default-terminal "tmux-256color"
# set -ga terminal-overrides ",*256col*:Tc"
# 2.5 and lower:
# set -g default-terminal "screen-256color"

# Doesn't work on iterm2 / mac
# if-shell "test '\( #{$TMUX_VERSION_MAJOR} -eq 2 -a #{$TMUX_VERSION_MINOR} -ge 6 \)'" 'set -g default-terminal "tmux-256color"'
# if-shell "test '\( #{$TMUX_VERSION_MAJOR} -eq 2 -a #{$TMUX_VERSION_MINOR} -ge 6 \)'" 'set -ga terminal-overrides ",*256col*:Tc"'

# Try screen256-color (https://github.com/tmux/tmux/issues/622):
if-shell "test '\( #{$TMUX_VERSION_MAJOR} -eq 2 -a #{$TMUX_VERSION_MINOR} -ge 6 \)'" 'set -g default-terminal "screen-256color"'
if-shell "test '\( #{$TMUX_VERSION_MAJOR} -eq 2 -a #{$TMUX_VERSION_MINOR} -ge 6 \)'" 'set -ga terminal-overrides ",screen-256color:Tc"'
if-shell '\( #{$TMUX_VERSION_MAJOR} -eq 2 -a #{$TMUX_VERSION_MINOR} -lt 6\) -o #{$TMUX_VERSION_MAJOR} -le 1' 'set -g default-terminal "screen-256color"'





########################################
# Windows and panels
########################################

# r = reload config
# C-x I

bind-key t command-prompt -p "Name of new window: " "new-window -n '%%'"
bind-key 2 split-window -v
bind-key 3 split-window -h
bind-key 0 kill-pane
bind-key q confirm kill-window

## switch windows alt+number
bind-key -n M-1 select-window -t 1
bind-key -n M-2 select-window -t 2
bind-key -n M-3 select-window -t 3
bind-key -n M-4 select-window -t 4
bind-key -n M-5 select-window -t 5
bind-key -n M-6 select-window -t 6
bind-key -n M-7 select-window -t 7
bind-key -n M-8 select-window -t 8
bind-key -n M-9 select-window -t 9

## set to main-horizontal, 66% height for main pane
bind m run-shell "~/.tmux/scripts/resize-adaptable.sh -l main-horizontal -p 66"
# Same thing for verical layouts
bind M run-shell "~/.tmux/scripts/resize-adaptable.sh -l main-vertical -p 50"

#bind tab next-window
bind Tab next-window
#bind-key tab next-window
#bind-key Tab next-window
bind-key -n M-q confirm kill-window
bind-key -n M-p previous-window
bind-key -n M-n next-window
#bind-key -n C-S-Tab previous-window

## fix pane_current_path on new window and splits
#if-shell "test '#{$TMUX_VERSION_MAJOR} -gt 1 -o \( #{$TMUX_VERSION_MAJOR} -eq 1 -a #{$TMUX_VERSION_MINOR} -ge 8 \)'" 'unbind c; bind c new-window -c "#{pane_current_path}"'
#if-shell "test '#{$TMUX_VERSION_MAJOR} -gt 1 -o \( #{$TMUX_VERSION_MAJOR} -eq 1 -a #{$TMUX_VERSION_MINOR} -ge 8 \)'" "unbind '\"'; bind '\"' split-window -v -c '#{pane_current_path}'"
#if-shell "test '#{$TMUX_VERSION_MAJOR} -gt 1 -o \( #{$TMUX_VERSION_MAJOR} -eq 1 -a #{$TMUX_VERSION_MINOR} -ge 8 \)'" 'unbind v; bind v split-window -h -c "#{pane_current_path}"'
#if-shell "test '#{$TMUX_VERSION_MAJOR} -gt 1 -o \( #{$TMUX_VERSION_MAJOR} -eq 1 -a #{$TMUX_VERSION_MINOR} -ge 8 \)'" 'unbind %; bind % split-window -h -c "#{pane_current_path}"'

# hjkl pane traversal
#bind h select-pane -L
#bind j select-pane -D
#bind k select-pane -U
#bind l select-pane -R

bind -n M-Left select-pane -L
bind -n M-Right select-pane -R
bind -n M-Up select-pane -U
bind -n M-Down select-pane -D





########################################
# Mouse
########################################

set -g mouse on
set -g status-interval 1
set -g status-justify centre # center align window list
set -g status-left-length 20
set -g status-right-length 140
set -g status-left '#[fg=green]#H #[fg=black]• #[fg=green,bright]#(uname -r | cut -c 1-6)#[default]'
set -g status-right '#[fg=green,bg=default,bright]#(tmux-mem-cpu-load) #[fg=red,dim,bg=default]#(uptime | cut -f 4-5 -d " " | cut -f 1 -d ",") #[fg=white,bg=default]%a%l:%M:%S %p#[default] #[fg=blue]%Y-%m-%d'

## rm mouse mode fail
#if-shell '\( #{$TMUX_VERSION_MAJOR} -eq 2 -a #{$TMUX_VERSION_MINOR} -ge 1\)' 'set -g mouse off'
#if-shell '\( #{$TMUX_VERSION_MAJOR} -eq 2 -a #{$TMUX_VERSION_MINOR} -lt 1\) -o #{$TMUX_VERSION_MAJOR} -le 1' 'set -g mode-mouse off'





########################################
# Usability
########################################

## auto window rename
set-window-option -g automatic-rename

## C-b is not acceptable -- Vim uses it
set-option -g prefix C-x

## Start numbering at 1
set -g base-index 1

## Allows for faster key repetition
set -s escape-time 0

## Rather than constraining window size to the maximum size of any client
## connected to the *session*, constrain window size to the maximum size of any
## client connected to *that window*. Much more reasonable.
setw -g aggressive-resize on

## Allows us to use C-a a <command> to send commands to a TMUX session inside
## another TMUX session
bind-key a send-prefix

## Activity monitoring
setw -g monitor-activity on
set -g visual-activity on

## reload config
bind r source-file ~/.tmux.conf \; display-message "Config reloaded..."

## from powerline
run-shell "tmux set-environment -g TMUX_VERSION_MAJOR $(tmux -V | cut -d' ' -f2 | cut -d'.' -f1 | sed 's/[^0-9]*//g')"
run-shell "tmux set-environment -g TMUX_VERSION_MINOR $(tmux -V | cut -d' ' -f2 | cut -d'.' -f2 | sed 's/[^0-9]*//g')"





########################################
# Copypaste mode
########################################

#set-window-option -g mode-keys vi
#if-shell "test '\( #{$TMUX_VERSION_MAJOR} -eq 2 -a #{$TMUX_VERSION_MINOR} -ge 4 \)'" 'bind-key -Tcopy-mode-vi v send -X begin-selection; bind-key -Tcopy-mode-vi y send -X copy-selection-and-cancel'
#if-shell '\( #{$TMUX_VERSION_MAJOR} -eq 2 -a #{$TMUX_VERSION_MINOR} -lt 4\) -o #{$TMUX_VERSION_MAJOR} -le 1' 'bind-key -t vi-copy v begin-selection; bind-key -t vi-copy y copy-selection'
set-option -g mode-keys emacs
set-option -g status-keys emacs
bind-key -n M-i copy-mode
bind-key -n M-y paste
## copy into system clipboard
bind-key -T copy-mode MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "xclip -selection clipboard -i"
bind-key -T copy-mode M-w send-keys -X copy-pipe-and-cancel "xclip -selection clipboard -i"





########################################
# List of plugins
########################################

set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin 'tmux-plugins/tmux-open'

# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '~/.tmux/plugins/tpm/tpm'
