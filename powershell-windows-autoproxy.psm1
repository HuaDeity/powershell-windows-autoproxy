$proxyEnabled = (Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings').ProxyEnable
$proxySettings = (Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings').ProxyServer

function proxy {
    if ($proxySettings) {
        $env:http_proxy = "http://$proxySettings"
        $env:https_proxy = "http://$proxySettings"
    }
}

function noproxy {
    $env:http_proxy = $null
    $env:https_proxy = $null
}

if ($proxyEnabled -eq 1) {
    proxy
}

$exportModuleMemberParams = @{
    Function = @(
        'proxy',
        'noproxy'
    )
}

Export-ModuleMember @exportModuleMemberParams