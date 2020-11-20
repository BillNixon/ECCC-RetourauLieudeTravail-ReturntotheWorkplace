#Config Variables
$SiteURL = "https://007gc.sharepoint.com/sites/OfficeEntry-Pilot/"
$ListName = "UserSetting"
$CSVFolder = "C:\Users\billn\Documents\Priority Items\Return to Work\ogd-office-entry-am-entree-au-bureau-master\"
$CSVFields=@("Title","AgreedToPrivacy","AgreedToHealthSafety", "ManagerLogin", "AssistantLogin", "SendPushNotifications", "BypassApprovalStep") # Not currently being used below
###!!! CSV Fields need to be hard coded in script below. 
###To Do: investigate using for loop to iterate through columns 
 
#Get the CSV file contents
$CSVData = Import-Csv -Path ($CSVFolder + $ListName + ".csv") -header "Title","AgreedToPrivacy","AgreedToHealthSafety", "ManagerLogin", "AssistantLogin", "SendPushNotifications", "BypassApprovalStep" -delimiter "|"
 
#Connect to site
Connect-PnPOnline $SiteUrl -UseWebLogin
 
#Iterate through each Row in the CSV and import data to SharePoint Online List
foreach ($Row in $CSVData)
{
	if ($Row.Title -ne "Title")	
	{
		Add-PnPListItem -List $ListName -Values @{"Title" = $($Row.Title);		
                            "AgreedToPrivacy" = $($Row.AgreedToPrivacy);
                            "AgreedToHealthSafety" = $($Row.AgreedToHealthSafety);
							"ManagerLogin" = $($Row.ManagerLogin);
							"AssistantLogin" = $($Row.AssistantLogin);
							"SendPushNotifications" = $($Row.SendPushNotifications);
							"BypassApprovalStep" = $($Row.BypassApprovalStep);}
    }
}

