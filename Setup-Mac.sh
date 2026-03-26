#!/bin/bash
# Teen's Club - Mac Firewall Setup
# Run once with:  sudo bash Setup-Mac.sh
if [ "$(id -u)" != "0" ]; then
    echo "Please run as root: sudo bash Setup-Mac.sh"
    exit 1
fi
echo "Setting up macOS firewall to allow port 3001..."
NODE_PATH=$(which node)
if [ -n "$NODE_PATH" ]; then
    /usr/libexec/ApplicationFirewall/socketfilterfw --add "$NODE_PATH"
    /usr/libexec/ApplicationFirewall/socketfilterfw --unblockapp "$NODE_PATH"
    echo "Node.js allowed: $NODE_PATH"
else
    echo "WARNING: node not found. Install Node.js first from https://nodejs.org"
fi
/usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on
WIFI_IP=$(ipconfig getifaddr en0 2>/dev/null)
[ -z "$WIFI_IP" ] && WIFI_IP=$(ipconfig getifaddr en1 2>/dev/null)
echo "Done! Your Mac LAN address: http://$WIFI_IP:3001"
echo "If other devices still cannot connect:"
echo "  System Settings -> Network -> Firewall -> turn OFF"
