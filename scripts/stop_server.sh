#!/bin/bash
set -e

echo "Stopping Node.js application..."

# Stop all PM2 processes
if command -v pm2 &> /dev/null; then
    pm2 stop all || true
    pm2 delete all || true
fi

# Kill any remaining node processes (as backup)
pkill -f "node" || true

echo "Application stopped successfully"
exit 0