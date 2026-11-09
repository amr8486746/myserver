#!/bin/bash
cd /home/codespace/mc || exit 1
mkdir -p backups

if tmux has-session -t mc 2>/dev/null; then
  tmux send-keys -t mc "save-off" Enter
  tmux send-keys -t mc "save-all flush" Enter
  sleep 5
fi

STAMP=$(date +%Y%m%d-%H%M%S)
tar -czf "backups/world-$STAMP.tar.gz" world
echo "backup: backups/world-$STAMP.tar.gz"

if tmux has-session -t mc 2>/dev/null; then
  tmux send-keys -t mc "save-on" Enter
fi

ls -1t backups/world-*.tar.gz | tail -n +11 | xargs -r rm --
