#Config Variables
$SiteURL = "https://007gc.sharepoint.com/sites/OfficeEntry-Pilot"
$ListNames = @("AccessRequest_Dashboard", "Date_Dashboard", "AccressRequest_Trace", "VisitorLog", "Building", "Floor", "Equipment_Dashboard")
$ListsOutputFile = "C:\Users\billn\Documents\Priority Items\Return to Work\ogd-office-entry-am-entree-au-bureau-master\Pilot_to_ProdListSchemas.xml"
 
#Connect to PNP Online
Connect-PnPOnline -Url $SiteURL -UseWebLogin
 
#Get the List schemas from the Site Templates and export to XML file
$Templates = Get-PnPProvisioningTemplate -OutputInstance -Handlers Lists -ListsToExtract $ListNames 
Save-PnPProvisioningTemplate -InputInstance $Templates -Out ($ListsOutputFile)	

