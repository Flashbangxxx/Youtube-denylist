#!/bin/bash
# Removes the youtube-denylist block from /etc/hosts.
set -euo pipefail

HOSTS_FILE="/etc/hosts"

if ! grep -q "# >>> youtube-denylist >>>" "$HOSTS_FILE" 2>/dev/null; then
  echo "No youtube-denylist block found in $HOSTS_FILE." >&2
  exit 1
fi

sudo sed -i '' '/# >>> youtube-denylist >>>/,/# <<< youtube-denylist <<</d' "$HOSTS_FILE"

sudo dscacheutil -flushcache
sudo killall -HUP mDNSResponder 2>/dev/null || true

echo "Done. youtube.com and youtu.be are unblocked."
