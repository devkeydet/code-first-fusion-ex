function Export-Unpack ([Parameter(Mandatory)]$solutionName) {
    pac solution publish
    $tempDirectory = "temp"
    $unmanaged = "$tempDirectory/$solutionName.zip"
    $managed = "$tempDirectory/$solutionName" + "_managed.zip"
    pac solution export --path $unmanaged --name $solutionName --managed false
    pac solution export --path $managed --name $solutionName --managed true
    $unpackedSolutionDirectory = "src/solutions/$solutionName/unpacked-solution"
    pac solution unpack -f $unpackedSolutionDirectory -z $unmanaged -p both --allowDelete true
    $unpackedCanvasAppsDirectory = "$unpackedSolutionDirectory/CanvasApps"
    $hasCanvasApps = Test-Path $unpackedCanvasAppsDirectory
    if ($hasCanvasApps) {
        $msappFiles = Get-ChildItem $unpackedCanvasAppsDirectory -Filter *.msapp
        foreach ($msapp in $msappFiles) { 
            pac canvas unpack --msapp $msapp.FullName --sources ($msapp.FullName.Replace('.msapp', "_msapp")) 
        }
    }
    Remove-Item $tempDirectory -Recurse
}

Export-Unpack