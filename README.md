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

If you want to add WSL Support, just change above command:

```powershell
## If you have mutiple WSL distributions, you can set multiple path, just divide theme with comma

$WslPath = "\\wsl$\Ubuntu\home\huadeity"
Import-Module powershell-windows-autoproxy -ArgumentList (,$WslPath)
```

Usually WSL Home Path looks like above, just change the distribution and username.

Then add the following to your WSL's .bashrc:
```bash
source ~/.proxy.sh
```

### WSA
Please toggle your WSA's Developer mode in Windows Subsystem for Android -> Advanced settings -> Developer mode.

First time you have to allow adb to access your WSA.
And everything will set automately.


## Commands

```powershell
proxy
noproxy
```

There are two commands you can use.
