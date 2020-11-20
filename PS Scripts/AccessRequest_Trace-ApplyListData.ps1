#Config Variables
$SiteURL = "https://007gc.sharepoint.com/sites/RapportdeRetourauLieudeTravail-ReturntotheWorkplaceReporting/"
$ListName = "AccessRequest_Trace"
$CSVFolder = "C:\Users\billn\Documents\Priority Items\Return to Work\ogd-office-entry-am-entree-au-bureau-master\"
$CSVFields=@("Title","SeriesID","BuildingID","FloorID","StartHour","EndHour","Status","VisitorCount","EntryDate","EntryDateID","CheckIn","CheckOut", "CheckOutTime","EmployeeLogin","EmployeeName","EmployeeEmail","ManagerLogin","ManagerName","ManagerEmail","EquipmentEnglishText","EquipmentFrenchText","ReasonEnglishText", "ReasonFrenchText","ReasonDetail","RequestCount","VisitorReason") # Not currently being used below
###!!! CSV Fields need to be hard coded in script below. 
###To Do: investigate using for loop to iterate through columns 
 
#Get the CSV file contents
$CSVData = Import-Csv -Path ($CSVFolder + $ListName + ".csv") -header "Title","SeriesID","BuildingID","FloorID","StartHour","EndHour","Status","VisitorCount","EntryDate","EntryDateID","CheckIn","CheckOut", "CheckOutTime","EmployeeLogin","EmployeeName","EmployeeEmail","ManagerLogin","ManagerName","ManagerEmail","EquipmentEnglishText","EquipmentFrenchText","ReasonEnglishText", "ReasonFrenchText","ReasonDetail","RequestCount","VisitorReason" -delimiter "|"
 
#Connect to site
Connect-PnPOnline $SiteUrl -UseWebLogin
 
#Iterate through each Row in the CSV and import data to SharePoint Online List
foreach ($Row in $CSVData)
{
	if ($Row.Title -ne "Title")	
	{
		Add-PnPListItem -List "AccessRequest_Trace" -Values @{"Title" = $($Row.Title);		
                            "SeriesID" = $($Row.SeriesID);							
							"BuildingID" = $($Row.BuildingID);							
                            "FloorID" = $($Row.FloorID);							
                            "StartHour" = $($Row.StartHour);							
                            "EndHour" = $($Row.EndHour);							
                            "Status" = $($Row.Status);							
                            "VisitorCount" = $($Row.VisitorCount);							
                            "EntryDate" = $($Row.EntryDate);							
                            "EntryDateID" = $($Row.EntryDateID);
							"CheckOutTime" = $($Row.CheckOutTime);
							"EmployeeLogin" = $($Row.EmployeeLogin);
							"EmployeeName" = $($Row.EmployeeName);
							"EmployeeEmail" = $($Row.EmployeeEmail);
							"ManagerLogin" = $($Row.ManagerLogin);
							"ManagerName" = $($Row.ManagerName);
							"ManagerEmail" = $($Row.ManagerEmail);
							"EquipmentEnglishText" = $($Row.EquipmentEnglishText);
							"EquipmentFrenchText" = $($Row.EquipmentFrenchText);
							"ReasonEnglishText" = $($Row.ReasonEnglishText);
							"ReasonFrenchText" = $($Row.ReasonFrenchText);
							"ReasonDetail" = $($Row.ReasonDetail);
							"VisitorReason" = $($Row.VisitorReason);}
    }
}

