<#
	.Synopsis
		Трансформирует исходный XML в конечный с использованием указанной XSLT трансформации
	.Description
		Трансформирует исходный XML в конечный с использованием указанной XSLT трансформации
#>
[CmdletBinding(
	ConfirmImpact = 'Low',
	SupportsShouldProcess = $true
)]

param (
	# Путь к исходному XML файлу
	[Parameter(
        Mandatory = $true
        , Position = 0
        , ValueFromPipeline = $true
	)]
	[ValidateNotNullOrEmpty()]
    [string]
	$Path
,
	# Путь к конечному XML файлу
	[Parameter(
        Mandatory = $true
        , Position = 1
	)]
	[ValidateNotNullOrEmpty()]
	[string]
	$Destination
,
	# Путь к XSLT файлу трансформации
	[Parameter(
        Mandatory = $true
        , Position = 2
	)]
	[ValidateNotNullOrEmpty()]
	[string]
	$XSLTLiteralPath
,
	[switch]
    $Force
)

begin {
#    $null = $PSBoundParameters.Remove('Force');
#    $PSBoundParameters.Confirm = $false;
    $XSLT = New-Object System.Xml.Xsl.XslCompiledTransform;
    $XSLTsource = [System.IO.Path]::GetTempFileName();
    Copy-Item `
        -Path $XSLTLiteralPath `
        -Destination $XSLTsource `
    ;
    $XSLT.Load($XSLTsource);
}            
process {
    $source = [System.IO.Path]::GetTempFileName();
    Copy-Item `
        -Path $Path `
        -Destination $source `
    ;
    $dest = [System.IO.Path]::GetTempFileName();
    $XSLT.Transform($source, $dest);
#    if ($Force -or $PSCmdlet.ShouldProcess(
#        $Path,
#        "transform with ""$XSLTLiteralPath"" to ""$Destination"""
#    )) {
        Move-Item `
            -LiteralPath $dest `
            -Destination $Destination `
            -Force `
        ;
#       Move-Item @PSBoundParameters;
#    };
}