
<#
#̷𝓍   𝓐𝓡𝓢 𝓢𝓒𝓡𝓘𝓟𝓣𝓤𝓜
#̷𝓍   🇵​​​​​🇴​​​​​🇼​​​​​🇪​​​​​🇷​​​​​🇸​​​​​🇭​​​​​🇪​​​​​🇱​​​​​🇱​​​​​ 🇸​​​​​🇨​​​​​🇷​​​​​🇮​​​​​🇵​​​​​🇹​​​​​ 🇧​​​​​🇾​​​​​ 🇬​​​​​🇺​​​​​🇮​​​​​🇱​​​​​🇱​​​​​🇦​​​​​🇺​​​​​🇲​​​​​🇪​​​​​🇵​​​​​🇱​​​​​🇦​​​​​🇳​​​​​🇹​​​​​🇪​​​​​.🇶​​​​​🇨​​​​​@🇬​​​​​🇲​​​​​🇦​​​​​🇮​​​​​🇱​​​​​.🇨​​​​​🇴​​​​​🇲​​​​​
#>

function Get-NetZExe{
    [CmdletBinding(SupportsShouldProcess)]
    param()

    try{
        $Parents = @( "F:\DEV3\COMPRESSORS\NetZ-Packer-Bin", "${ENV:ProgramFiles(x86)}\NetZ-Bin", "F:\Programs\NetZ-Bin" )
        Write-Verbose "Searching for NetZ-Bin"
        ForEach($parent in $Parents){
            Write-Verbose "  => `"$parent`""
            $folders = Get-item $parent -ea Ignore

            foreach ($folder in $folders){
                $ilmerge = Join-Path $folder 'netz.exe'
                if (Test-path -path ($ilmerge)){
                    return $ilmerge
                }
            }
        }
    }catch{
        Write-Error "$_"
    }

    return $null
}


Function Invoke-NetZ {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [ValidateScript({
            if(-Not ($_ | Test-Path) ){
                throw "Path argument: File or folder does not exist"
            }
            if(-Not ($_ | Test-Path -PathType Leaf) ){
                throw "The Path argument must be a File. Directory paths are not allowed."
            }
            return $true 
        })]
        [Parameter(Mandatory=$true,Position=0)]
        [String]$ExeFile,
        [ValidateScript({
            if(-Not ($_ | Test-Path) ){
                throw "Path argument: File or folder does not exist"
            }
            if(-Not ($_ | Test-Path -PathType Leaf) ){
                throw "The Path argument must be a File. Directory paths are not allowed."
            }
            return $true 
         })]
        [Parameter(Mandatory=$true,Position=1)]
        [String[]]$DllFiles,
        [Parameter(Mandatory=$false)]
        [String]$IconFile,
        [Parameter(Mandatory=$false)]
        [String]$OutputDir,
        [Parameter(Mandatory=$false)]
        [switch]$DllResource
    )

        $NetZExe = Get-NetZExe

        $arguments = @("-s", "`"$ExeFile`"")
        ForEach($dll in $DllFiles){
            $arguments += "$dll"
        }

        if([string]::IsNullOrEmpty($OutputDir) -eq $False){
            $arguments += "-o"
            $arguments += "`"$OutputDir`""  
        }
        if([string]::IsNullOrEmpty($IconFile) -eq $False){
            $arguments += "-i"
            $arguments += "`"$IconFile`""  
        }
        if($DllResource){
            $arguments += "-r"
        }else{
            $arguments += "-z"
        }

        Start-Process -FilePath "$NetZExe" -ArgumentsList $arguments -NoNewWindow -Wait

    }


