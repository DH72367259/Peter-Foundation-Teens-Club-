# Teen's Club Registration System

A church-based teen registration and management system.  
One Mac or Windows PC runs the server; everyone else just opens a browser — no installation needed on other devices.

---

## Table of Contents

1. [First-Time Setup](#1-first-time-setup)
   - [Windows Setup](#windows-setup)
   - [Mac Setup](#mac-setup)
2. [Starting the App Every Day](#2-starting-the-app-every-day)
3. [User Roles — Who Does What](#3-user-roles--who-does-what)
4. [Complete Workflows — Step by Step](#4-complete-workflows--step-by-step)
   - [Admin](#41-admin-workflow)
   - [Data Entry](#42-data-entry-workflow)
   - [Mentor](#43-mentor-workflow)
   - [Spiritual Leader](#44-spiritual-leader-workflow)
5. [Key Pages & Features](#5-key-pages--features)
6. [Multi-PC / Network Setup](#6-multi-pc--network-setup)
7. [Database Backup](#7-database-backup)
8. [Default Login](#8-default-login)
9. [Troubleshooting](#9-troubleshooting)

---

## 1. First-Time Setup

> Do this **once** on the server Mac or PC (the main computer that will run the app).

---

### Windows Setup

#### Step 1 — Install Node.js (Windows)

1. Go to **https://nodejs.org**
2. Click the **LTS** (green) download button and install it
3. Restart the PC after install
4. Open **PowerShell** and confirm:
   ```
   node -v
   ```
   Should print something like `v20.x.x`

#### Step 2 — Extract the app (Windows)

1. Copy `TeensClubApp_v2.zip` to your PC
2. Right-click it → **Extract All** → extract to `C:\TeensClubApp_v2`

#### Step 3 — Install dependencies (Windows, one-time only)

Open **PowerShell** and run these commands **one at a time**:

```powershell
cd C:\TeensClubApp_v2\backend
npm install

cd C:\TeensClubApp_v2\frontend
npm install
npm run build
```

> This takes 2–5 minutes the first time. You only need to do this **once per PC**.

---

### Mac Setup

#### Step 1 — Install Node.js (Mac)

1. Go to **https://nodejs.org**
2. Click the **LTS** (green) download button and install the `.pkg` file
3. Open **Terminal** (search Spotlight → Terminal) and confirm:
   ```
   node -v
   ```
   Should print something like `v20.x.x`

#### Step 2 — Extract the app (Mac)

1. Copy `TeensClubApp_v2.zip` to your Mac (e.g. Desktop or Documents)
2. Double-click the ZIP — macOS extracts it automatically
3. Move the extracted folder to a permanent location, for example:  
   `~/Documents/TeensClubApp_v2`

#### Step 3 — Make the launcher executable (Mac, one-time only)

Open **Terminal** and run:

```bash
cd ~/Documents/TeensClubApp_v2
chmod +x StartServer.sh
chmod +x Setup-Mac.sh
```

#### Step 4 — Install dependencies (Mac, one-time only)

In the same Terminal window:

```bash
cd ~/Documents/TeensClubApp_v2/backend
npm install

cd ../frontend
npm install
npm run build
```

> This takes 2–5 minutes the first time. You only need to do this **once**.

---

## 2. Starting the App Every Day

### Windows

**Double-click** `C:\TeensClubApp_v2\StartServer.bat`

- A black terminal window will open — **keep it open** while the app is in use
- Open any browser (Chrome, Edge, Firefox) and go to:
  ```
  http://localhost:3001
  ```
- Log in with the admin account (or your personal account)

> ⚠️ Closing the terminal window shuts down the app for **everyone** on the network.

### Mac

Open **Terminal** and run:

```bash
bash ~/Documents/TeensClubApp_v2/StartServer.sh
```

Or create an alias for convenience — add this line to `~/.zshrc`:
```bash
alias teensclub="bash ~/Documents/TeensClubApp_v2/StartServer.sh"
```
Then just type `teensclub` in Terminal each day.

- The Terminal window shows the server address — **keep it open** while the app is in use
- Open any browser (Chrome, Safari, Firefox) and go to:
  ```
  http://localhost:3001
  ```
- To stop the server: press **Ctrl + C** in the Terminal window

> ⚠️ Closing the Terminal window shuts down the app for **everyone** on the network.

### Allow other devices to connect (LAN access)

**Windows:** Right-click `Setup-Firewall.ps1` → **Run with PowerShell** → click Yes

**Mac:** In Terminal, run:
```bash
sudo bash ~/Documents/TeensClubApp_v2/Setup-Mac.sh
```
(Enter your Mac password when prompted — it is not displayed as you type.)

---

## 3. User Roles — Who Does What

The system has **5 roles**. Each person is given exactly one role.

---

### 🔑 ADMIN — Full Control

**Who is this?** The system administrator (usually the church office manager or IT person).

**What they can do:**
- Everything in the system — no restrictions
- Create, edit, approve, and delete teen registrations
- Create and manage user accounts for all staff
- Assign mentors to teens
- View analytics and reports
- Approve or deny submitted registrations and edit requests
- Manage spiritual sessions (create, sign, unlock)
- Send records back to data-entry staff for corrections

**What happens when they log in:**
They land on a **Home Dashboard** showing pending counts and analytics links.

---

### 📝 DATA ENTRY — Registration Desk

**Who is this?** A volunteer at the registration desk who fills in forms when new teens join.

**What they can do:**
- Create new teen registrations (saved as a Draft)
- Edit their own draft and denied registrations
- Submit registrations for admin approval
- View the admin's feedback if a submission was sent back

**What they cannot do:**
- See the full Existing Data browsing page
- Approve anything
- See analytics

---

### 👨‍🏫 MENTOR — Teen Mentor

**Who is this?** A church volunteer assigned to personally guide specific teens.

**What they can do:**
- View detailed profiles of the teens assigned to them
- Browse the full approved Existing Data (read-only)
- Add and manage private session notes for their assigned teens
- Request permission from admin to edit a teen's profile
- Submit edited profiles back for admin re-approval
- View spiritual session records (read-only)
- View session notes for sessions they are part of

**What they cannot do:**
- Create new registrations
- See teens not assigned to them (except read-only browsing)
- Approve anything
- See analytics

**What happens when they log in:**
They go directly to their **Mentor Dashboard** showing their assigned teens, edit submissions, and notification banners.

---

### ✝️ SPIRITUAL LEADER — Sessions Leader

**Who is this?** The pastoral or spiritual leader who runs group and one-on-one sessions.

**What they can do:**
- Browse all approved teen profiles (read-only)
- Create and manage spiritual sessions (group, 1:1 with a teen, 1:1 with a mentor)
- Record attendance for each session
- Write group notes and individual private notes per teen
- Sign and lock session records once finished
- Add addon notes to already-signed sessions
- View mentor session notes for their teens
- View analytics & charts
- Assign students to groups with a clean table-format selection tool

**What they cannot do:**
- Create or edit teen registrations
- Manage user accounts

**What happens when they log in:**
They go directly to the **Existing Data** page and can access the **Spiritual** tab and **Analytics** tab.

---

### 📋 SUB — Sub Data Entry

**Who is this?** A temporary or substitute data-entry volunteer. Behaves exactly the same as DATA ENTRY.

---

## 4. Complete Workflows — Step by Step

---

### 4.1 Admin Workflow

#### Manage User Accounts

1. Log in as Admin → click **Users** in the top tab bar
2. Click **+ New User**
3. Fill in Full Name, Username, Password, and select a Role
4. Click **Create User**
5. To **deactivate** someone: click **Deactivate** next to their name
6. To **reset a password**: click **Reset Pwd**

#### Register a New Teen (Admin doing it directly)

1. Click **New Registration** in the tab bar
2. Fill in the teen's details (Teen Info tab) and parent details (Parent/Guardian tab)
3. Click **Save** — the record is immediately approved and signed (no review step for Admin)

#### Approve Pending Registrations

1. Click **Submissions** in the tab bar (badge shows pending count)
2. Click **👁 View** to read the full profile
3. Inside the view page:
   - Click **✅ Approve** to approve the registration
   - Click **❌ Deny** to send it back with a reason (enter reason when prompted)
   - Click **💾 Save** to save any notes/edits you made without approving yet
4. To approve many at once: tick checkboxes and click **✅ Approve Selected**

#### Handle Edit Requests

1. Click **Edit Requests** in the tab bar
2. Click **✅ Approve** to grant edit access, or **❌ Deny** with a reason
3. Batch approve: tick multiple and click **✅ Approve Selected**

#### Assign a Mentor to a Teen

1. Click **Mentors** in the tab bar
2. Select a mentor from the dropdown next to the teen → click **Assign**

---

### 4.2 Data Entry Workflow

#### Register a New Teen

1. Log in → go to **My Registrations**
2. Fill in teen details and parent details
3. Click **Save** — record saved as Draft

#### Submit for Admin Approval

1. In My Drafts, click **📤 Submit** next to a registration
2. Or click **📤 Submit All** to send all drafts

#### Fix a Denied Registration

1. Find the registration with the red "Changes Requested" banner
2. Click **✏️ Fix & Re-edit** → make corrections → click **Save**
3. Click **📤 Submit** to re-submit

---

### 4.3 Mentor Workflow

#### Sessions Tab

The **Sessions** tab is the central hub for all spiritual session activity:

- **Upcoming Sessions** — sessions you have been invited to; RSVP (Accept / Decline)
- **Completed ✅** — sessions that the Spiritual Leader has signed and closed
- **Approvals** — status of your 1:1 session requests

> ⚠️ Signed/completed sessions are **not** shown in Upcoming Sessions — they move to the Completed tab automatically.

#### View Your Assigned Teens

1. Log in → taken to **Mentor Dashboard** automatically
2. Assigned teens are listed with name, age, phone
3. Click a teen's name to open their full profile

#### Add a Session Note for a Teen

1. Open a teen's profile → click **🗒 Session Notes**
2. Click **+ Add Note**
3. Fill in: Session Date, Discussion, Outcome, Next steps
4. Click **Save Note**
5. Click **✍️ Sign Note** to lock it when satisfied

#### Request a 1:1 Session with the Spiritual Leader

1. Click **Sessions** → **Approvals** tab → **+ New Session Request**
2. Choose type and write a brief reason
3. Click **📤 Send Request**

#### Request Permission to Edit a Teen's Profile

1. Open the teen's profile → click **📩 Request Edit**
2. Write the reason → click **Submit Request**
3. Admin approves → you receive a notification → click **✏️ Edit Now**

---

### 4.4 Spiritual Leader Workflow

#### Active vs Completed Sessions

The **All Sessions** tab on the Spiritual page shows two sub-views:

- **Active** — sessions not yet signed
- **Completed** — sessions that have been signed and locked (read-only)

Once you **Sign** a session it automatically moves from Active to **Completed**.  
Signed sessions do **not** appear in Upcoming Sessions for any user.

#### Create a New Session

1. Log in → click **Spiritual** in the top tab bar
2. Click **+ New Session**
3. Choose session type:
   - **Group Session** — regular meeting with all teens and mentors
   - **1:1 with a Teen** — private session with one specific teen
   - **1:1 with a Mentor** — private session with one specific mentor
4. Enter the date and topic
5. For Group Sessions: click **Select Students** to open the student picker:
   - A clean table lists all students with checkboxes
   - Select as many as needed
   - Click **OK** to confirm — you return to the session form
6. Click **Create Session**

> ℹ️ There is no Back button on the session start page — navigate using the tab bar above.

#### Record Attendance

1. Open an existing session from the list
2. For **Group Sessions**: tick checkboxes next to teens/mentors who attended
3. For **1:1 Sessions**: tick the "Attended" toggle
4. Click **Save Attendance**

#### Write Notes

1. Open a session
2. In the **Group Note** field: write the overall discussion summary
3. For individual teens: click **+ Add Note for [Name]**
4. Click **Save** for each note

#### View Mentor Session Notes

1. Open any teen's profile from Existing Data
2. Click the **Session Notes** tab — you can see all mentor session notes for that teen

#### View Analytics

Click the **Analytics** tab in the top navigation bar to see charts and reports:
- Hobbies & interests breakdown
- Age groups
- Education levels
- Gender distribution
- Monthly registration trends

#### Sign a Session (Lock It)

1. Once complete and all notes written, click **✍️ Sign Session**
2. The session is now **locked** — moves to Completed; attendance and notes cannot be changed
3. For follow-up notes: use the **Addon Notes** section (has its own separate signature)

#### Approve or Deny 1:1 Requests from Mentors

1. In the Spiritual tab, click **Session Requests** (or the requests badge)
2. Review the mentor's request
3. Click **✅ Approve** to create and schedule the session
4. Click **❌ Deny** with a reason — the mentor sees the denial on their Approvals tab

#### Unlock a Session (Admin only)

An Admin can open any signed session and click **🔓 Unlock** to re-open it for editing.

---

## 5. Key Pages & Features

| Page | Who can access | What it does |
|---|---|---|
| **Home** | All | Dashboard — admin sees pending counts; others redirected to their main page |
| **New Registration** | Admin, Data Entry | Form to register a new teen — includes optional photo upload (JPG/PNG, max 200 KB) |
| **My Registrations** | Data Entry | Lists draft and denied registrations |
| **Submissions** | Admin | Pending registrations — approve/deny with full detail view |
| **Edit Requests** | Admin | Requests to unlock and edit a locked record |
| **Existing Data** | Admin, Mentor, Spiritual Leader | Browse/search all approved teen profiles — photo thumbnail shown in results |
| **Teen Profile** | Admin, Mentor, Spiritual Leader | Full profile — photo, details, parents, hobbies, session notes; admin can print/PDF |
| **Mentor Dashboard** | Mentor | Assigned teens, edit submissions, notification banners |
| **Mentors** | Admin | Assign/reassign mentors to teens |
| **Session Notes** | Admin, Mentor, Spiritual Leader | 1:1 mentoring notes per teen |
| **Spiritual** | Admin, Mentor (read-only), Spiritual Leader | Group and 1:1 spiritual sessions with attendance and notes |
| **Attendance** | Admin, Spiritual Leader | Overview of all teen and mentor attendance across sessions |
| **Analytics** | Admin, Spiritual Leader | Charts: hobbies, interests, age groups, education, gender, monthly registrations |
| **Users** | Admin | Create/deactivate user accounts; reset passwords |

---

### Registration Status Explained

| Status | What it means | Who can see it |
|---|---|---|
| 📝 **DRAFT** | Saved but not submitted | Data entry person who created it |
| ⏳ **PENDING** | Submitted, waiting for admin review | Admin (in Submissions page) |
| ✅ **APPROVED** | Admin has approved and signed it | Everyone |
| ❌ **DENIED** | Admin sent it back with a reason | Data entry person who created it |

---

### Admin View Page — Approve & Deny

When an Admin opens a submission from the Submissions or Edit Requests page, the view page shows:

- **💾 Save** — saves any notes/edits to the record (does not change approval status)
- **✅ Approve** — marks the record as approved and signed; it becomes live
- **❌ Deny** — prompts for a reason; record is sent back to the data-entry person

---

### Age & Date of Birth Logic

- If you enter a **Date of Birth** → the age is automatically calculated
- If you enter **Age only** (without DOB) → the DOB field is left blank; no backwards calculation happens
- The DOB field drives the age — not the other way around

---

### Login Error Messages

Error messages on the login page (e.g., wrong password, deactivated account) stay visible until you attempt another login or navigate away. They do **not** disappear automatically.

---

### Teen Photo Management

Each teen registration supports an optional profile photo (JPG or PNG, maximum **200 KB**).

| Scenario | Who can upload |
|---|---|
| **No photo on file** | Anyone with edit access — Admin, Data Entry, Mentor (if assigned) |
| **Photo already on file** | **Admin only** can replace it; others see it read-only |
| **Record is signed/locked** | Photo upload rules are the same — signing only locks the text data |

**Where photos appear:**
- 🔍 **Search & Filter results** (Existing Data page) — small circular avatar on each row
- 👤 **Teen Profile page** — larger photo on the left of the header
- 🖨 **Print / PDF** — photo printed in the top-right corner (admin only)

**How to upload a photo:**
1. Open the registration form (New Registration or Edit)
2. Scroll to the bottom of the **Kid / Teen Details** tab
3. Click **Choose File** under the 📷 Photo section
4. Select a JPG or PNG image under 200 KB
5. A preview will appear — click **Save Photo** (in edit mode) or the photo saves automatically with the registration (in new mode)

**How admin replaces a photo:**
1. Open the registration in edit mode
2. Scroll to the photo section — click **Choose File** to pick a new image
3. Preview appears → click **💾 Save New Photo** — the old photo is permanently replaced in the database

---

### Print / Download PDF (Admin only)

From any **Teen Profile** page, admin users see a **🖨 Print / PDF** button in the action bar.

Clicking it opens the browser's print dialog (standard OS print). Choose:
- **Print** to send to a physical printer
- **Save as PDF** (in the print dialog) to download a PDF file

The print layout includes:
- Teen name, Registration ID, and status
- **Photo in the top-right corner** (if one is on file)
- All personal details, education, contact, hobbies and interests
- Parent / guardian details
- Ambition / goal
- Printed date and signature information

---

### Lock / Sign Explained

| State | Meaning |
|---|---|
| ✍️ **Signed** | Record is finalized and locked — no edits without an unlock |
| 📝 **Unsigned** | Record can be freely edited by whoever has permission |

---

### Session Security & Auto-Logout

| Trigger | What happens |
|---|---|
| **10 minutes of inactivity** | App logs you out automatically |
| **Browser closed and reopened** | All login credentials cleared; must log in again |

---

## 6. Multi-PC / Network Setup

See **`MULTI-PC-SETUP.md`** for full instructions.

**Summary:**

| Device | What it needs |
|---|---|
| **Server Mac/PC** (one machine) | Node.js installed + extracted ZIP + launcher running |
| **All other devices** (phones, tablets, other laptops) | Just a browser — type the server's IP like `http://192.168.1.5:3001` |

**Find the server's IP address:**
- **Windows:** Open Command Prompt → type `ipconfig` → look for **IPv4 Address**
- **Mac:** Open Terminal → type `ifconfig en0` → look for **inet** address, e.g. `192.168.1.5`

**Allow other devices through the firewall:**
- **Windows:** Right-click `Setup-Firewall.ps1` → Run with PowerShell → Yes
- **Mac:** `sudo bash Setup-Mac.sh`

---

## 7. Database Backup

All data is stored in a single file:

**Windows:**
```
C:\TeensClubApp_v2\backend\data\teensclub.db
```

**Mac:**
```
~/Documents/TeensClubApp_v2/backend/data/teensclub.db
```

**To back up:** Copy this file to a USB drive, iCloud Drive, Google Drive, or email it to yourself.

**To restore:** Replace the file with your backup copy and restart the server.

> ⚠️ **Back up regularly** — daily if data entry is active, at minimum weekly.

The Admin can also trigger a backup from the browser: log in as Admin → **Home** page → **💾 Backup Now**.

---

## 8. Default Login

| Username | Password | Role |
|---|---|---|
| `admin` | `Admin@1234` | Admin (full access) |

> **Change the admin password** after first login: **Users** → **Reset Pwd** next to the admin account.

---

## 9. Troubleshooting

### Windows

| Problem | Solution |
|---|---|
| **App won't open in browser** | Make sure `StartServer.bat` is running and the window is open |
| **"Invalid credentials" on login** | Check username/password; passwords are case-sensitive |
| **Other PCs can't connect** | Run `Setup-Firewall.ps1` as Administrator; check both devices on same Wi-Fi |
| **Page shows "Record not found"** | Record may be deleted, or session expired — log out and back in |
| **Logged out unexpectedly** | App auto-logs out after 10 minutes of inactivity — log in again |
| **Server stopped working** | Close the window, double-click `StartServer.bat` again |
| **"Cannot find module" error** | Run `cd backend && npm install` in PowerShell |

**Port 3001 in use?**
```powershell
netstat -ano | findstr :3001
# Kill the PID shown, or change PORT in backend/.env
```

**Add Windows Firewall rule manually:**
```powershell
# Run as Administrator:
netsh advfirewall firewall add rule name="TeensClub" dir=in action=allow protocol=TCP localport=3001
```

---

### Mac

| Problem | Solution |
|---|---|
| **App won't open in browser** | Make sure `StartServer.sh` is running in Terminal |
| **"Permission denied" when running StartServer.sh** | Run `chmod +x StartServer.sh` first |
| **Other devices can't connect** | Run `sudo bash Setup-Mac.sh`; check both devices are on same Wi-Fi |
| **"command not found: node"** | Node.js not installed — download from https://nodejs.org |
| **"Cannot find module" error** | Run `cd backend && npm install` in Terminal |
| **Port 3001 already in use** | Run `lsof -i :3001` to find the process, then `kill -9 [PID]` |

**Find your Mac's IP address:**
```bash
ifconfig en0 | grep "inet " | awk '{print $2}'
# Or check: System Settings → Wi-Fi → Details → IP Address
```

**Check if port 3001 is open:**
```bash
lsof -i :3001
```

---

## Quick Start (Development)

### Prerequisites
- [Node.js 18 or 20](https://nodejs.org/en/download) — Install LTS version
- npm (comes with Node.js)

### 1. Install all dependencies

**Windows (PowerShell):**
```powershell
cd backend && npm install
cd ..\frontend && npm install
```

**Mac (Terminal):**
```bash
cd backend && npm install
cd ../frontend && npm install
```

### 2. Start the backend server

**Windows:**
```powershell
cd backend
npm run dev
```

**Mac:**
```bash
cd backend
npm run dev
```

The backend starts on `http://localhost:3001`  
Default admin: **username: `admin`** / **password: `Admin@1234`**

### 3. Start the frontend (dev mode)

In a **new terminal window:**

**Windows:**
```powershell
cd frontend
npm run dev
```

**Mac:**
```bash
cd frontend
npm run dev
```

Open browser: `http://localhost:5173`

### 4. LAN Access (Other Devices)

Once the backend is running, other devices on the same Wi-Fi can open:
```
http://YOUR-SERVER-IP:3001
```

**Find your IP:**
- **Windows:** `ipconfig` → IPv4 Address
- **Mac:** `ifconfig en0 | grep inet`

---

## Build for Production

### Windows

```powershell
cd backend && npm run build
cd ..\frontend && npm run build
```

Then run `StartServer.bat` — it auto-detects the pre-built files.

### Mac

```bash
cd backend && npm run build
cd ../frontend && npm run build
```

Then run `bash StartServer.sh` — it auto-detects the pre-built files.

---

## Database

- Uses **SQLite** — no separate database server needed
- **Windows path:** `C:\TeensClubApp_v2\backend\data\teensclub.db`
- **Mac path:** `~/Documents/TeensClubApp_v2/backend/data/teensclub.db`
- To backup: copy the `.db` file
- To restore: replace the `.db` file and restart

---

## User Roles

| Action | ADMIN | DATA_ENTRY | MENTOR | SPIRITUAL_LEADER | SUB |
|---|:---:|:---:|:---:|:---:|:---:|
| Add / Edit registrations | ✅ | ✅ | ❌ | ❌ | ❌ |
| Delete records (soft) | ✅ | ❌ | ❌ | ❌ | ❌ |
| View / Search all students | ✅ | ✅ | ❌ | ❌ | ✅ |
| View assigned teens only | ✅ | ✅ | ✅ | ❌ | ✅ |
| Analytics & Charts | ✅ | ❌ | ❌ | ✅ | ❌ |
| Assign teens to mentors | ✅ | ❌ | ❌ | ❌ | ❌ |
| User Management | ✅ | ❌ | ❌ | ❌ | ❌ |
| Mentor Dashboard & Notes | ✅ | ❌ | ✅ | ❌ | ❌ |
| View Mentor Notes (read) | ✅ | ❌ | ✅ | ✅ | ❌ |
| Spiritual Sessions (write) | ✅ | ❌ | ❌ | ✅ | ❌ |
| Spiritual Sessions (read) | ✅ | ❌ | ✅ (own teens) | ✅ | ❌ |

### Role descriptions

| Role | Give this to... |
|---|---|
| **ADMIN** | Church administrator — full access to everything |
| **DATA_ENTRY** | Registration desk staff / volunteer |
| **MENTOR** | Church mentor — sees assigned teens, adds session notes |
| **SPIRITUAL_LEADER** | Spiritual sessions leader — sessions, attendance, notes, analytics |
| **SUB** | Read-only viewer — can search and view registrations |

---

## Tech Stack

- **Frontend**: React + TypeScript + Vite + React Router + Recharts
- **Backend**: Node.js + Express + TypeScript + better-sqlite3
- **Auth**: JWT + bcrypt
- **Database**: SQLite (file-based, zero config)

---

*Teen's Club Registration System — Church Management Software*  
*Supports: Windows 10/11 · macOS 12 (Monterey) or later*
