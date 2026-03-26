#!/bin/bash
# ======================================================
#   Teen's Club Registration System - Mac Server Start
# ======================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo ""
echo " ======================================================"
echo "   Teen's Club Registration System - Starting Server"
echo " ======================================================"
echo ""

# ─── OPTIONAL: Set a custom iCloud / Google Drive backup path ────────────────
# If auto-detection doesn't find your cloud folder, uncomment and set below:
#
# export GDRIVE_BACKUP_PATH="$HOME/Library/Mobile Documents/com~apple~CloudDocs/TeensClub Backups"
#
# Common paths on macOS:
#   iCloud Drive:       $HOME/Library/Mobile Documents/com~apple~CloudDocs
#   Google Drive:       $HOME/Library/CloudStorage/GoogleDrive-you@gmail.com/My Drive
#   OneDrive:           $HOME/Library/CloudStorage/OneDrive-Personal
#   Local fallback:     $SCRIPT_DIR/backend/data/backups/
# ─────────────────────────────────────────────────────────────────────────────

cd "$SCRIPT_DIR/backend" || { echo " ERROR: backend folder not found."; exit 1; }

# ── Install backend dependencies if missing ──────────────────────────────────
if [ ! -d "node_modules" ]; then
    echo " [SETUP] First-time setup: installing backend packages..."
    echo " This may take 2-3 minutes. Please wait..."
    echo ""
    npm install
    if [ $? -ne 0 ]; then
        echo ""
        echo " ERROR: npm install failed. Make sure Node.js is installed."
        echo " Download from: https://nodejs.org"
        read -p " Press Enter to exit..."
        exit 1
    fi
    echo ""
    echo " [SETUP] Backend packages installed successfully!"
    echo ""
fi

# ── Build backend TypeScript if compiled output is missing ───────────────────
if [ ! -f "dist/server.js" ]; then
    echo " [SETUP] Compiling backend TypeScript..."
    npm run build
    if [ $? -ne 0 ]; then
        echo ""
        echo " ERROR: Backend build failed. Check TypeScript errors above."
        read -p " Press Enter to exit..."
        exit 1
    fi
    echo " [SETUP] Backend compiled successfully!"
    echo ""
fi

# ── Build frontend (React) if dist folder is missing ─────────────────────────
if [ ! -d "$SCRIPT_DIR/frontend/dist" ]; then
    echo " [SETUP] First-time setup: building the UI..."
    cd "$SCRIPT_DIR/frontend" || { echo " ERROR: frontend folder not found."; exit 1; }
    if [ ! -d "node_modules" ]; then
        echo " Installing frontend packages..."
        npm install
    fi
    npm run build
    if [ $? -ne 0 ]; then
        echo " ERROR: Frontend build failed."
        read -p " Press Enter to exit..."
        exit 1
    fi
    echo " [SETUP] UI built successfully!"
    echo ""
    cd "$SCRIPT_DIR/backend" || exit 1
fi

# ── Display network IP so other devices can connect ──────────────────────────
echo " Starting server on port 3001..."
echo " Open your browser and go to: http://localhost:3001"
echo ""
echo " To share with other Macs / devices on the same WiFi:"

# Get local IP address (ignore loopback / docker interfaces)
LOCAL_IP=$(ifconfig | grep "inet " | grep -v "127.0.0.1" | grep -v "169.254" | awk '{print $2}' | head -1)
if [ -n "$LOCAL_IP" ]; then
    echo " Other devices can access: http://$LOCAL_IP:3001"
else
    echo " (Could not detect your local IP — run 'ifconfig en0' to find it)"
fi

echo ""
echo " Keep this Terminal window open while using the app."
echo " To stop the server press Ctrl+C"
echo " ======================================================"
echo ""

# ── Start the server ─────────────────────────────────────────────────────────
node dist/server.js

echo ""
echo " Server stopped."
