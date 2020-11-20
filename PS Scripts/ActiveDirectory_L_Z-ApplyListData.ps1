#Config Variables
$SiteURL = "https://007gc.sharepoint.com/sites/OfficeEntry-Pilot"
$ListName = "ActiveDirectory_L_Z"
$CSVFolder = "C:\Users\billn\Documents\Priority Items\Return to Work\ogd-office-entry-am-entree-au-bureau-master\"
$CSVFields=@("RowID","FirstName","LastName","Name","O365LoginName","EmailAddress","CostCentre","CostCentreNumber","SectorBranch","Classification","JobTitle") # Not currently being used below
###!!! CSV Fields need to be hard coded in script below. 
###To Do: investigate using for loop to iterate through columns 
 
#Get the CSV file contents
$CSVData = Import-Csv -Path ($CSVFolder + $ListName + ".csv") -header "RowID","FirstName","LastName","Name","O365LoginName","EmailAddress","CostCentre","CostCentreNumber","SectorBranch","Classification","JobTitle" -delimiter "|"
 
#Connect to site
Connect-PnPOnline $SiteUrl -UseWebLogin
 
#Iterate through each Row in the CSV and import data to SharePoint Online List
foreach ($Row in $CSVData)
{
	if ($Row.RowID -ne "RowID")	
	{
		Add-PnPListItem -List "ActiveDirectory_L_Z" -Values @{	
                            "Title"= $($Row.RowID);
							"FirstName"= $($Row.FirstName);
							"LastName"= $($Row.LastName);
							"Name"= $($Row.Name);
							"O365LoginName"= $($Row.O365LoginName);
							"EmailAddress"= $($Row.EmailAddress);
							"CostCentre"= $($Row.CostCentre);
							"CostCentreNumber"= $($Row.CostCentreNumber);
							"SectorBranch"= $($Row.SectorBranch);
							"Classification"= $($Row.Classification);
							"JobTitle"=$($Row.JobTitle)}
    }
}

