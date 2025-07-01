#!/bin/bash

# Create downloads directory if needed
mkdir -p /app/downloads

# Launch Chrome in headless mode (non-GUI)
/usr/bin/google-chrome \
    --no-sandbox \
    --disable-dev-shm-usage \
    --disable-gpu \
    --disable-software-rasterizer \
    --user-data-dir=/app/config/chrome-data \
    --headless=new \
    --disable-extensions \
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
    --dump-dom "https://dab.yeet.su/" > /app/downloads/dump.html

# Keep container alive
tail -f /dev/null
