#!/usr/bin/env powershell

#
# Installation script (PowerShell, Windows OS)
#
# This script creates symbolic links in the $HOME/bin directory pointing to local files
#

Write-Host "Crete symbolic links"
Write-Host "Environment variable 'HOME': " $env:HOME

$scriptpath = $MyInvocation.MyCommand.Path
$dir = Split-Path $scriptpath

If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    $arguments = "& '" + $myinvocation.mycommand.definition + "'"
    Start-Process powershell -Verb runAs -ArgumentList $arguments
    Break
}

Write-host "Source directory: $dir"

Function Make-SymbolLink {
    Param (
        [string]$source,
        [string]$target
    )
    Process {
        if (Test-Path $target -PathType leaf)
        {
            Write-Host "`nWARNING: File/Link already exists: " $target
            Write-Host "Exit without creating link!`n"
        } else
        {
            New-Item -ItemType SymbolicLink -Value $source -Path $target
        }
    }
}

Function Make-SymbolLink-ByName {
    Param (
        [string]$fname
    )
    Make-SymbolLink (Join-path $dir/bin $fname) (Join-path $env:HOME/bin $fname)
}

Make-SymbolLink-ByName("git-clear-reflog")
Make-SymbolLink-ByName("git-status-extra")

Write-Host ""
pause
