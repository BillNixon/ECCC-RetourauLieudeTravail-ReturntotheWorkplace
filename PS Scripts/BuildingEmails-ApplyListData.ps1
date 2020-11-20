#Config Variables
$SiteURL = "https://007gc.sharepoint.com/sites/RetourauLieudeTravail-ReturntotheWorkplace/"
$ListName = "BuildingEmails"
$CSVFolder = "C:\Users\billn\Documents\Priority Items\Return to Work\Prod Sprint\Release steps\"
$CSVFields=@("Title","ContactList","DailyUpdate") # Not currently being used below
###!!! CSV Fields need to be hard coded in script below. 
###To Do: investigate using for loop to iterate through columns 
 
#Get the CSV file contents
$CSVData = Import-Csv -Path ($CSVFolder + $ListName + ".csv") -header "Title","ContactList","DailyUpdate" -delimiter "|"
 
#Connect to site
Connect-PnPOnline $SiteUrl -UseWebLogin
 
#Iterate through each Row in the CSV and import data to SharePoint Online List
foreach ($Row in $CSVData)
{
	if ($Row.Title -ne "Title")	
	{
		Add-PnPListItem -List "BuildingEmails" -Values @{"Title" = $($Row.Title);		
                            "ContactList" = $($Row.ContactList);							
                            "DailyUpdate" = $($Row.DailyUpdate);}
    }
}

