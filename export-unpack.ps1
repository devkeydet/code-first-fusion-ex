pac solution publish
$tempDirectory = "temp"
$unmanaged = "$tempDirectory/$solutionName.zip"
$managed = "$tempDirectory/$solutionName" + "_managed.zip"
pac solution export --path $unmanaged --name $solutionName --managed false
pac solution export --path $managed --name $solutionName --managed true
pac solution unpack -f src/solutions/$solutionName/unpacked-solution -z $unmanaged -p both --allowDelete true    
Remove-Item $tempDirectory -Recurse