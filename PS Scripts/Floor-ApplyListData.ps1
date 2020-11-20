#Config Variables
$SiteURL = "https://007gc.sharepoint.com/sites/OfficeEntry-Pilot"
$ListName = "Floor"
$CSVFolder = "C:\Users\billn\Documents\Priority Items\Return to Work\ogd-office-entry-am-entree-au-bureau-master\"
$CSVFields=@("Title","BuildingID","FloorEnglishText","FloorFrenchText","FloorSortOrder","Capacity","CurrentCapacity","DefaultCapacityFlag","ChangeReason","MissionCritical") # Not currently being used below
###!!! CSV Fields need to be hard coded in script below. 
###To Do: investigate using for loop to iterate through columns 
 
#Get the CSV file contents
$CSVData = Import-Csv -Path ($CSVFolder + $ListName + ".csv") -header "Title","BuildingID","FloorEnglishText","FloorFrenchText","FloorSortOrder","Capacity","CurrentCapacity","DefaultCapacityFlag","ChangeReason","MissionCritical" -delimiter "|"
 
#Connect to site
Connect-PnPOnline $SiteUrl -UseWebLogin
 
#Iterate through each Row in the CSV and import data to SharePoint Online List
foreach ($Row in $CSVData)
{
	if ($Row.Title -ne "Title")	
	{

		Add-PnPListItem -List $ListName -Values @{"Title" = $($Row.Title);		
                            "BuildingID" = $($Row.BuildingID);
                            "FloorEnglishText" = $($Row.FloorEnglishText);
                            "FloorFrenchText" = $($Row.FloorFrenchText);
                            "FloorSortOrder" = $($Row.FloorSortOrder);
                            "Capacity" = $($Row.Capacity);
                            "CurrentCapacity" = $($Row.CurrentCapacity);
							"MissionCritical" = $($Row.MissionCritical);}
    }
}

