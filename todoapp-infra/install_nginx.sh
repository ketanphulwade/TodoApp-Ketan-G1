#!/bin/bash
set -e

# Update packages
apt update -y

# Install nginx if not already installed
if ! command -v nginx >/dev/null 2>&1; then
  apt install -y nginx
fi

# Start & enable nginx
systemctl start nginx
systemctl enable nginx
