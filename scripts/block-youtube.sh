#!/bin/bash
# Blocks youtube.com / youtu.be device-wide via /etc/hosts.
# studio.youtube.com is a different hostname and is left untouched.
set -euo pipefail

HOSTS_FILE="/etc/hosts"
MARKER_START="# >>> youtube-denylist >>>"
MARKER_END="# <<< youtube-denylist <<<"

if grep -q "$MARKER_START" "$HOSTS_FILE" 2>/dev/null; then
  echo "Already installed (found in $HOSTS_FILE). Run unblock-youtube.sh first if you want to reinstall." >&2
  exit 1
fi

DOMAINS=(
  youtube.com
  www.youtube.com
  m.youtube.com
  music.youtube.com
  youtu.be
  www.youtu.be
)

BLOCK=$(
  echo "$MARKER_START"
  for d in "${DOMAINS[@]}"; do
    echo "127.0.0.1 $d"
    echo "::1 $d"
  done
  echo "$MARKER_END"
)

echo "$BLOCK" | sudo tee -a "$HOSTS_FILE" > /dev/null

sudo dscacheutil -flushcache
sudo killall -HUP mDNSResponder 2>/dev/null || true

echo "Done. youtube.com and youtu.be are now blocked for every user on this Mac."
echo "studio.youtube.com is untouched and should still work."
