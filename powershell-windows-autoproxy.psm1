$proxyEnable = (Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings').ProxyEnable
$proxyServer = (Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings').ProxyServer
$proxyOverride = (Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings').ProxyOverride
$no_proxy = ($proxyOverride -split ";") -join ","

function proxy {
    if ($proxyServer) {
        $env:http_proxy = "http://$proxyServer"
        $env:https_proxy = "http://$proxyServer"
        git config --global http.proxy "http://$proxyServer"
        git config --global https.proxy "http://$proxyServer"
    }
}

function noproxy {
    $env:http_proxy = $null
    $env:https_proxy = $null
    git config --global --unset http.proxy
    git config --global --unset https.proxy
    $env:no_proxy = $null
}

if ($proxyEnable) {
    proxy
    $env:no_proxy = $no_proxy
}

$exportModuleMemberParams = @{
    Function = @(
        'proxy',
        'noproxy'
    )
}

Export-ModuleMember @exportModuleMemberParams