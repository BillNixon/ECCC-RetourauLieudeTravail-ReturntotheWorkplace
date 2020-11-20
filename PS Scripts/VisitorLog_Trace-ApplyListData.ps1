#Config Variables
$SiteURL = "https://007gc.sharepoint.com/sites/RapportdeRetourauLieudeTravail-ReturntotheWorkplaceReporting/"
$ListName = "VisitorLog_Trace"
$CSVFolder = "C:\Users\billn\Documents\Priority Items\Return to Work\ogd-office-entry-am-entree-au-bureau-master\"
$CSVFields=@("Title","AccessRequestID","VisitorName","VisitorEmail","VisitorPhone") # Not currently being used below
###!!! CSV Fields need to be hard coded in script below. 
###To Do: investigate using for loop to iterate through columns 
 
#Get the CSV file contents
$CSVData = Import-Csv -Path ($CSVFolder + $ListName + ".csv") -header "Title","AccessRequestID","VisitorName","VisitorEmail","VisitorPhone" -delimiter "|"
 
#Connect to site
Connect-PnPOnline $SiteUrl -UseWebLogin
 
#Iterate through each Row in the CSV and import data to SharePoint Online List
foreach ($Row in $CSVData)
{
	if ($Row.Title -ne "Title")	
	{
		Add-PnPListItem -List $ListName -Values @{"Title" = $($Row.Title);		
                            "AccessRequestID" = $($Row.AccessRequestID);
                            "VisitorName" = $($Row.VisitorName);
							"VisitorEmail" = $($Row.VisitorEmail);
							"VisitorPhone" = $($Row.VisitorPhone);}
    }
}

