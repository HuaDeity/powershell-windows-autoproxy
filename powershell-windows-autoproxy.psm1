function proxy {
    $proxySettings = (Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings').ProxyServer
    if ($proxySettings) {
        $env:http_proxy = "http://$proxySettings"
        $env:https_proxy = "http://$proxySettings"
    }
}

function noproxy {
    $env:http_proxy = $null
    $env:https_proxy = $null
}

$exportModuleMemberParams = @{
    Function = @(
        'proxy',
        'noproxy'
    )
}

Export-ModuleMember @exportModuleMemberParams