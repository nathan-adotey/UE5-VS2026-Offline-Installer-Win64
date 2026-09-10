<#
  Description  : Create an offline installation of Visual Studio 2026 for Unreal Engine development workloads.
  Author       : Nathan Adotey
  Publish Date : September 10th, 2026
#>

# Verify the staging directory for the downloaded packages.
$uri = 'https://visualstudio.microsoft.com/thank-you-downloading-visual-studio/?sku=Community&channel=Stable&version=VS18&source=VSLandingPage&cid=2500&passive=false'
$stagingPath = "$(Get-Location)\Stage"

if (!(Test-Path -Path $stagingPath)) {
    New-Item -ItemType Directory -Path . -Name "Stage" -Force -Confirm:$false | Out-Null
}
else {
    Remove-Item -Recurse -Path $stagingPath\* -Force -Confirm:$false | Out-Null
}

# Download and verify the presence of the installer.
Start-Process chrome.exe $uri
$null = Read-Host "Press [ENTER] once the download completes (The script will fail if a file cannot be found)"

try {
    mv "$($env:USERPROFILE)\Downloads\VisualStudioSetup.exe" "$stagingPath\vs_community.exe" -ErrorAction Ignore
} catch {
    Write-Error "Visual Studio setup file not found. Re-launch the script to try again."
    Start-Sleep -Seconds 3
    Exit
}

cd $stagingPath

try {
    .\vs_community.exe --layout $stagingPath `
	    --lang en-US `
	    --add Microsoft.VisualStudio.Workload.NativeDesktop `
	    --add Microsoft.VisualStudio.Workload.NativeGame `
	    --add Microsoft.VisualStudio.Workload.NativeCrossPlat `
	    --includeOptional
} catch {
    Write-Error "Download failed. Please try again."
    Start-Sleep -Seconds 3
    Exit
}

Write-Host "`nThe download will proceed in a seperate sub-shell:`n" -ForegroundColor Yellow
Write-Host "  1.) Wait for a completion prompt before transport."
Write-Host "  2.) Do NOT modify packages within the staging directory to prevent broken dependency references."
Write-Host "  3.) Launch the 'Install-Packages.ps1' script to launch the offline installation.`n"
pause