<#
  Description  : Install Unreal Engine development workloads for Visual Studio 2026 on the local machine.
  Author       : Nathan Adotey
  Publish Date : September 10th, 2026
#>

cd "$(Get-Location)\Stage"
.\vs_community.exe --layout $stagingPath `
	    --noWeb `
	    --add Microsoft.VisualStudio.Workload.NativeDesktop `
	    --add Microsoft.VisualStudio.Workload.NativeGame `
	    --add Microsoft.VisualStudio.Workload.NativeCrossPlat `
	    --includeOptional