#!/bin/bash

# Create directories if they don't exist
mkdir -p /app/config /app/downloads /app/music

# Set permissions
chown -R $(id -u):$(id -g) /app

# Create Chrome user data directory
mkdir -p /app/config/chrome-data

# Start supervisor
exec /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf