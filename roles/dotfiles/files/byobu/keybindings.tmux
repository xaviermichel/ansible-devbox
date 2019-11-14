unbind-key -n C-a
unbind-key -n C-q
set -g prefix ^Q
set -g prefix2 ^Q
bind q send-prefix

bind-key 'v' split-window -h
bind-key 's' split-window -v

set -g base-index 1
setw -g pane-base-index 1

