#!/bin/bash

# Wait for X server to be ready
sleep 5

# Launch Chrome with uBlock Origin extension and target URL
exec /usr/bin/google-chrome \
    --no-sandbox \
    --disable-dev-shm-usage \
    --disable-gpu \
    --remote-debugging-port=9222 \
    --user-data-dir=/app/config/chrome-data \
    --load-extension=/opt/extensions/ublock-origin \
    --disable-extensions-except=/opt/extensions/ublock-origin \
    --disable-default-apps \
    --disable-background-timer-throttling \
    --disable-backgrounding-occluded-windows \
    --disable-renderer-backgrounding \
    --start-maximized \
    --kiosk \
    --app="${TARGET_URL:-https://dab.yeet.su/}" \
    --profile-directory=Default