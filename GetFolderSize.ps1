#Script to get the size of Folder and it's contents
function Get-Size
{
 param([string]$pth)
 "{0:n2}" -f ((gci -path $pth -recurse | measure-object -property length -sum).sum /1mb) + " mb"
}

Get-size your_path
