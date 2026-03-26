# Run this script as Administrator to allow other PCs on LAN to access the app

$ruleName = "TeensClub-Registration"
$port = 3001

# Remove old rule if exists and recreate with correct profile
$existing = Get-NetFirewallRule -DisplayName $ruleName -ErrorAction SilentlyContinue
if ($existing) {
    Remove-NetFirewallRule -DisplayName $ruleName
    Write-Host "Old firewall rule removed. Recreating..." -ForegroundColor Yellow
}

New-NetFirewallRule -DisplayName $ruleName `
    -Direction Inbound `
    -Protocol TCP `
    -LocalPort $port `
    -Action Allow `
    -Profile Any `
    -Description "Allow Teens Club Registration app to be accessed from LAN"
Write-Host "Firewall rule added for port $port on ALL network profiles." -ForegroundColor Green

# Get real Wi-Fi IP (skip VMware, hotspot, loopback adapters)
$ip = (Get-NetIPAddress -AddressFamily IPv4 | Where-Object {
    $_.InterfaceAlias -like "*Wi-Fi*" -and
    $_.IPAddress -notlike "169.*"
} | Select-Object -First 1).IPAddress

# Fallback if Wi-Fi adapter has a different name
if (-not $ip) {
    $ip = (Get-NetIPAddress -AddressFamily IPv4 | Where-Object {
        $_.InterfaceAlias -notlike "*Loopback*" -and
        $_.InterfaceAlias -notlike "*VMware*" -and
        $_.InterfaceAlias -notlike "*vEthernet*" -and
        $_.InterfaceAlias -notlike "*Local Area Connection* 2*" -and
        $_.IPAddress -notlike "169.*"
    } | Select-Object -Last 1).IPAddress
}

Write-Host ""
Write-Host "Your Wi-Fi IP: $ip" -ForegroundColor Cyan
Write-Host "Other PCs can access: http://${ip}:${port}" -ForegroundColor Yellow
Write-Host ""
Read-Host "Press Enter to exit"
