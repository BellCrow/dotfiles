$env:ZELLIJ_CONFIG_DIR = "C:\Users\jkrieger\dotfiles\.config\zellij"
$env:SHELL = "pwsh"

if ($env:ZELLIJ -ne 0)
{
	Write-Output "starting zellij session..."
	zellij.exe
	return
}

# Colors
$RED     = "`e[31m"
$GREEN   = "`e[32m"
$BLUE    = "`e[36m"
$YELLOW  = "`e[33m"
$END     = "`e[0m"

# Symbols
$ARROW = "❯"
$SPACE = " "

function Get-GitBranch
{
	try
	{
		$branch = git rev-parse --abbrev-ref HEAD 2>$null
		if ($LASTEXITCODE -ne 0)
		{ return ""
		}
		return $branch.Trim()
	} catch
	{
		return ""
	}
}

function Has-GitChanges
{
	try
	{
		$status = git status --porcelain 2>$null
		if ($status)
		{ return $true
		}
		return $false
	} catch
	{
		return $false
	}
}

function Get-GitState
{
	$branch = Get-GitBranch
	if ($branch -eq "")
	{ return ""
	}

	$color = if (Has-GitChanges)
	{ $YELLOW
	} else
	{ $GREEN
	}
	return "$color($branch)$END"
}

function prompt
{
	$cwd = (Get-Location).Path
	$git = Get-GitState

	# First line: path + git state
	$line1 = "$BLUE$cwd$END $git"

	# Second line: arrow
	$line2 = "$GREEN$ARROW$END$SPACE"

	return "$line1`n$line2"
}
$env:PATH += ";C:\Users\jkrieger\tools\nvim-win64\bin"
$env:PATH += ";C:\Users\jkrieger\tools\"
$env:PATH += ";C:\Users\jkrieger\tools\luals\bin"
$env:PATH += ";C:\Users\jkrieger\tools\roslynLsp\content\LanguageServer\win-x64"
$env:PATH += ";C:\Users\jkrieger\AppData\Local\Programs\Inno Setup 6"
$env:PATH += ";C:\Users\jkrieger\tools\netcoredbg"

Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
# disable all inline autocompletion
Set-PSReadLineOption -PredictionSource None


Set-Alias -Name vim -Value nvim
Set-Alias -Name ll -Value ls

$env:EDITOR = $env:VISUAL = 'nvim'

function repos
{
	set-location "C:\Users\jkrieger\repos"
}

function prep
{
	set-location "C:\Users\jkrieger\repos\Slm.Prep"
}

function preplog
{
	set-location "C:\Users\jkrieger\AppData\Local\SLM-Solutions\"

}

function vimconfig
{
	set-location "C:\Users\jkrieger\AppData\Local\nvim"
}

$bookmarks = "~/work/bookmarks.txt"
function b
{
	# this pipes the content of the bookmarks file into fzf
	# after removing all empty and comment lines
	$fzfSelection = Get-Content C:\Users\jkrieger\work\bookmarks.txt | Select-String -Pattern '^\s*#' -NotMatch | Where-Object {$_.Line -ne "" } | Select-Object -ExpandProperty Line | fzf -e
	if($fzfSelection)
	{
		$url = $fzfSelection.Split(":",2)[1]
		Start-Process -FilePath msedge $url
	}
}

Set-PSReadlineOption -BellStyle None
