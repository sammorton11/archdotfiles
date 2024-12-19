#!/bin/bash

# Start tmux
tmux new-session -d -s session01

# Window 1
tmux new-window -t session01:0 -n "session01"
tmux send-keys -t session01:0 "tmux source-file ~/.tmux-gotham.conf" C-m

# Attach to the session
tmux attach-session -t session01
