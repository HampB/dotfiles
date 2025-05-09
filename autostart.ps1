# Define the source file path
$sourceFile = "keyboard_layers.ahk"

# Get the Startup folder path
$startupFolder = [Environment]::GetFolderPath("Startup")
echo "Startup folder path: $startupFolder"
# Define the destination file path
$destinationFile = Join-Path -Path $startupFolder -ChildPath "keyboard_layers.ahk"

# Copy the file to the Startup folder
Copy-Item -Path $sourceFile -Destination $destinationFile -Force

Write-Host "File copied to Startup folder successfully."