$proxyEnable = (Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings').ProxyEnable
$proxyServer = (Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings').ProxyServer
$proxyOverride = (Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings').ProxyOverride
$no_proxy = ($proxyOverride -split ";") -join ","

function proxy {
    if ($proxyServer) {
        [Environment]::SetEnvironmentVariable("http_proxy", "http://$proxyServer")
        [Environment]::SetEnvironmentVariable("https_proxy", "http://$proxyServer")
        [Environment]::SetEnvironmentVariable("all_proxy", "socks5://$proxyServer")
        [Environment]::SetEnvironmentVariable("no_proxy", $no_proxy)
        git config --global http.proxy "http://$proxyServer"
        git config --global https.proxy "http://$proxyServer"
    }
}

function noproxy {
    [Environment]::SetEnvironmentVariable("http_proxy", $null)
    [Environment]::SetEnvironmentVariable("https_proxy", $null)
    [Environment]::SetEnvironmentVariable("all_proxy", $null)
    [Environment]::SetEnvironmentVariable("no_proxy", $null)
    git config --global --unset http.proxy
    git config --global --unset https.proxy
}

if ($proxyEnable) {
    proxy
} else {
    noproxy
}

$exportModuleMemberParams = @{
    Function = @(
        'proxy',
        'noproxy'
    )
}

Export-ModuleMember @exportModuleMemberParams