#------------------------------------------------------------------------------------
#https://github.com/kenmulford/sublime-mssql-snippets/blob/master/create-stored-procedure.sublime-snippet
$YEAR="2017"
$accnt="74267782"
$FolderName="BSX_74267782"
$ErrorActionPreference = "inquire" 
Import-Module "\\googledrive\accounting\POWERSHELL\MyFunctions\MyFunctions.psm1"
Import-Module SQLSERVER
$ConnectionString = 'Server=SQLFP;Database=IncomeTax;user ID=sa;Password=6017906010!Amd'
$IT="\\googledrive\accounting\CSV\IN\GL\$YEAR\"
$SF = Join-Path $IT \SF
$BSX=Join-Path $IT \$foldername




#--- Craete Folders and Files -------
Create-Directory ("\\googledrive\accounting\CSV\IN\GL\$Year\$FolderName")
$IT="\\googledrive\accounting\CSV\IN\GL\$Year\$FolderName"
Set-Location $IT
for ($i=1; $i -le 12; $i++) {
    $NameOfFile=$FolderName+"-"+$year+"-"+$i.ToString("00")
    $DestinationFile = $FolderName+"-"+$year+"-"+$i.ToString("00")+".PDF"
    Create-File($DestinationFile)
    }


$CutoffDate=$([DateTime] "1/1/2017")

 $fileEntries = Get-ChildItem BSX*.csv -Path $BSx

foreach ($fileName in $fileEntries)
{
    $FullFileName = $filename.Fullname
    $fileimportname=$fileName.Name 
    $csvObjects = Import-Csv  $fileName.FullName -Header "H1","H2","H3","H4","H5"
       
foreach ($item in $csvObjects)
    { 

    $h00="Account"
    $h01="PostDate"
    $h02="DocNum"
    $h03="Amount"
    $h04="TransactionDescription"
    $h05="csvName"

  
    $v00=$accnt
    $v01=$item.H1
    $v02=$item.H2
    $v03=$item.H3
    $v04=$item.H4 -replace("'","")
    $v05=$fileimportname=$fileName.Name 

    $SqlQuery="EXEC sp_amx " +"@$h00='$v00',@$h01='$v01',@$h02='$v02',@$h03='$v03',@$h04='$v04',@$h05='$v05'"

    Invoke-Sqlcmd -ConnectionString $ConnectionString -Query $SqlQuery 
    
    }
    }