# UDWizardry

This is a powershell module which has been based upon the following react component:-
[Original REACT-WIZARDRY Component](https://www.npmjs.com/package/react-wizardry)

## Demo Dashboard
```
New-UDDashboard -Title 'UDWizardry' -Content {
New-UDRow -Columns {
  New-UDColumn -Content {
New-UDWizardry -BodyHeight 350 -Pages {
  [PSCustomObject]@{
    title = "Name"
    fields = @([ordered]@{
      label = "First Name"
      name = "fname"
      type = "text"
      isRequired = $true
    },
    [ordered]@{
      label = "Last Name"
      name = "lname"
      type = "text"
      isRequired = $false
    })
  },[PSCustomObject]@{
      title = "Second"
      fields = @([ordered]@{
        label = "Email Address"
        name = "eaddress"
        type = "email"
        isRequired = $false
      }
      )
    } | ConvertTo-Json -AsArray -Depth 4 | ConvertFrom-Json
  }
  }
}
}
```

 This works but would be nice to figure out a function on how to make this more dynamic.
 
 
 ## Works but need dynamic fields
 
 ```
 function New-UDWizardryPage1Field
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true)]
        [string]$Title,        
        [Parameter(Mandatory=$true)]
        [string]$Label,
        [Parameter(Mandatory=$true)]
        [string]$Name,
        [Parameter]
        [ValidateSet("text","email","phone","number","password","textarea","select","checkbox","radio","datetime","file")]
        [string]$Type = "text",
        [Parameter()]
        [string]$Required = $false

    )

    Begin
    {
    }
    Process
    {
      [PSCustomObject]@{
    title = $Title
    fields = @([ordered]@{
      label = $Label
      name = $Name
      type = $Type
      isRequired = $Required
    } #### NEED TO FIGURE OUT HOW TO NEST ADDITIONAL FIELDS HERE, AND THEN NEST ADDITIONAL PAGES
  } | ConvertTo-Json -AsArray -Depth 4 | ConvertFrom-Json
    }
    End
    {
    }
}
 ```
