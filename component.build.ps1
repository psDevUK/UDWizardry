$OutputPath = "$PSScriptRoot\output"

task Build {
	Remove-Item -Path $OutputPath -Force -ErrorAction SilentlyContinue -Recurse
	Remove-Item -Path "$PSScriptRoot\public" -Force -ErrorAction SilentlyContinue -Recurse	
	Set-Location $PSScriptRoot

	&{
		$ErrorActionPreference = 'SilentlyContinue'
		npm install --legacy-peer-deps
		npm run build
	}

	New-Item -Path $OutputPath -ItemType Directory

	Copy-Item $PSScriptRoot\public\*.* $OutputPath
	Copy-Item $PSScriptRoot\UDWizardry.psd1 $OutputPath
	Copy-Item $PSScriptRoot\UDWizardry.psm1 $OutputPath
}

task . Build
