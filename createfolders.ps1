$folders = Get-Content "C:\bla\bla\tmp\create_folders.txt"
foreach ($folder in $folders) {
    # Create the main folder
    New-Item -ItemType Directory -Path "D:\bla\bla\$folder" 
}
