#------------------------------------------------------------------------------------
#https://github.com/kenmulford/sublime-mssql-snippets/blob/master/create-stored-procedure.sublime-snippet
$YEAR="2017"
$ErrorActionPreference = "inquire" 
Import-Module "\\googledrive\accounting\POWERSHELL\MyFunctions\MyFunctions.psm1"
Import-Module SQLSERVER
$ConnectionString = 'Server=SQLFP;Database=IncomeTax;user ID=sa;Password=6017906010!Amd'
$tmpV=New-TemporaryFile
$TempPathV=$tmpV.FullName
$IT="\\googledrive\accounting\CSV\IN\GL\$YEAR\WFC"
$SF = Join-Path $IT \SF
$tmpIRE=New-TemporaryFile
$TempPathIRE=$tmpIRE.FullName
$CutoffDate=$([DateTime] "1/1/2017")

 $fileEntries = Get-ChildItem *.csv -Path $IT 

foreach ($fileName in $fileEntries)
{
    $FullFileName = $filename.Fullname
    $fileimportname=$fileName.Name
    $csvObjects = Import-Csv  $fileName.FullName -Header "H1","H2","H3","H4","H5"
       
foreach ($item in $csvObjects)
    { 

    $h01="Account"
    $h02="PostDate"
    $h03="DocNum"
    $h04="TransactionDescription"
    $h05="Amount"
    $h06="csvName"

    # -- V01-
    switch ($fileimportname)
{
    {$_ -eq 'Checking3.csv'}
     {
      $V01 = "1737846129" #BUSINESS CHECKING
     }

    {$_ -eq 'Checking1.csv'}
     {
      $V01 = "2910054044" # CHECKING
     }
{$_ -eq 'MarketRate2.csv'}
     {
      $v01 = "2910054036" # SAVINGS
     }
{$_ -eq 'Savings4.csv'}
     {
      $V01 = "1737847739" #BUSINESS HIGH YIELD SAVINGS
     }

    Default{}
}
    # -- v01
    
    $v02=$item.H1
    $v03=$item.H4
    $v04=$item.H5
    $v05=$item.H2
    $v06=    $fileimportname=$fileName.Name 

    $SqlQuery="EXEC sp_wfc " +"@$h01='$v01',@$h02='$v02',@$h03='$v03',@$h04='$v04',@$h05='$v05',@$h06='$v06'"

    Invoke-Sqlcmd -ConnectionString $ConnectionString -Query $SqlQuery 
    
    }
    }