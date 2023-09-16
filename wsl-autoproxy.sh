#!/bin/bash

proxyEnable=$(powershell.exe -Command "(Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings').ProxyEnable")
proxyEnable=$(echo "$proxyEnable" | sed 's/ //g; s/\r//g')
proxyServer=$(powershell.exe -Command "(Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings').ProxyServer")
proxyOverride=$(powershell.exe -Command "(Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings').ProxyOverride")
proxyOverride=$(echo "$proxyOverride" | sed 's/;/,/g')
proxyOverride=$(echo "$proxyOverride" | sed 's/<local>//g; s/<local>,//g; s/,<local>//g')

proxy() {
    export http_proxy="http://$proxyServer"
    export https_proxy="http://$proxyServer"
    # export all_proxy="socks5://$proxyServer"
    export no_proxy="$proxyOverride"
    git config --global http.proxy "http://$proxyServer"
    git config --global https.proxy "http://$proxyServer"
}

noproxy() {
    unset http_proxy
    unset https_proxy
    # unset all_proxy
    unset no_proxy
    git config --global --unset http.proxy
    git config --global --unset https.proxy
}


if [ $proxyEnable = "1" ]; then
    proxy
else
    noproxy
fi