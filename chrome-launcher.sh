#!/bin/bash

# Create downloads directory if needed
mkdir -p /app/downloads

# Wait for X server to be ready
sleep 5

# Launch Chrome with proper extensions and settings
/usr/bin/google-chrome \
    --no-sandbox \
    --disable-dev-shm-usage \
    --disable-gpu \
    --disable-software-rasterizer \
    --user-data-dir=/app/config/chrome-data \
    --disable-extensions-except=/opt/extensions/ublock-origin \
    --load-extension=/opt/extensions/ublock-origin \
    --disable-default-apps \
    --disable-background-timer-throttling \
    --disable-backgrounding-occluded-windows \
    --disable-renderer-backgrounding \
    --disable-infobars \
    --disable-notifications \
    --disable-popup-blocking \
    --disable-web-security \
    --disable-features=VizDisplayCompositor,TranslateUI \
    --no-first-run \
    --no-default-browser-check \
    --hide-scrollbars \
    --disable-ipc-flooding-protection \
    --user-agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36" \
    --remote-debugging-port=9222 \
    --display=:1 \
    --window-size=1920,1080 \
    --start-maximized \
    "https://dab.yeet.su/" &

# Keep the script running
wait
