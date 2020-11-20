#Config Variables
$SiteURL = "https://007gc.sharepoint.com/sites/RapportdeRetourauLieudeTravail-ReturntotheWorkplaceReporting/"
$TemplateFile = "C:\Users\billn\Documents\Priority Items\Return to Work\ogd-office-entry-am-entree-au-bureau-master\ReportListSchemas.xml"
 
#Connect to PNP Online
Connect-PnPOnline -Url $SiteURL -UseWebLogin
 
Write-Host "Creating List(s) from Template File..."
Apply-PnPProvisioningTemplate -Path $TemplateFile

