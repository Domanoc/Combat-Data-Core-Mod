function MirrorFolder {
    param (
        [Parameter(Mandatory = $true)]
        [string]$SourceFolder,
        [Parameter(Mandatory = $true)]
        [string]$DestinationFolder
    )
    robocopy $SourceFolder $DestinationFolder /MIR /R:1 /W:3 /V /TEE /LOG+:MirrorDefinitions.log

    # Normalize exit codes (0–7 = success)
    if ($LastExitCode -gt 7) {
        exit $LastExitCode
    }
}

"" | Set-Content "MirrorDefinitions.log"

# The _GameDefinitions Source
$GameDefinitions = "D:\Mod Projects\Mech Engineer Mods\src\ModFramework\_GameDefinitions"

# The Destinations
$ExampleMod = "D:\Mod Projects\Mech Engineer Mods\src\ModFramework Example Mod\_GameDefinitions"
$ModTemplate = "D:\Mod Projects\Mech Engineer Mods\src\ModTemplate\_GameDefinitions"
$CombatDataCore = "D:\Mod Projects\Mech Engineer Mods\src\Combat Data Core\_GameDefinitions"
$DirectControl = "D:\Mod Projects\Mech Engineer Mods\src\Direct Control\_GameDefinitions"

# Mirror _GameDefinitions
MirrorFolder -SourceFolder $GameDefinitions -DestinationFolder $ExampleMod
MirrorFolder -SourceFolder $GameDefinitions -DestinationFolder $ModTemplate
MirrorFolder -SourceFolder $GameDefinitions -DestinationFolder $CombatDataCore
MirrorFolder -SourceFolder $GameDefinitions -DestinationFolder $DirectControl

# The _GameDefinitions Source
$ModFrameworkDefinitions = "D:\Mod Projects\Mech Engineer Mods\src\ModFramework\_ModFrameworkDefinitions"

# The Destinations
$ExampleMod = "D:\Mod Projects\Mech Engineer Mods\src\ModFramework Example Mod\_ModFrameworkDefinitions"
$ModTemplate = "D:\Mod Projects\Mech Engineer Mods\src\ModTemplate\_ModFrameworkDefinitions"
$CombatDataCore = "D:\Mod Projects\Mech Engineer Mods\src\Combat Data Core\_ModFrameworkDefinitions"
$DirectControl = "D:\Mod Projects\Mech Engineer Mods\src\Direct Control\_ModFrameworkDefinitions"

# Mirror _ModFrameworkDefinitions
MirrorFolder -SourceFolder $ModFrameworkDefinitions -DestinationFolder $ExampleMod
MirrorFolder -SourceFolder $ModFrameworkDefinitions -DestinationFolder $ModTemplate
MirrorFolder -SourceFolder $ModFrameworkDefinitions -DestinationFolder $CombatDataCore
MirrorFolder -SourceFolder $ModFrameworkDefinitions -DestinationFolder $DirectControl

exit 0