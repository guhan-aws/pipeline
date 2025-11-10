#!/bin/bash
set -e

echo "Running AfterInstall hook..."

cd /home/ec2-user/app

# Install npm dependencies
echo "Installing npm packages..."
npm install --production

# Verify critical dependencies are installed
if [ ! -d "node_modules" ]; then
    echo "ERROR: node_modules not created"
    exit 1
fi

# Remove development dependencies to reduce package size
npm prune --production

# Change ownership to ec2-user
chown -R ec2-user:ec2-user /home/ec2-user/app

echo "AfterInstall completed successfully"
exit 0