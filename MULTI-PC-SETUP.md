# Accessing the Application from Multiple Systems

This guide explains how to run the Teen's Club app across multiple computers on the same network so all users share **one database**.

> **Note on Photos:** Teen profile photos are stored directly in the database file (`teensclub.db`). This means photos work automatically across all connected devices — no extra file sharing needed. The database backup includes all photos.

---

## How It Works

Only **one Mac or PC runs the server** (System A). All other devices just open a web browser — no installation needed on them.

```
                 ┌─────────────────────────────────┐
                 │   SYSTEM A  (Server Mac or PC)   │
                 │   StartServer.sh / .bat running  │
                 │   SQLite database stored here    │
                 │   http://192.168.1.5:3001        │
                 └──────────────┬──────────────────┘
                                │  Same Wi-Fi / Office Network
            ┌───────────────────┼───────────────────┐
            │                   │                   │
 ┌──────────▼───────┐  ┌────────▼─────────┐  ┌─────▼────────────┐
 │  SYSTEM B        │  │  SYSTEM C        │  │  SYSTEM D ...    │
 │  Browser only    │  │  Browser only    │  │  Browser only    │
 │  No install      │  │  No install      │  │  No install      │
 └──────────────────┘  └──────────────────┘  └──────────────────┘
```

---

## SYSTEM A — Server Setup (Do This Once)

This is the Mac or PC where the app files are installed and the server runs.

---

### SYSTEM A — Windows PC

#### Step 1 — Install and start the server

1. Extract `TeensClubApp_v2.zip` to `C:\TeensClubApp_v2`
2. Double-click **`StartServer.bat`**
3. Wait for it to show:
   ```
   ✅ Teen's Club Server running!
      Local:   http://localhost:3001
      Network: http://192.168.1.5:3001  ← share this with other PCs
   ```

#### Step 2 — Allow other PCs/devices to connect (Windows firewall)

Right-click `Setup-Firewall.ps1` → **Run with PowerShell** → click Yes  
*(This opens port 3001 so other devices on the network can reach the server)*

#### Step 3 — Find your Network IP (if needed)

Open **Command Prompt** and type:
```
ipconfig
```
Look for **IPv4 Address** under your active network adapter, e.g.:
```
IPv4 Address. . . . . : 192.168.1.5   ← this is your IP
```

#### Step 4 — Keep the server running

> ⚠️ **Do NOT close the StartServer.bat window** while others are using the app.  
> Closing it shuts down the server for all connected users immediately.

---

### SYSTEM A — Mac

#### Step 1 — Make scripts executable (one-time only)

Open **Terminal** and run:
```bash
cd ~/Documents/TeensClubApp_v2
chmod +x StartServer.sh
chmod +x Setup-Mac.sh
```

#### Step 2 — Install and start the server

In Terminal:
```bash
bash ~/Documents/TeensClubApp_v2/StartServer.sh
```

Wait for it to show:
```
✅ Teen's Club Server running!
   Local:   http://localhost:3001
   Network: http://192.168.1.5:3001  ← share this with other devices
```

#### Step 3 — Allow other devices to connect (Mac firewall)

In a **new** Terminal tab:
```bash
sudo bash ~/Documents/TeensClubApp_v2/Setup-Mac.sh
```
Enter your Mac password when prompted (nothing will appear as you type — this is normal).

#### Step 4 — Find your Mac's Network IP (if needed)

```bash
ifconfig en0 | grep "inet "
```
Look for the `inet` line, e.g.:
```
inet 192.168.1.5 netmask 0xffffff00   ← this is your IP
```

Or check: **System Settings → Wi-Fi → Details → IP Address**

#### Step 5 — Keep the server running

> ⚠️ **Do NOT close the Terminal window** while others are using the app.  
> Press **Ctrl + C** only when you want to stop the server intentionally.

---

## SYSTEM B, C, D ... — Client Devices (Browser Only)

No files, no installation, no Node.js needed on client devices.

### Steps (any device — Windows, Mac, iPhone, Android):

1. Make sure this device is on the **same Wi-Fi or office network** as System A
2. Open any browser — **Chrome**, **Edge**, **Firefox**, **Safari**
3. In the address bar, type the Network address from System A, for example:
   ```
   http://192.168.1.5:3001
   ```
   *(replace `192.168.1.5` with System A's actual IP)*
4. The login page appears — enter the username and password given by your Admin

---

## Creating User Accounts for Each Person

The Admin creates accounts for all other users. This is done once per person.

1. Log in on any device with `admin / Admin@1234`
2. Click **User Management** on the home screen
3. Click **+ New User**
4. Fill in:
   - **Full Name** — person's real name
   - **Username** — what they'll type to log in (no spaces, e.g. `john.data`)
   - **Password** — set a strong password, share it privately
   - **Role** — choose based on what they need to do:
     - `DATA_ENTRY` — registration desk / data entry volunteer
     - `MENTOR` — mentor assigned to specific teens
     - `SPIRITUAL_LEADER` — spiritual sessions leader
     - `ADMIN` — full access (use carefully)
     - `SUB` — read-only viewer
5. Give the username and password to that person

---

## Role Access — What Each User Can Do

| Feature | ADMIN | DATA_ENTRY | MENTOR | SPIRITUAL_LEADER | SUB |
|---|:---:|:---:|:---:|:---:|:---:|
| New Registration (add student) | ✅ | ✅ | ❌ | ❌ | ❌ |
| Edit existing records | ✅ | ✅ | ❌ | ❌ | ❌ |
| View / Search all students | ✅ | ✅ | ❌ | ❌ | ✅ |
| View assigned teens only | ✅ | ✅ | ✅ | ❌ | ✅ |
| Delete records | ✅ | ❌ | ❌ | ❌ | ❌ |
| Analytics & Charts | ✅ | ❌ | ❌ | ✅ | ❌ |
| User Management | ✅ | ❌ | ❌ | ❌ | ❌ |
| Assign teens to mentors | ✅ | ❌ | ❌ | ❌ | ❌ |
| Session Notes (own teens only) | ✅ | ❌ | ✅ | ✅ (read) | ❌ |
| Spiritual Sessions (write) | ✅ | ❌ | ❌ | ✅ | ❌ |
| Spiritual Sessions (read) | ✅ | ❌ | ✅ (own teens) | ✅ | ❌ |

### When to use each role:

| Role | Give this to... |
|---|---|
| **ADMIN** | Church administrator, IT person, senior leader |
| **DATA_ENTRY** | Registration desk staff, secretary, volunteer who enters forms |
| **MENTOR** | Church mentor assigned to a group of teens |
| **SPIRITUAL_LEADER** | Leader who runs spiritual group sessions and 1:1 meetings |
| **SUB** | Read-only viewer who only needs to look up records |

---

## Daily Usage

| Task | Who does it | Windows | Mac |
|---|---|---|---|
| Start the server | System A operator | Double-click `StartServer.bat` | `bash StartServer.sh` in Terminal |
| Open the app | Any device | Browser → `http://[System A IP]:3001` | Browser → `http://[System A IP]:3001` |
| Stop the server | System A operator | Close the `StartServer.bat` window | Press **Ctrl+C** in Terminal |
| Backup the database | Admin | Copy `C:\TeensClubApp_v2\backend\data\teensclub.db` | Copy `~/Documents/TeensClubApp_v2/backend/data/teensclub.db` |

---

## Troubleshooting

### System B/C cannot open the app

| Check | How |
|---|---|
| Is System A's server running? | The startup window/terminal must be open and showing "running" |
| Are both devices on the same network? | Both must be on the same Wi-Fi or LAN |
| Has the firewall been configured? | Run `Setup-Firewall.ps1` (Windows) or `sudo bash Setup-Mac.sh` (Mac) on System A |
| Is the IP address correct? | Run `ipconfig` (Windows) or `ifconfig en0` (Mac) on System A to confirm |

---

### The IP address changed after restart

Home and office routers sometimes assign a new IP to a PC/Mac after restart.

**Windows — Set a static IP:**
1. Open **Settings** → **Network & Internet** → **Ethernet** or **Wi-Fi** → **Hardware properties**
2. Click **Edit** next to IP assignment → choose **Manual**
3. Set: IPv4 = `192.168.1.50`, Subnet = `255.255.255.0`, Gateway = `192.168.1.1`

**Mac — Set a static IP:**
1. Open **System Settings** → **Wi-Fi** → **Details...**
2. Click **TCP/IP** tab → set **Configure IPv4** to **Manually**
3. Set: IP Address = `192.168.1.50`, Subnet = `255.255.255.0`, Router = `192.168.1.1`

**Option — Check IP each day:**  
Run `ipconfig` (Windows) or `ifconfig en0` (Mac) each morning and share the updated IP.

---

### "Cannot find module" error when starting server

**Windows:**
```powershell
cd C:\TeensClubApp_v2\backend
npm install
cd ..\frontend
npm install
```

**Mac:**
```bash
cd ~/Documents/TeensClubApp_v2/backend
npm install
cd ../frontend
npm install
```

---

### Permission denied (Mac only)

```bash
chmod +x StartServer.sh
chmod +x Setup-Mac.sh
```

---

## Network Requirements

- All devices must be on the **same local network** (same office Wi-Fi or wired LAN)
- Port **3001** must not be blocked (the firewall script handles this)
- No internet required after first setup — works fully offline
- Supports any device with a modern browser: PC, Mac, laptop, tablet, phone

---

## Database Backup (Important!)

### Automatic Backups (Built-in)

The server automatically backs up the database every hour.

**Where backups are saved:**

**Windows:**
| If installed on System A | Backups go to |
|---|---|
| **Google Drive for Desktop** | `My Drive\TeensClub Backups\` |
| **OneDrive** | `OneDrive\TeensClub Backups\` |
| None of the above | `C:\TeensClubApp_v2\backend\data\backups\` |

**Mac:**
| If installed on System A | Backups go to |
|---|---|
| **iCloud Drive** | `iCloud Drive/TeensClub Backups/` |
| **Google Drive** | `Google Drive/My Drive/TeensClub Backups/` |
| **OneDrive** | `OneDrive/TeensClub Backups/` |
| None of the above | `~/Documents/TeensClubApp_v2/backend/data/backups/` |

---

### Manual Backup (Admin Home Page)

1. Log in as Admin
2. On the **Home** page, find the **💾 Backup** card
3. Click **💾 Backup Now** to back up immediately

---

### Custom Backup Path

**Windows** — open `StartServer.bat` in Notepad and uncomment:
```bat
set GDRIVE_BACKUP_PATH=C:\Users\YourName\My Drive
```

**Mac** — open `StartServer.sh` in a text editor and uncomment:
```bash
export GDRIVE_BACKUP_PATH="$HOME/Library/Mobile Documents/com~apple~CloudDocs/TeensClub Backups"
```
