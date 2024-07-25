Add-Type -AssemblyName System.Windows.Forms

# Create an Open File Dialog to select text files
$OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
$OpenFileDialog.InitialDirectory = [System.Environment]::GetFolderPath('Desktop')
$OpenFileDialog.Filter = "Text files (*.txt)|*.txt"
$OpenFileDialog.Multiselect = $true
$OpenFileDialog.Title = "Select text files to combine"

# Show the dialog and get the selected files
$SelectedFiles = $OpenFileDialog.ShowDialog() | Out-Null
$Files = $OpenFileDialog.FileNames

if ($Files.Length -eq 0) {
    Write-Host "No files selected. Exiting."
    exit
}

# Create a Save File Dialog to specify the output file location
$SaveFileDialog = New-Object System.Windows.Forms.SaveFileDialog
$SaveFileDialog.InitialDirectory = [System.Environment]::GetFolderPath('Desktop')
$SaveFileDialog.Filter = "Text files (*.txt)|*.txt"
$SaveFileDialog.Title = "Save combined file as"
$SaveFileDialog.FileName = "quotes.txt"

# Show the dialog and get the output file path
$SaveFileDialogResult = $SaveFileDialog.ShowDialog() | Out-Null
$OutputFile = $SaveFileDialog.FileName

if ([string]::IsNullOrEmpty($OutputFile)) {
    Write-Host "No output file selected. Exiting."
    exit
}

# Combine the content of the selected files into one output file
foreach ($File in $Files) {
    Get-Content $File | Add-Content $OutputFile
}

Write-Host "Text files have been combined into $OutputFile"
