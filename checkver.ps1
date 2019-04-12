param(
    [String] $App = '*',
    [ValidateScript( {
            if (!(Test-Path $_ -Type Container)) {
                throw "$_ is not a directory!"
            }
            $true
        })]
    [String] $Dir = "$PSScriptRoot",
    [Switch] $Update,
    [Switch] $ForceUpdate,
    [Switch] $SkipUpdated,
    [String] $Version = ""
)

$scooppath = scoop.ps1 which scoop
$scooppath_bin = Split-Path -Parent $scooppath
$scooppath_lib = Resolve-Path "$scooppath_bin\..\lib"

$checkver = "$scooppath_bin\checkver.ps1"

. "$scooppath_lib\autoupdate.ps1"
. "$scooppath_lib\manifest.ps1"

if ($Update -or $ForceUpdate) {
    $current_hash = @()

    Get-ChildItem -LiteralPath $Dir -Filter "$App.json" | ForEach-Object {
        $current_hash += @{Name=$_.FullName ; Hash= (Get-FileHash $_.FullName).Hash}
    }
}

&$checkver -Dir:$Dir -App:$App -Update:$Update -ForceUpdate:$ForceUpdate `
    -SkipUpdated:$SkipUpdated -Version:$Version

if ($Update -or $ForceUpdate) {
     $current_hash | ForEach-Object {
        if ($ForceUpdate -or ((Get-FileHash $_.Name).Hash -ne $_.Hash )) {
            $manifest = Get-Content -Raw $_.Name | ConvertFrom-Json
            $version_table = get_version_substitutions $manifest.version $null
            update_manifest_prop "bin" $manifest $version_table
            [System.IO.File]::WriteAllLines($_.Name, (ConvertToPrettyJson $manifest))
        }
    }
}
