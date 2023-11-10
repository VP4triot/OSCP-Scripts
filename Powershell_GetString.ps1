# Define the root directory
$rootDirectory = "C:\Path\To\Your\Directory"

# Define the string to search for
$searchString = "YourSearchString"

# Use Get-ChildItem to get all files in the directory and its subdirectories
$files = Get-ChildItem -Path $rootDirectory -Recurse | Where-Object { $_.PSIsContainer -eq $false }

# Use Select-String to search for the string in each file and display context
foreach ($file in $files) {
    $result = Get-Content $file.FullName | Select-String -Pattern $searchString -Context 2
    foreach ($match in $result) {
        Write-Host "String found in file: $($file.FullName)"
        Write-Host "  Match: $($match.Line)"
        Write-Host "  Context Before: $($match.Context.PreContext -join "`n")"
        Write-Host "  Context After: $($match.Context.PostContext -join "`n")"
        Write-Host ""
    }
}
