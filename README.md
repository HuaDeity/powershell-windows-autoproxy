# powershell-windows-autoproxy

Auto Set Proxy for Windows PowerShell, WSL and WSA

## If you use Windows for Development, I highly recommend use Clash TUN mode or Router Proxy such as OpenClash or Surge.

## Requirements

Set system proxy on your Windows.

## Install

```powershell
Install-Module -Name powershell-windows-autoproxy
```

## Usage

### PowerShell

Add the following to your PowerShell profile:

```powershell
Import-Module powershell-windows-autoproxy
```

### WSL

Download [wsl-autoproxy.sh](https://github.com/HuaDeity/powershell-windows-autoproxy/blob/main/wsl-autoproxy.sh) to your WSL home directory.  
Add the following to your .bashrc

```bash
source ~/.wsl-autoproxy.sh
```

WARNING: If you are in Windows Insider Dev Channel, Windows will make auto-proxy for your WSL, in such case you cannot use Windows local proxy, because it will set 127.0.0.1 for your WSL. Please refer to [How to use Clash on Linux](https://blog.zzsqwq.cn/posts/how-to-use-clash-on-linux/)

### WSA

Please toggle your WSA's Developer mode in Windows Subsystem for Android -> Advanced settings -> Developer mode.

First time you have to allow adb to access your WSA.
And everything will set automately.

WARNING: If you are in Windows Insider Dev Channel, the vEthernet (WSLCore) interface has been removed, which is used to proxy for WSA. I have no idea how to use Windows proxy for WSA then.

## Commands

```powershell
proxy
noproxy
```

There are two commands you can use.

## See Also

Waiting for Linux user making bash-linux-autoproxy.

[zsh-osx-autoproxy](https://github.com/HuaDeity/zsh-osx-autoproxy)
