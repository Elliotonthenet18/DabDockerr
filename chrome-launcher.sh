#!/bin/bash

# Wait for X server to be ready
sleep 10

# Create downloads directory
mkdir -p /app/downloads

# Set display
export DISPLAY=:1

# Launch Chrome in kiosk mode to hide all browser UI
/usr/bin/google-chrome \
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
    --disable-infobars \
    --disable-notifications \
    --disable-popup-blocking \
    --disable-web-security \
    --disable-features=VizDisplayCompositor \
    --no-first-run \
    --no-default-browser-check \
    --hide-scrollbars \
    --disable-translate \
    --disable-features=TranslateUI \
    --disable-ipc-flooding-protection \
    --kiosk \
    --app="https://dab.yeet.su/" &

# Keep the script running
wait
