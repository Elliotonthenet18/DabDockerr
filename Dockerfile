FROM ubuntu:22.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    unzip \
    xvfb \
    x11vnc \
    fluxbox \
    supervisor \
    curl \
    python3 \
    python3-pip \
    inotify-tools \
    p7zip-full \
    && rm -rf /var/lib/apt/lists/*

# Install Chrome
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor -o /usr/share/keyrings/googlechrome-linux-keyring.gpg \
    && echo "deb [arch=amd64 signed-by=/usr/share/keyrings/googlechrome-linux-keyring.gpg] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list \
    && apt-get update \
    && apt-get install -y google-chrome-stable \
    && rm -rf /var/lib/apt/lists/*

# Install noVNC for web-based VNC access
RUN wget -qO- https://github.com/novnc/noVNC/archive/v1.3.0.tar.gz | tar xz -C /opt \
    && mv /opt/noVNC-1.3.0 /opt/novnc \
    && wget -qO- https://github.com/novnc/websockify/archive/v0.10.0.tar.gz | tar xz -C /opt \
    && mv /opt/websockify-0.10.0 /opt/websockify

# Download and prepare uBlock Origin
RUN mkdir -p /opt/extensions \
    && wget -O /opt/extensions/ublock.zip https://github.com/gorhill/uBlock/releases/download/1.64.0/uBlock0_1.64.0.chromium.zip \
    && cd /opt/extensions && unzip ublock.zip -d ublock-origin && rm ublock.zip

# Create app directory and scripts
WORKDIR /app

# Copy configuration files
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY entrypoint.sh /app/entrypoint.sh
COPY file-monitor.py /app/file-monitor.py
COPY chrome-launcher.sh /app/chrome-launcher.sh

# Make scripts executable
RUN chmod +x /app/entrypoint.sh /app/chrome-launcher.sh

# Create necessary directories
RUN mkdir -p /app/config /app/downloads /app/music

# Expose VNC port
EXPOSE 5656

# Set entrypoint
ENTRYPOINT ["/app/entrypoint.sh"]
