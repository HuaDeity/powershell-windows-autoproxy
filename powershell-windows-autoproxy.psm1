$proxyInfo = Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings'

# Base
$proxyEnable = $proxyInfo.ProxyEnable
$proxyServer = $proxyInfo.ProxyServer
$proxyPort = $proxyServer.Split(':')[1]
$proxyOverride = $proxyInfo.ProxyOverride
$no_proxy = ($proxyOverride -split ";") -join ","
$no_proxy = $no_proxy -replace "(,|^)<local>(,|$)", "$1$2"
$checkProxy = [Environment]::GetEnvironmentVariable('http_proxy')

# WSA
$WsaService = Get-Service -Name WsaService -ErrorAction SilentlyContinue
if ($WsaService) {
    $WsaEnabled = $WsaService.Status -eq 'Running'
    $adbCommand = Get-Command -Name adb -ErrorAction SilentlyContinue
    if ( $proxyServer -eq "127.0.0.1" ){
        $WsaIP = $(Get-NetIPAddress -InterfaceAlias 'vEthernet (WSLCore)' -AddressFamily IPV4).IPAddress
    } else {
        $WsaIP = $proxyServer.Split(':')[0]
    }
}

function proxy {
    if ($proxyServer) {
        # PowerShell
        [Environment]::SetEnvironmentVariable("http_proxy", "http://$proxyServer")
        [Environment]::SetEnvironmentVariable("https_proxy", "http://$proxyServer")
        # [Environment]::SetEnvironmentVariable("all_proxy", "socks5://$proxyServer")
        [Environment]::SetEnvironmentVariable("no_proxy", $no_proxy)
        git config --global http.proxy "http://$proxyServer"
        git config --global https.proxy "http://$proxyServer"

        # WSA
        if ($WsaEnabled) {
            if (-not $adbCommand) {
                Write-Host "adb command not found. Installing adb..."
                winget install Google.PlatformTools
            } else {
                adb connect 127.0.0.1:58526
                if (adb devices | Select-String -Pattern "device$") {
                    adb shell settings put global http_proxy ${WsaIP}:${proxyPort}
                }
            }
        }
    }
}

function noproxy {
    # PowerShell
    [Environment]::SetEnvironmentVariable("http_proxy", $null)
    [Environment]::SetEnvironmentVariable("https_proxy", $null)
    # [Environment]::SetEnvironmentVariable("all_proxy", $null)
    [Environment]::SetEnvironmentVariable("no_proxy", $null)
    git config --global --unset http.proxy
    git config --global --unset https.proxy

    # WSA
    if ($WsaEnabled) {
        if (adb devices | Select-String -Pattern "device$") {
            adb shell settings put global http_proxy :0
        }
    } 
}

if ($proxyEnable) {
    proxy
} 
elseif ($checkProxy) {
    noproxy
}

$exportModuleMemberParams = @{
    Function = @(
        'proxy',
        'noproxy'
    )
}

Export-ModuleMember @exportModuleMemberParams