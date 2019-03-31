$scooppath = scoop which scoop
$scooppath_bin = Split-Path -Parent $scooppath
$scooppath_lib = Resolve-Path "$scooppath_bin\..\lib"

$checkver = "$scooppath_bin\checkver.ps1"

. "$scooppath_lib\autoupdate.ps1"
. "$scooppath_lib\manifest.ps1"

Get-ChildItem -LiteralPath "." -Filter "*.json" -File | ForEach-Object {
    $checksum_orig = (Get-FileHash $_).Hash
    &$checkver -Dir . $_.BaseName -Update
    $checksum_new = (Get-FileHash $_).Hash
    if ($checksum_orig -ne $checksum_new) {
        $manifest = Get-Content -Raw $_ | ConvertFrom-Json
        $version_table = get_version_substitutions $manifest.version $null

        update_manifest_prop "bin" $manifest $version_table
        [System.IO.File]::WriteAllLines($_, (ConvertToPrettyJson $manifest))
    }
}
