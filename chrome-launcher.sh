#!/bin/bash

# Wait for X server to be ready
sleep 5

# Set Chrome download directory to our downloads folder
mkdir -p /app/downloads

# Launch Chrome with uBlock Origin extension and target URL
exec /usr/bin/google-chrome \
    --no-sandbox \
    --disable-dev-shm-usage \
    --disable-gpu \
    --disable-software-rasterizer \
    --user-data-dir=/app/config/chrome-data \
    --load-extension=/opt/extensions/ublock-origin \
    --disable-extensions-except=/opt/extensions/ublock-origin \
    --disable-default-apps \
    --disable-background-timer-throttling \
    --disable-backgrounding-occluded-windows \
    --disable-renderer-backgrounding \
    --start-maximized \
    --disable-infobars \
    --disable-notifications \
    --disable-popup-blocking \
    --homepage="https://dab.yeet.su/" \
    --new-window \
    "https://dab.yeet.su/"
