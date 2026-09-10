# oh-my-posh init pwsh | Invoke-Expression

$ompTheme = "bubbles.omp.json"
if (Test-Path -Path ~/$ompTheme) {
   oh-my-posh init pwsh --config ~/$ompTheme | Invoke-Expression
} else {
   oh-my-posh init pwsh --config https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/v$(oh-my-posh --version)/themes/$ompTheme | Invoke-Expression
}

$env:LC_ALL = 'C.UTF-8'
$env:PYTHONIOENCODING = 'utf-8'
$env:DOTNET_CLI_TELEMETRY_OPTOUT = 'true'

Import-Module DockerCompletion
Import-Module npm-completion
Import-Module Get-ChildItemColor
Import-Module ZLocation
Import-Module -Name posh-git
Import-Module PSFzf -ArgumentList 'Ctrl+t', 'Ctrl+r'

Set-Alias l Get-ChildItemColor -Option AllScope
Set-Alias ls Get-ChildItemColorFormatWide -Option AllScope

Set-PSReadlineOption -EditMode vi
Set-PSReadlineKeyHandler -Chord UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Chord DownArrow -Function HistorySearchForward
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

function Add-Alias($name, $alias) {
    $func = @"
function global:$name {
    `$expr = ('$alias ' + (( `$args | % { if (`$_.GetType().FullName -eq "System.String") { "``"`$(`$_.Replace('``"','````"').Replace("'","``'"))``"" } else { `$_ } } ) -join ' '))
    write-debug "Expression: `$expr"
    Invoke-Expression `$expr
}
"@
    write-debug "Defined function:`n$func"
    $func | Invoke-Expression
}

# Remove-Alias -ErrorAction Ignore -Name r
# Remove-Alias -ErrorAction Ignore -Name rm
Remove-Alias -ErrorAction Ignore -Name cat
Add-Alias ~ 'Set-Location ~'
Add-Alias .. 'Set-Location ..'
Add-Alias gen-uuid '[guid]::NewGuid().ToString()'
Add-Alias gen-uuid-v7 '[guid]::CreateVersion7().ToString()'
Add-Alias vim 'nvim'
Add-Alias vi 'nvim'
Add-Alias zsh 'bash -c zsh'
Add-Alias sln 'Invoke-Item *.sln'
Add-Alias gitbranches 'Get-ChildItem -Attributes Directory,Directory+Hidden -ErrorAction SilentlyContinue -Include ".git" -Recurse ./ | % { $_.FullName + "\HEAD" } | % { $(cat $_ | grep "ref:").Replace("ref: refs/heads/","") + " -> " +  $_.Replace("\.git\HEAD","") }'
Add-Alias cdf 'cd $(lsx -r -D | fzf)'
Add-Alias vimf 'gvim $(fzfp -m)'
Add-Alias nvimf 'nvim $(fzfp -m)'
Add-Alias fly 'flyctl'
Add-Alias fzfp 'fzf --preview "bat --style=numbers --color=always {} | head -500"'
Add-Alias cat 'bat'
Add-Alias UpdateDotnetTools 'dotnet tool list -g | ForEach-Object {$index = 0} { $index++; if($index -gt 2) { dotnet tool update -g $_.split(" ")[0] } }'
Add-Alias UpdateDotnetLocalTools 'dotnet tool list | ForEach-Object {$index = 0} { $index++; if($index -gt 2) { dotnet tool update -g $_.split(" ")[0] } }'
Add-Alias loc 'tokei'
Add-Alias refresh '. $PROFILE'

function Execute-Expression() {
    param (
        [Parameter(Mandatory = $false)]
        [switch] $Eval = $false,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string] $Cmd,
        [Parameter(Mandatory = $false, ValueFromRemainingArguments=$true)]
        [string[]]$CmdArgs
    )
    if (Get-Command $Cmd -ErrorAction Ignore) {
        $expr = "$($Cmd) $($CmdArgs -join " ")"
        if ($Eval) { Invoke-Expression $expr | Out-String | Invoke-Expression }
        else { Invoke-Expression -Command $expr }
    }
}

Execute-Expression -Eval thefuck --alias
Execute-Expression -Eval gh completion -s powershell
Execute-Expression -Eval -ErrorAction SilentlyContinue dotnet completions script pwsh

function sudo() {
    if ($args.Length -eq 1) {
        start-process $args[0] -verb "runAs"
    }
    if ($args.Length -gt 1) {
        start-process $args[0] -ArgumentList $args[1..$args.Length] -verb "runAs"
    }
}

function take() {
    param ([string] $path)
    if (!(Test-Path $path)) {
        New-Item -ItemType Directory -Force -Path $path
    }
    Set-Location $path
}

function which() {
    param ([string] $file)
    Get-Command $file | select Source
}

function filter() {
    param (
        [Parameter(ValueFromPipeline = $true)]
        $pipelineItem,
        [parameter(Position = 0, Mandatory = $true)]
        [string] $Pattern,
        [switch] $Raw = $false,
        [switch] $CaseSensitive = $false
    )

    process {
        $args = @{
            SimpleMatch = $Raw
            CaseSensitive = $CaseSensitive
        }
        $pipelineItem | Select-String @args -Pattern $Pattern | Select-Object -ExpandProperty Line
    }
}

function netstatx {
    netstat -ano | Where-Object { $_ -match 'LISTENING|UDP' } | ForEach-Object {
        $split = $_.Trim() -split "\s+"
        New-Object -Type pscustomobject -Property @{
            "Proto"           = $split[0]
            "Local Address"   = $split[1]
            "Foreign Address" = $split[2]
            # Some might not have a state. Check to see if the last element is a number. If it is ignore it
            "State"           = if ($split[3] -notmatch "\d+") { $split[3] }else { "" }
            # The last element in every case will be a PID
            "Process Id"      = $split[-1]
            "Process Name"    = $(Get-Process -ErrorVariable a -ErrorAction SilentlyContinue -Id $split[-1] ).ProcessName
        }
    }  | Format-Table -Property Proto, "Local Address", "Foreign Address", State, "Process Id", "Process Name" -AutoSize
}

function get-file-locker {
    param(
        [parameter(Position = 0, Mandatory = $true)]
        [string] $FileOrFolderPath
    )
    IF ((Test-Path -Path $FileOrFolderPath) -eq $false) {
        Write-Warning "File or directory does not exist."
    }
    Else {
        $LockingProcess = CMD /C "openfiles /query /fo table | find /I ""$FileOrFolderPath"""
        Write-Host $LockingProcess
    }
}

# Helper function to show Unicode character
function U-Char {
    param ([int] $Code)

    if ((0 -le $Code) -and ($Code -le 0xFFFF)) {
        return [char] $Code
    }

    if ((0x10000 -le $Code) -and ($Code -le 0x10FFFF)) {
        return [char]::ConvertFromUtf32($Code)
    }

    throw "Invalid character code $Code"
}

function U {
    [CmdletBinding()]
    param (
        [Parameter(Position = 0, Mandatory = $true)]
        [string] $UnicodeChars
    )
    $UnicodeChars = $UnicodeChars.ToUpper()
    $UnicodeChars = $UnicodeChars -replace 'U\+', '';
    $UnicodeChars = $UnicodeChars -replace 'U', '';
    $UnicodeArray = @();
    foreach ($UnicodeChar in $UnicodeChars.Split(' ')) {
        $Int = [System.Convert]::ToInt32($UnicodeChar, 16);
        $UnicodeArray += [System.Char]::ConvertFromUtf32($Int);
    }
    $UnicodeArray -join [String]::Empty;
}

function Reset-Directory() {
    param (
        [parameter(Position = 0, Mandatory = $true)]
        [string] $path
    )
    if (Test-Path $path -PathType Leaf) { throw "Path '$path' is not a directory" }
    if (Test-Path $path) { Remove-Item -Force -Recurse -Path $path }
    New-Item -ItemType Directory -Path $path | Out-Null
}

function Combine() {
    param (
        [parameter(Position = 0, ValueFromRemainingArguments = $true)]
        [string[]] $paths
    )
    return [IO.Path]::Combine($paths)
}

function Get-Random-Food {
    $emojis = @("U+1F37A", "U+1F373", "U+1F370", "U+1F36A", "U+1F369", "U+1F364", "U+1F35E", "U+1F35D", "U+1F35C", "U+1F357", "U+1F356", "U+1F355", "U+1F354", "U+1F34C", "U+1F349", "U+1F344", "U+1F382")
    $emoji = U (Get-Random -InputObject $emojis)
    return $emoji
}
function Remove-Empty-Folders {
    param($Path)
    Get-ChildItem $Path -Recurse -Force -Directory |
    Sort-Object -Property FullName -Descending |
    Where-Object { $($_ | Get-ChildItem -Force | Select-Object -First 1).Count -eq 0 } |
    Remove-Item -Verbose

}
function Find-Replace-Ocurrences {
    param(
        [string] $Folder,
        [string] $FilePattern,
        [string] $TextToChange,
        [string] $NewText
    )

    function update-file-contents {
        param($Files)

        foreach ($file in $Files) {
            if ($file.PSPath -Match '.git') { continue }
            if ($file.PSPath -Match '.dll') { continue }
            if ($file.PSPath -Match '.png') { continue }
            if ($file.PSPath -Match '.pdf') { continue }
            if ($file.PSPath -Match '.jpeg') { continue }
            if ($file.PSPath -Match '.jpg') { continue }

            if (-Not ($file -is [System.IO.DirectoryInfo])) {
                Write-Output $("Changing: " + $file.name + " content..." )
                (Get-Content $file.PSPath) | Foreach-Object { $_ -replace $TextToChange, $NewText } | Set-Content $file.PSPath
            }
            $newFile = $file.name -replace $TextToChange, $NewText
            if ($file.name -ne $newFile) {
                Write-Output $("Changing: " + $file.name + " to " + $newFile)
                Rename-Item -NewName $newFile -ErrorAction Stop $file
            }
        }
    }

    Remove-Empty-Folders -Path $Folder
    $files = Get-ChildItem -Path $Folder -Recurse $FilePattern -File
    update-file-contents -Files $files

    $folders = Get-ChildItem -Path $Folder -Recurse -Directory
    update-file-contents -Files $folders
}

function Get-Docker-Img-Size {
    param(
        [parameter(Position = 0, Mandatory = $true)]
        [string] $Name
    )
    $TmpFile = [System.IO.Path]::GetTempFileName() + ".tar"
    docker save $Name -o $TmpFile
    gzip $TmpFile
    $GzFile = "$($TmpFile).gz"
    $Size = (Get-Item -Path $GzFile).Length / 1MB
    Write-Output $('{0:N2} MB' -f $Size)
    Remove-Item $GzFile
}

function Watch-Command {
    [CmdletBinding(ConfirmImpact = 'High')]
    param (
        [Parameter(Mandatory = $False,
            ValueFromPipeline = $True,
            ValueFromPipelineByPropertyName = $True)]
        [int]$n = 10,

        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            ValueFromPipelineByPropertyName = $True)]
        [string]$command
    )
    process {
        $cmd = [scriptblock]::Create($command);
        While ($True) {
            Clear-Host;
            Write-Host "Command: " $command;
            $cmd.Invoke();
            Start-Sleep $n;
        }
    }
}

function Convert-EOL-Unix {
    param(
        [parameter(Position = 0, Mandatory = $true)]
        [string] $File
    )

    ((Get-Content $file) -join "`n") + "`n" | Set-Content -NoNewline $file
}

function Convert-Files-EOL-Unix {
    param(
        [parameter(Position = 0, Mandatory = $true)]
        [string] $Path,
        [parameter(Position = 1, Mandatory = $true)]
        [string] $Ext
    )

    Get-ChildItem -Recurse -Path $Path -Filter $Ext | ForEach-Object {
        Convert-EOL-Unix $_.FullName
    }
}

function Convert-Files-UTF8 {
    param(
        [parameter(Position = 0, Mandatory = $true)]
        [string] $Path,
        [parameter(Position = 1, Mandatory = $true)]
        [string] $Ext,
        [switch] $ForceUnixLF = $true
    )

    Get-ChildItem -Recurse -Path $Path -Filter $Ext | ForEach-Object {
        $content = Get-Content -Path $_.FullName

        if ($ForceUnixLF) {
            ($content -join "`n") + "`n" | Out-File -FilePath $_.FullName -NoNewline -Encoding UTF8
        }
        else {
            $content | Out-File -FilePath $_.FullName -Encoding UTF8
        }
    }
}

function Native-Definition {
    param(
        [parameter(Position = 0, Mandatory = $true)]
        [Object] $Command
    )

    $cmd = Get-Command $Command
    $meta = New-Object System.Management.Automation.CommandMetadata($cmd)
    $src = [System.Management.Automation.ProxyCommand]::Create($meta)
    $src | bat -l ps1
}

function Zip-Each-Directory {
    param(
        [switch] $Use7z = $false
    )

    if ($Use7z) {
        Get-ChildItem -Directory | ForEach-Object { & "7z.exe" a $_.BaseName $_.Name }
    }
    else {
        Get-ChildItem -Directory | ForEach-Object { & "7z.exe" -tzip a $_.BaseName $_.Name }
    }
}

function Godot() {
    Invoke-Expression "$env:GODOT_EDITOR $args"
}

function Godot-Console() {
    Invoke-Expression "$env:GODOT_CONSOLE $args"
}
