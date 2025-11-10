#!/bin/bash
set -e

echo "Validating service health..."

# Wait for application to fully start
sleep 3

# Check if application is running
if ! pm2 list | grep -q "online"; then
    echo "ERROR: Application is not running"
    exit 1
fi

# Perform HTTP health check (adjust URL and expected status)
HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:3000/health 2>/dev/null || echo "000")

if [ "$HTTP_CODE" = "200" ]; then
    echo "Health check passed with status $HTTP_CODE"
    exit 0
else
    echo "ERROR: Health check failed with status $HTTP_CODE"
    exit 1
fi