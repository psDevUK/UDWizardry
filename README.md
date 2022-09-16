# UDWizardry

This is a powershell module which has been based upon the following react component:-
[Original REACT-WIZARDRY Component](https://www.npmjs.com/package/react-wizardry)

## Demo Dashboard
```
New-UDDashboard -Title 'PowerShell Universal' -Content {
        New-UDWizardry -Strict $true -BodyHeight 340 -Content {
          New-UDWizardryPage -Pages @("Title1",@("first","fname","text",$false),@("Something","some","text",$true,"You need to type something in here")),@("Title2",@("last","sname","text",$true)),@("Title3",@("mast","mname","text",$true))
        }
}
```

## PSM1

```
$IndexJs = Get-ChildItem "$PSScriptRoot\index.*.bundle.js"
$AssetId = [UniversalDashboard.Services.AssetService]::Instance.RegisterAsset($IndexJs.FullName)

function New-UDWizardry {
    <#
    .SYNOPSIS
    Creates a new stepper component using react-wizardry
    
    .DESCRIPTION
    New stepper component based on react-wizardry. Lots of nice features, sub-function to include the actual form data. Keeps data when pressing back button
    
    .PARAMETER Id
    The ID of this editor

    .PARAMETER BodyHeight
    Sets the height of the form body
    
    .PARAMETER NoPageTitle
    Decides if page title is shown
    
    .PARAMETER ShowStepperTitle
    Use this parameter to display page titles under the stepper points
    
    .PARAMETER StepperWidth
    Sets the width of each stepper item
    
    .PARAMETER HighlightValidation
    Highlights the fields when the validation fails or succeeds
    
    .PARAMETER Strict
    Validation rules are applied to all inputs that have been marked for validation or that are required.
    The component prevents the user from moving on until the current step's errors have been fixed
    
    .PARAMETER Content
    Script block to display collection of the page object

    .PARAMETER FinishMessage
    String to display the finish message to the end-user once they have completed the wizard form

    .EXAMPLE
    New-UDWizardryPage -Pages @("Title1",@("first","fname","text",$true,"You need to enter your first name"),@("email","eadd","email",$false)),@("Title2",@("last","sname","text",$true)),@("Title3",@("summary","details","text",$true))
    #>
    
    param(
        [Parameter()]
        [string]$Id = (New-Guid).ToString(),
        #Sets the height for the stepper
        [Parameter()]
        [int]$BodyHeight = 500,
        #Boolean to display title or not default false
        [Parameter()]
        [bool]$NoPageTitle = $false,
        #Boolean to display stepper titles default true
        [Parameter()]
        [bool]$ShowStepperTitle = $true,
        #String to decide stepper length default 200px
        [Parameter()]
        [string]$StepperWidth = "200px",
        #Highlights the fields when the validation fails or succeeds boolean default true
        [Parameter()]
        [bool]$HighlightValidation = $true,
        #Validation rules are applied to all inputs that have been marked for validation or that are required.The component prevents the user from moving on until the current step's errors have been fixed boolean default false
        [Parameter()]
        [bool]$Strict = $false,
        #Script block to display contents of the wizardry pages
        [Parameter(Mandatory)]
        [scriptblock]$Content,
        #Display a custom finish message
        [Parameter()]
        [string]$FinishMessage = "Thank you for finishing the form"
    )

    End {
        @{
            assetId                     = $AssetId 
            isPlugin                    = $true 
            type                        = "udwizardry"
            id                          = $Id

            bodyHeight                  = $BodyHeight
            noPageTitle                 = $NoPageTitle
            showStepperTitles           = $ShowStepperTitle
            stepperItemWidth            = $StepperWidth
            highlightFieldsOnValidation = $HighlightValidation
            strict                      = $Strict
            pages                       = [array]$Content.Invoke()
            finishMessage               = $FinishMessage
        }
    }
}

<#
.Synopsis
   Helps creating pages steps for UDWizardry
.DESCRIPTION
   Enables you to add data to the UDWizardry Content script block
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   New-UDWizardryPage -Pages @("Title1",@("first","fname","text",$false),@("email","eadd","email",$false)),@("Title2",@("last","sname","text",$true)),@("Title3",@("mast","mname","text",$true))
#>
function New-UDWizardryPage {
    [CmdletBinding()]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory = $true, Position = 0)]
        [array[]]$Pages
    )

    Begin {
        $number = $Pages.Count #find the amount of pages/titles
        $Data = @() #Empty array to add to
    }
    Process {
        for ($i = 0; $i -lt $number; $i++) { 
            switch ($Pages.Item($i).count) {
                2 {
                    $Data += [PSCustomObject]@{
                        title  = $Pages.Item($i)[0]
                        fields = @([ordered]@{
                                label             = @($Pages.Item($i)[1])[0]
                                name              = @($Pages.Item($i)[1])[1]
                                type              = @($Pages.Item($i)[1])[2]
                                isRequired        = @($Pages.Item($i)[1])[3]
                                validationMessage = @($Pages.Item($i)[1])[4]
                            })
                    }
                }
                3 {
                    $Data += [PSCustomObject]@{
                        title  = $Pages.Item($i)[0]
                        fields = @([ordered]@{
                                label             = @($Pages.Item($i)[1])[0]
                                name              = @($Pages.Item($i)[1])[1]
                                type              = @($Pages.Item($i)[1])[2]
                                isRequired        = @($Pages.Item($i)[1])[3]
                                validationMessage = @($Pages.Item($i)[1])[4]
                            }
                            , [ordered]@{
                                label             = @($Pages.Item($i)[2])[0]
                                name              = @($Pages.Item($i)[2])[1]
                                type              = @($Pages.Item($i)[2])[2]
                                isRequired        = @($Pages.Item($i)[2])[3]
                                validationMessage = @($Pages.Item($i)[2])[4]
                            })
                    } 
                }
                4 {
                    $Data += [PSCustomObject]@{
                        title  = $Pages.Item($i)[0]
                        fields = @([ordered]@{
                                label             = @($Pages.Item($i)[1])[0]
                                name              = @($Pages.Item($i)[1])[1]
                                type              = @($Pages.Item($i)[1])[2]
                                isRequired        = @($Pages.Item($i)[1])[3]
                                validationMessage = @($Pages.Item($i)[1])[4]
                            }
                            , [ordered]@{
                                label             = @($Pages.Item($i)[2])[0]
                                name              = @($Pages.Item($i)[2])[1]
                                type              = @($Pages.Item($i)[2])[2]
                                isRequired        = @($Pages.Item($i)[2])[3]
                                validationMessage = @($Pages.Item($i)[2])[4]
                            }
                            , [ordered]@{
                                label             = @($Pages.Item($i)[3])[0]
                                name              = @($Pages.Item($i)[3])[1]
                                type              = @($Pages.Item($i)[3])[2]
                                isRequired        = @($Pages.Item($i)[3])[3]
                                validationMessage = @($Pages.Item($i)[3])[4]
                            })
                    }
                }
                5 {
                    $Data += [PSCustomObject]@{ 
                        title  = $Pages.Item($i)[0]
                        fields = @([ordered]@{
                                label             = @($Pages.Item($i)[1])[0]
                                name              = @($Pages.Item($i)[1])[1]
                                type              = @($Pages.Item($i)[1])[2]
                                isRequired        = @($Pages.Item($i)[1])[3]
                                validationMessage = @($Pages.Item($i)[1])[4]
                            }
                            , [ordered]@{
                                label             = @($Pages.Item($i)[2])[0]
                                name              = @($Pages.Item($i)[2])[1]
                                type              = @($Pages.Item($i)[2])[2]
                                isRequired        = @($Pages.Item($i)[2])[3]
                                validationMessage = @($Pages.Item($i)[2])[4]
                            },
                            [ordered]@{
                                label             = @($Pages.Item($i)[3])[0]
                                name              = @($Pages.Item($i)[3])[1]
                                type              = @($Pages.Item($i)[3])[2]
                                isRequired        = @($Pages.Item($i)[3])[3]
                                validationMessage = @($Pages.Item($i)[3])[4]
                            },
                            [ordered]@{
                                label             = @($Pages.Item($i)[4])[0]
                                name              = @($Pages.Item($i)[4])[1]
                                type              = @($Pages.Item($i)[4])[2]
                                isRequired        = @($Pages.Item($i)[4])[3]
                                validationMessage = @($Pages.Item($i)[4])[4]
                            })
                    }
                }
                6 {
                    $Data += [PSCustomObject]@{
                        title  = $Pages.Item($i)[0]
                        fields = @([ordered]@{
                                label             = @($Pages.Item($i)[1])[0]
                                name              = @($Pages.Item($i)[1])[1]
                                type              = @($Pages.Item($i)[1])[2]
                                isRequired        = @($Pages.Item($i)[1])[3]
                                validationMessage = @($Pages.Item($i)[1])[4]
                            },
                            [ordered]@{
                                label             = @($Pages.Item($i)[2])[0]
                                name              = @($Pages.Item($i)[2])[1]
                                type              = @($Pages.Item($i)[2])[2]
                                isRequired        = @($Pages.Item($i)[2])[3]
                                validationMessage = @($Pages.Item($i)[2])[4]
                            },
                            [ordered]@{
                                label             = @($Pages.Item($i)[3])[0]
                                name              = @($Pages.Item($i)[3])[1]
                                type              = @($Pages.Item($i)[3])[2]
                                isRequired        = @($Pages.Item($i)[3])[3]
                                validationMessage = @($Pages.Item($i)[3])[4]
                            },
                            [ordered]@{
                                label             = @($Pages.Item($i)[4])[0]
                                name              = @($Pages.Item($i)[4])[1]
                                type              = @($Pages.Item($i)[4])[2]
                                isRequired        = @($Pages.Item($i)[4])[3]
                                validationMessage = @($Pages.Item($i)[4])[4]
                            },
                            [ordered]@{
                                label             = @($Pages.Item($i)[5])[0]
                                name              = @($Pages.Item($i)[5])[1]
                                type              = @($Pages.Item($i)[5])[2]
                                isRequired        = @($Pages.Item($i)[5])[3]
                                validationMessage = @($Pages.Item($i)[5])[4]
                            })
                    }
                }
                7 {
                    $Data += [PSCustomObject]@{    
                        title  = $Pages.Item($i)[0]
                        fields = @([ordered]@{
                                label             = @($Pages.Item($i)[1])[0]
                                name              = @($Pages.Item($i)[1])[1]
                                type              = @($Pages.Item($i)[1])[2]
                                isRequired        = @($Pages.Item($i)[1])[3]
                                validationMessage = @($Pages.Item($i)[1])[4]
                            },
                            [ordered]@{
                                label             = @($Pages.Item($i)[2])[0]
                                name              = @($Pages.Item($i)[2])[1]
                                type              = @($Pages.Item($i)[2])[2]
                                isRequired        = @($Pages.Item($i)[2])[3]
                                validationMessage = @($Pages.Item($i)[2])[4]
                            },
                            [ordered]@{
                                label             = @($Pages.Item($i)[3])[0]
                                name              = @($Pages.Item($i)[3])[1]
                                type              = @($Pages.Item($i)[3])[2]
                                isRequired        = @($Pages.Item($i)[3])[3]
                                validationMessage = @($Pages.Item($i)[3])[4]
                            },
                            [ordered]@{
                                label             = @($Pages.Item($i)[4])[0]
                                name              = @($Pages.Item($i)[4])[1]
                                type              = @($Pages.Item($i)[4])[2]
                                isRequired        = @($Pages.Item($i)[4])[3]
                                validationMessage = @($Pages.Item($i)[4])[4]
                            },
                            [ordered]@{
                                label             = @($Pages.Item($i)[5])[0]
                                name              = @($Pages.Item($i)[5])[1]
                                type              = @($Pages.Item($i)[5])[2]
                                isRequired        = @($Pages.Item($i)[5])[3]
                                validationMessage = @($Pages.Item($i)[5])[4]
                            },
                            [ordered]@{
                                label             = @($Pages.Item($i)[6])[0]
                                name              = @($Pages.Item($i)[6])[1]
                                type              = @($Pages.Item($i)[6])[2]
                                isRequired        = @($Pages.Item($i)[6])[3]
                                validationMessage = @($Pages.Item($i)[6])[4]
                            })
                    }
                }
                Default { Write-Warning "Something went wrong please check your syntax" }
            }
    
        }

    }
    End {
        $Data | ConvertTo-Json -AsArray -Depth 5 | ConvertFrom-Json
    }
}
```
