#!/bin/bash
# Sync latest andreev.net.html → index.html, commit, and push to trigger auto-deploy
set -e

cp ~/Downloads/andreev.net.html index.html
git add index.html
git commit -m "update: $(date '+%Y-%m-%d %H:%M')"
git push origin main
echo "✓ Pushed — deploy running at https://github.com/AppleSample/andreev-net/actions"
echo "✓ Live at https://andreev-net.netlify.app"
