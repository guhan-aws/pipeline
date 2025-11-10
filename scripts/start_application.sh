#!/bin/bash
set -e

echo "Starting Node.js application..."

cd /home/ec2-user/app

# Start application with PM2
echo "Starting app with PM2..."
pm2 start app.js --name "my-app" \
    --log /var/log/nodejs-app/app.log \
    --error /var/log/nodejs-app/error.log

# Generate startup script
pm2 startup systemd -u ec2-user --hp /home/ec2-user
pm2 save

# Verify application is running
sleep 2
if ! pm2 list | grep -q "online"; then
    echo "ERROR: Application failed to start"
    exit 1
fi

echo "Application started successfully"
exit 0