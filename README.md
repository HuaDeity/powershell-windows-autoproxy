# powershell-windows-autoproxy

Auto Set Proxy for Windows PowerShell, WSL and WSA

## If you use Windows for Development, I highly recommend use Clash TUN mode or Router such as OpenClash or Surge. For the compatibility reason, I comment the WSL and WSA setting.

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

Download wsl-autoproxy.sh to your WSL home directory.  
Add the following to your .bashrc
```bash
source ~/.wsl-autoproxy.sh
```

If you are in Windows Insider Dev Channel, Windows will make auto-proxy for your WSL, in such case you cannot use local proxy, because
it will set 127.0.0.1 for your WSL, it is wrong.

### WSA
Please toggle your WSA's Developer mode in Windows Subsystem for Android -> Advanced settings -> Developer mode.

First time you have to allow adb to access your WSA.
And everything will set automately.

If you are in Windows Insider Dev Channel, it cannot auto-proxy for WSA.

## Commands

```powershell
proxy
noproxy
```

There are two commands you can use.
