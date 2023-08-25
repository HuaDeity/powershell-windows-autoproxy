@{
    # Script module or binary module file associated with this manifest.
    RootModule = 'powershell-windows-autoproxy.psm1'

    # Version number of this module.
    ModuleVersion = '2.0.2'

    # ID used to uniquely identify this module
    GUID = '0c173855-ba65-4568-b7d4-49708e58733d'

    # Author of this module
    Author = 'HuaDeity, ChatGPT and Github Copilot'

    # Description of the functionality provided by this module
    Description = 'Auto Set Proxy for Windows PowerShell, WSL and WSA'

    # Functions to export from this module
    FunctionsToExport = @(
        'proxy',
        'noproxy'
    )
}
