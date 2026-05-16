#!/bin/bash
# Watches ~/Downloads/andreev.net.html and auto-pushes to GitHub on every save
# Runs as a background daemon via launchd

SRC="$HOME/Downloads/andreev.net.html"
REPO="$HOME/Projects/andreev-net"
LOG="$HOME/Projects/andreev-net/autopush.log"

log(){ echo "[$(date '+%H:%M:%S')] $*" >> "$LOG"; }
log "watcher started — monitoring $SRC"

fswatch -o "$SRC" | while read; do
  sleep 1  # brief debounce in case editor does multi-write
  log "change detected — syncing..."
  cp "$SRC" "$REPO/index.html"
  cd "$REPO"
  if git diff --quiet index.html; then
    log "no diff — skipping push"
  else
    git add index.html
    git commit -m "auto: $(date '+%Y-%m-%d %H:%M:%S')"
    git push origin main >> "$LOG" 2>&1 && log "pushed ✓ → https://andreev-net.netlify.app" || log "push failed — check log"
  fi
done
