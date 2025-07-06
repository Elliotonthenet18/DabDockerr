#!/bin/bash

# Create directories if they don't exist
mkdir -p /app/config /app/downloads /app/music
mkdir -p /var/log/supervisor

# Create Chrome user data directory with proper permissions
mkdir -p /app/config/chrome-data
chown -R chrome:chrome /app/config/chrome-data
chown -R chrome:chrome /app/downloads
chown -R chrome:chrome /app/music

# Set proper permissions for log directory
chmod 755 /var/log/supervisor

# Ensure Chrome downloads directory exists and has proper permissions
mkdir -p /app/config/chrome-data/Default
chown -R chrome:chrome /app/config/chrome-data/Default

# Start supervisor
exec /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
