# Define the root directory
$rootDirectory = "C:\Path\To\Your\Directory"

# Define the string to search for
$searchString = "YourSearchString"

# Specify the output file
$outputFile = "C:\Path\To\Your\Output\File.txt"

# Use Get-ChildItem to get all files in the directory and its subdirectories
$files = Get-ChildItem -Path $rootDirectory -Recurse | Where-Object { $_.PSIsContainer -eq $false }

# Use Select-String to search for the string in each file and display context
foreach ($file in $files) {
    $result = Get-Content $file.FullName | Select-String -Pattern $searchString -Context 2
    foreach ($match in $result) {
        "$($file.FullName)" | Out-File -Append -FilePath $outputFile
        "  Match: $($match.Line)" | Out-File -Append -FilePath $outputFile
        "  Context Before: $($match.Context.PreContext -join "`n")" | Out-File -Append -FilePath $outputFile
        "  Context After: $($match.Context.PostContext -join "`n")" | Out-File -Append -FilePath $outputFile
        "" | Out-File -Append -FilePath $outputFile
    }
}
