#Config Variables
$SiteURL = "https://007gc.sharepoint.com/sites/OfficeEntry-Pilot"
$ListName = "Date_Dashboard"
$CSVFolder = "C:\Users\billn\Documents\Priority Items\Return to Work\ogd-office-entry-am-entree-au-bureau-master\"
$CSVFields=@("Title","DateKey","Date","DateType","MonthStartDate","MonthEndDate","Month","MonthOrder","QuarterStartDate","QuarterEndDate","QuarterShort","QuarterShortOrder","YearStartDate","YearEndDate","FiscalYearStartDate","FiscalYearEndDate","FiscalYear","FiscalYearOrder") # Not currently being used below
###!!! CSV Fields need to be hard coded in script below. 
###To Do: investigate using for loop to iterate through columns 
 
#Get the CSV file contents
$CSVData = Import-Csv -Path ($CSVFolder + $ListName + ".csv") -header "Title","DateKey","Date","DateType","MonthStartDate","MonthEndDate","Month","MonthOrder","QuarterStartDate","QuarterEndDate","QuarterShort","QuarterShortOrder","YearStartDate","YearEndDate","FiscalYearStartDate","FiscalYearEndDate","FiscalYear","FiscalYearOrder" -delimiter "|"
 
#Connect to site
Connect-PnPOnline $SiteUrl -UseWebLogin
 
#Iterate through each Row in the CSV and import data to SharePoint Online List
foreach ($Row in $CSVData)
{
	if ($Row.Title -ne "Title")	
	{
		Add-PnPListItem -List "Date_Dashboard" -Values @{"Title" = $($Row.Title);		
                            "DateKey"= $($Row.DateKey);
							"Date"= $($Row.Date);
							"DateType"= $($Row.DateType);
							"MonthStartDate"= $($Row.MonthStartDate);
							"MonthEndDate"= $($Row.MonthEndDate);
							"Month"= $($Row.Month);
							"MonthOrder"= $($Row.MonthOrder);
							"QuarterStartDate"= $($Row.QuarterStartDate);
							"QuarterEndDate"= $($Row.QuarterEndDate);
							"QuarterShort"= $($Row.QuarterShort);
							"QuarterShortOrder"= $($Row.QuarterShortOrder);
							"YearStartDate"= $($Row.YearStartDate);
							"YearEndDate"= $($Row.YearEndDate);
							"FiscalYearStartDate"= $($Row.FiscalYearStartDate);
							"FiscalYearEndDate"= $($Row.FiscalYearEndDate);
							"FiscalYear"= $($Row.FiscalYear);
							"FiscalYearOrder"= $($Row.FiscalYearOrder)}
    }
}

