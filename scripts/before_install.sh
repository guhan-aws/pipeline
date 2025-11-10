#!/bin/bash
set -e

echo "Running BeforeInstall hook..."

# Update system
yum update -y

# Install Node.js if not already installed
if ! command -v node &> /dev/null; then
    echo "Installing Node.js 18..."
    curl --silent --location https://rpm.nodesource.com/setup_18.x | bash -
    yum install -y nodejs
fi

# Install PM2 globally if not installed
if ! command -v pm2 &> /dev/null; then
    echo "Installing PM2..."
    npm install -g pm2
fi

# Ensure log directory exists
mkdir -p /var/log/nodejs-app

# Create app user if not exists
if ! id -u app-user >/dev/null 2>&1; then
    useradd -m app-user || true
fi

echo "BeforeInstall completed successfully"
exit 0