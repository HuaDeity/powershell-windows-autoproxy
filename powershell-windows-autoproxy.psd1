@{
    # Script module or binary module file associated with this manifest.
    RootModule = 'powershell-windows-autoproxy.psm1'

    # Version number of this module.
    ModuleVersion = '0.3.0'

    # ID used to uniquely identify this module
    GUID = '0c173855-ba65-4568-b7d4-49708e58733d'

    # Author of this module
    Author = 'HuaDeity, and ChatGPT'

    # Description of the functionality provided by this module
    Description = 'Auto Set Proxy for Windows PowerShell'

    # Functions to export from this module
    FunctionsToExport = @(
        'proxy',
        'noproxy'
    )
}
