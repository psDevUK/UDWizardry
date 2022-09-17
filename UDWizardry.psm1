$IndexJs = Get-ChildItem "$PSScriptRoot\index.*.bundle.js"
$AssetId = [UniversalDashboard.Services.AssetService]::Instance.RegisterAsset($IndexJs.FullName)

function New-UDWizardry {
    <#
    .SYNOPSIS
    Creates a new component
    
    .DESCRIPTION
    Creates a new component
    
    .PARAMETER Id
    The ID of this editor

    .PARAMETER Text
    Text for the component

    .EXAMPLE
    New-UDComponent -Text 'Hello, world!'
    #>
    
    param(
        [Parameter()]
        [string]$Id = (New-Guid).ToString(),
        [Parameter()]
        [int]$ValidationDelay = 100,
        [Parameter()]
        [int]$BodyHeight = 500,
        [Parameter()]
        [string]$StepperWidth = "200px",
        [Parameter()]
        [Endpoint]$OnFinish,
        [Parameter()]
        [switch]$ShowStepperTitles,
        [Parameter(Mandatory)]
        [scriptblock]$Pages
    )

    End {
        $OnFinish.Register($Id, $PSCmdlet)
    
        @{
            assetId = $AssetId 
            isPlugin = $true
            type = "udwizardry"
            id = $Id

            validationDelay = $ValidationDelay
            bodyHeight = $BodyHeight
            stepperItemWidth = $StepperWidth
            showStepperTitles = $ShowStepperTitles
            pages = [array]$Pages.Invoke()
            onFinish = $OnFinish
            
        }
    }
}
