# param (
#     [string[]]$WslPath
# )

# Base
$proxyEnable = (Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings').ProxyEnable
$proxyServer = (Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings').ProxyServer
$proxyPort = $proxyServer.Split(':')[1]
$proxyOverride = (Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings').ProxyOverride
$no_proxy = ($proxyOverride -split ";") -join ","
$no_proxy = $no_proxy -replace ",<local>", ""
$checkProxy = [Environment]::GetEnvironmentVariable('http_proxy')

# # WSA
# $WsaService = Get-Service -Name WsaService -ErrorAction SilentlyContinue
# if ($WsaService) {
#     $WsaEnabled = $WsaService.Status -eq 'Running'
#     $adbCommand = Get-Command -Name adb -ErrorAction SilentlyContinue
#     # $WsaIP=$(Get-NetIPAddress -InterfaceAlias 'vEthernet (WSLCore)' -AddressFamily IPV4).IPAddress
#     $WsaIP = 192.168.31.1
# }

# # WSL
# $WslService = Get-Service -Name WslService -ErrorAction SilentlyContinue
# if ($WslService) {
#     $WslIP=$(Get-NetIPAddress -InterfaceAlias 'vEthernet (WSL)' -AddressFamily IPV4).IPAddress
#     $WslProxyContent = "export http_proxy=http://${WslIP}:${proxyPort}"
#     $WslProxyContent += "`nexport https_proxy=http://${WslIP}:${proxyPort}"
#     $WslProxyContent += "`nexport all_proxy=socks5://${WslIP}:${proxyPort}"
#     $WslProxyContent += "`nexport no_proxy=${no_proxy}"
#     $WslProxyContent += "`ngit config --global http.proxy http://${WslIP}:${proxyPort}"
#     $WslProxyContent += "`ngit config --global https.proxy http://${WslIP}:${proxyPort}"

#     $WslNoProxyContent = "git config --global --unset http.proxy"
#     $WslNoProxyContent += "`ngit config --global --unset https.proxy"
# }

function proxy {
    if ($proxyServer) {
        # PowerShell
        [Environment]::SetEnvironmentVariable("http_proxy", "http://$proxyServer")
        [Environment]::SetEnvironmentVariable("https_proxy", "http://$proxyServer")
        [Environment]::SetEnvironmentVariable("all_proxy", "socks5://$proxyServer")
        [Environment]::SetEnvironmentVariable("no_proxy", $no_proxy)
        git config --global http.proxy "http://$proxyServer"
        git config --global https.proxy "http://$proxyServer"

        # # WSA
        # if ($WsaEnabled) {
        #     if (-not $adbCommand) {
        #         Write-Host "adb command not found. Installing adb..."
        #         winget install Google.PlatformTools
        #     } else {
        #         adb connect 127.0.0.1:58526
        #         if (adb devices | Select-String -Pattern "device$") {
        #             adb shell settings put global http_proxy ${WsaIP}:${proxyPort}
        #         }
        #     }
        # }

        # # WSL
        # if($WslPath) {
        #     foreach ($path in $WslPath) {
        #         $WslProxyContent | Out-File -FilePath "$path\.proxy.sh" -Encoding utf8 -NoNewline
        #     }
        # }
    }
}

function noproxy {
    # PowerShell
    [Environment]::SetEnvironmentVariable("http_proxy", $null)
    [Environment]::SetEnvironmentVariable("https_proxy", $null)
    [Environment]::SetEnvironmentVariable("all_proxy", $null)
    [Environment]::SetEnvironmentVariable("no_proxy", $null)
    git config --global --unset http.proxy
    git config --global --unset https.proxy

    # # WSA
    # if ($WsaEnabled) {
    #     if (adb devices | Select-String -Pattern "device$") {
    #         adb shell settings put global http_proxy :0
    #     }
    # } 

    # # WSL
    # if($WslPath) {
    #     foreach ($path in $WslPath) {
    #         $WslNoProxyContent | Out-File -FilePath "$path\.proxy.sh" -Encoding utf8 -NoNewline
    #     }
    # }
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