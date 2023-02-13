oh-my-posh prompt init pwsh --config https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/v$(oh-my-posh --version)/themes/bubbles.omp.json | Invoke-Expression

Import-Module DockerCompletion
Import-Module npm-completion
Import-Module Get-ChildItemColor
Import-Module ZLocation

# Set l and ls alias to use the new Get-ChildItemColor cmdlets
Set-Alias l Get-ChildItemColor -Option AllScope
Set-Alias ls Get-ChildItemColorFormatWide -Option AllScope
Set-PSReadlineOption -EditMode vi

Import-Module PSFzf -ArgumentList 'Ctrl+t','Ctrl+r'

# Helper function to set location to the User Profile directory
function cuserprofile { Set-Location ~ }
Set-Alias ~ cuserprofile -Option AllScope


function back { Set-Location .. }
Set-Alias .. back


$env:LC_ALL='C.UTF-8'

function Add-Alias($name, $alias) {
    $func = @"
function global:$name {
    `$expr = ('$alias ' + (( `$args | % { if (`$_.GetType().FullName -eq "System.String") { "``"`$(`$_.Replace('``"','````"').Replace("'","``'"))``"" } else { `$_ } } ) -join ' '))
    write-debug "Expression: `$expr"
    Invoke-Expression `$expr
}
"@
    write-debug "Defined function:`n$func"
    $func | iex
}

# Helper function to show Unicode character
function U
{
    param
    (
        [int] $Code
    )
 
    if ((0 -le $Code) -and ($Code -le 0xFFFF))
    {
        return [char] $Code
    }
 
    if ((0x10000 -le $Code) -and ($Code -le 0x10FFFF))
    {
        return [char]::ConvertFromUtf32($Code)
    }
 
    throw "Invalid character code $Code"
}

function Convert-UnicodeToString {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string] $UnicodeChars
    )
    
    $UnicodeChars = $UnicodeChars -replace 'U\+', '';

    $UnicodeArray = @();
    foreach ($UnicodeChar in $UnicodeChars.Split(' ')) {
        $Int = [System.Convert]::ToInt32($UnicodeChar, 16);
        $UnicodeArray += [System.Char]::ConvertFromUtf32($Int);
    }

    $UnicodeArray -join [String]::Empty;
}

function Get-Random-Food-Emoji {
    $emojis = @("U+1F37A","U+1F373","U+1F370","U+1F36A","U+1F369","U+1F364","U+1F35E","U+1F35D","U+1F35C","U+1F357","U+1F356","U+1F355","U+1F354","U+1F34C","U+1F349","U+1F344","U+1F382")
    $emoji = Convert-UnicodeToString -UnicodeChars (Get-Random -InputObject $emojis)
    return $emoji
}

# Ensure posh-git is loaded
Import-Module -Name posh-git


function take() {
 
     param
     (
        [string] $path
     )


  if (!(Test-Path $path)){
     New-Item -ItemType Directory -Force -Path $path
  }
  Set-Location $path
}

# function Git-Take {
#     param
#     (
#         [string] $urlorigin
#     )
#     git clone $urlorigin
#     Set-Location $([System.IO.Path]::GetFileNameWithoutExtension($urlorigin));
# }

function netstatx
{
    netstat -ano | Where-Object{$_ -match 'LISTENING|UDP'} | ForEach-Object{
        $split = $_.Trim() -split "\s+"
        New-Object -Type pscustomobject -Property @{
            "Proto" = $split[0]
            "Local Address" = $split[1]
            "Foreign Address" = $split[2]
            # Some might not have a state. Check to see if the last element is a number. If it is ignore it
            "State" = if($split[3] -notmatch "\d+"){$split[3]}else{""}
            # The last element in every case will be a PID
            "Process Id" = $split[-1]
            "Process Name" = $(Get-Process -ErrorVariable a -ErrorAction SilentlyContinue -Id $split[-1] ).ProcessName
        }
    }  | Format-Table -Property Proto,"Local Address","Foreign Address",State,"Process Id","Process Name" -AutoSize
}


function watch {
    [CmdletBinding(SupportsShouldProcess=$True,ConfirmImpact='High')]
    param (
        [Parameter(Mandatory=$False,
                   ValueFromPipeline=$True,
                   ValueFromPipelineByPropertyName=$True)]
        [int]$n = 10,

        [Parameter(Mandatory=$True,
                   ValueFromPipeline=$True,
                   ValueFromPipelineByPropertyName=$True)]
        [string]$command
    )
    process {
        $cmd = [scriptblock]::Create($command);
        While($True) {
            Clear-Host;
            Write-Host "Command: " $command;
            $cmd.Invoke();
            Start-Sleep $n;
        }
    }
}

function who-lock {
    param(
        [parameter(Position=0, Mandatory=$true)]
        [String] $FileOrFolderPath
    )
    IF((Test-Path -Path $FileOrFolderPath) -eq $false) {
        Write-Warning "File or directory does not exist."       
    } Else {
        $LockingProcess = CMD /C "openfiles /query /fo table | find /I ""$FileOrFolderPath"""
        Write-Host $LockingProcess
    }
}

function Remove-Empty-Folders {
    param($Path)

    Get-ChildItem $Path -Recurse -Force -Directory | 
        Sort-Object -Property FullName -Descending |
        Where-Object { $($_ | Get-ChildItem -Force | Select-Object -First 1).Count -eq 0 } |
        Remove-Item -Verbose

 }

function _change-file-contents-and-rename {
    param($Files)

    foreach ($file in $Files)
    {
        if($file.PSPath -Match '.git') { continue }
        if($file.PSPath -Match '.dll') { continue }

        if (-Not ($file -is [System.IO.DirectoryInfo])) {
            echo $("Changing: " + $file.name + " content..." )
            (Get-Content $file.PSPath) | Foreach-Object { $_ -replace $TextToChange, $NewText } | Set-Content $file.PSPath
        }
        $newFile = $file.name -replace $TextToChange, $NewText

       if ($file.name -ne $newFile) {
            echo $("Changing: " +  $file.name + " to " + $newFile)
            Rename-Item -NewName $newFile -ErrorAction Stop $file 
       }
    }
}


function Replace-All-Ocurrences-Recursive {
    param(
        [String] $Folder,
        [String] $FilePattern,
        [String] $TextToChange,
        [String] $NewText
    )

    Remove-Empty-Folders -Path $Folder
    $files = Get-ChildItem -Path $Folder -Recurse $FilePattern -File
    _change-file-contents-and-rename -Files $files

    $folders = Get-ChildItem -Path $Folder -Recurse -Directory
    _change-file-contents-and-rename -Files $folders
}

function Install-My {
	Install-Module posh-git -Scope CurrentUser
    Install-Module DockerCompletion
    Install-Module npm-completion
    Install-Module PSFzf 
    Install-Module ZLocation -Scope CurrentUser -AllowClobber
    Install-Module -AllowClobber Get-ChildItemColor
}

Remove-Alias -AliasName rm
Remove-Alias -AliasName curl

Add-Alias vim 'nvim'
Add-Alias vi 'nvim'

Add-Alias sln 'Invoke-Item *.sln'
Add-Alias gitbranches 'Get-ChildItem -Attributes Directory,Directory+Hidden -ErrorAction SilentlyContinue -Include ".git" -Recurse ./ | % { $_.FullName + "\HEAD" } | % { $(cat $_ | grep "ref:").Replace("ref: refs/heads/","") + " -> " +  $_.Replace("\.git\HEAD","") }'
Add-Alias cdf 'cd $(lsx -r -D | fzf)'
Add-Alias vimf 'gvim $(fzfp -m)'
Add-Alias nvimf 'nvim $(fzfp -m)'
Add-Alias fzfp 'fzf --preview "bat --style=numbers --color=always {} | head -500"'

Set-PSReadlineKeyHandler -Chord UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Chord DownArrow -Function HistorySearchForward
# Set-PSReadLineKeyHandler -Key Tab -Function Complete
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete


$env:PYTHONIOENCODING="utf-8"
iex "$(thefuck --alias)"
