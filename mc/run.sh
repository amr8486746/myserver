#!/bin/bash
cd /home/codespace/mc || exit 1

if tmux has-session -t mc 2>/dev/null; then
  echo "server: already running"
else
  tmux new-session -d -s mc ./start.sh
  echo "server: started"
fi

if [ -x ./playit ]; then
  if tmux has-session -t tunnel 2>/dev/null; then
    echo "tunnel: already running"
  else
    tmux new-session -d -s tunnel ./playit
    echo "tunnel: started"
  fi
else
  echo "tunnel: playit not installed yet, skipping"
fi
