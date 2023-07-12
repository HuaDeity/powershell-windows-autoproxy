# powershell-windows-autoproxy

Auto Set Proxy for Windows PowerShell

## Install

```powershell
Install-Module -Name powershell-windows-autoproxy
```

## Usage

```powershell
Import-Module powershell-windows-autoproxy
```

Add this line to your powershell profile.

### WSL Support

```bash
# proxy
proxy_server=$(cat /etc/resolv.conf |grep "nameserver" |cut -f 2 -d " ")
host_proxy=$(pwsh.exe -Command \$env:all_proxy | tr -d '\r\n')
proxy_port=$(echo "$host_proxy" | awk -F':' '{print $3}')
proxy() {
  export http_proxy=http://$proxy_server:$proxy_port
  export https_proxy=http://$proxy_server:$proxy_port
  export all_proxy=socks5://$proxy_server:$proxy_port
  export no_proxy=$(pwsh.exe -Command \$env:no_proxy | tr -d '\r\n')
  git config --global http.proxy "http://$proxy_server:$proxy_port"
  git config --global https.proxy "http://$proxy_server:$proxy_port"
}
noproxy() {
  unset http_proxy
  unset https_proxy
  unset all_proxy
  unset no_proxy
  git config --global --unset http.proxy
  git config --global --unset https.proxy
}
if [ -n "host_proxy" ]; then
  proxy
else
  noproxy
fi
```

Add these to your WSL's .bashrc.

## Commands

```powershell
proxy
noproxy
```

There are two commands you can use.
