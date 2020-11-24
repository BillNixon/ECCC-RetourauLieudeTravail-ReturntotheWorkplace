# Retour au Lieude Travail - Return to the Workplace Setup Manual

**Date: November 23rd 2020**

**Version: 2.0**

**Author: Based of the Rentry application from the Business Analytics Centre, Department of Justice. Modified by Environment and Climate Change Canada**


## Project Summary

The Retour au Lieude Travail - Return to the Workplace system allows employees to request access to specific floors for themselves and visitors in specific buildings during certain times, and for those requests to be approved by managers. This allows the department to ensure a safe environment with a much lower chance of employees coming into contact with each other. The system has been developed based on the Renrty application made by the Department of Justice Business Analytics Centre using the Office 365 Power Platform. The main pieces include a Power Apps application, PoerAutomate Flows, SharePoint lists, and PowerBI desktop dashboards. This document provides the details for setting up this application to work in a different Office 365 environment or under a different tenant.

## SharePoint Lists Overview

The solution uses PowerShell scripting and incorporates the SharePoint Patterns and Practices (PnP) library to populate the SharePoint environment. The first time you setup the SharePoint environment, you might first need to adjust your PowerShell environment, as described below.

##SharePoint Site Setup

Note that weird results may be expected if lists of the same name already exist in the SharePoint site. It is recommended to create a new, empty, SharePoint subsite for the lists that will be used by this app. To create a new subsite:
    - select **Site contents** on the left hand side of the SharePoint screen, then Select **New --> Subsite**
    - At minimum, provide a suitable **Title** and **Web Site Address**. The Template selection can be left as the default: Team site (no Office 365 group)
	
1. The solution ECCC design requires two separate SahrePoint sites. One is the application site used by the PowerApp. The other site is the reporting site used by the PowerBI Dashboard and accessed directly by report users.

### PowerShell and PnP Library Setup

1. Open a PowerShell window while logged in with an administrator account. This will require going to the folder that contains the executable for PowerShell (likely %SystemRoot%\system32\WindowsPowerShell\v1.0\), holding Control-Shift, and right-clicking to select &quot;Run as different user&quot;. Enter the administrator account credentials. Or, if you are already logged in as an administrator, you can just right-click and select &quot;Run as Administrator&quot;.
2. Run the command **Get-ExecutionPolicy**
3. If the current policy is not set to &quot;Unrestricted&quot;, run the command **Set-ExecutionPolicy Unrestricted**. \*\* Note: for safety, it is advised to switch the policy back to what it previously was, if it was not Unrestricted already, after you are done all of the required tasks in PowerShell.
4. Run this command to change the security protocol of your current session to TLS1.2: **[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12**
5. Install the PnP Library (if it has never been installed before) by running this command: **Install-Module SharePointPnPPowerShellOnline**
6. Run the command **$ExecutionContext.SessionState.LanguageMode**, to see if you are in Full language mode or constrained language mode.
7. If you are in constrained language mode, you will need to switch it to full by creating an environment variable called **\_PSLockDownPolicy** and giving it a value of 0, or changing its value to 0 if it already exists (if you are in constrained language mode, this variable likely has a value of 4). This can be done by doing observing the steps in this screenshot:

![](images/EnvironmentVariables-en.png)

\*\* Note: for safety, it is advised to switch the policy back to constrained language mode (i.e. changing the variable back to 4) if it was previously set to that mode, after you are done all of the required tasks in PowerShell.

### SharePoint List Templates Creation
The ECC solution requires two SharePoint sites. One is used for reporting and other supports the application. Power Automate flows synchronize the data between the two sites.

1. Close any PowerShell window that may be open and open a new one as an administrator, as per Step 1 of the previous section.
2. Open file **RLT_RTW_App_Site_ApplyListSchemas.ps1** for editing and update the variables **$SiteURL** with your target SharePoint site and **$File_Path** with the full path and filename of the XML file that contains the List Template definitions.
3. Open file **RLT_RTW_Reporting_Site_ApplyListSchemas.ps1** for editing and update the variables **$SiteURL** with your target SharePoint site and **$File_Path** with the full path and filename of the XML file that contains the List Template definitions.
4. Run the command **./RLT_RTW_App_Site_ApplyListSchemas.ps1** (note: you must be in the same directory as the script and the XML file when you run this.)
5. If you have not yet logged into Office 365 during this session, you will be prompted with a pop-up to login to Office 365 in the usual way.
6. The new lists will then be created on the target application SharePoint site.
7. For the Application site configure the permissions of the SharePoint site to permit users in the organization to have access to the new lists. If you want all organization users to the use the application add the 'Everyone except external users' group to the lists' share premissions
8. Run the command **./RLT_RTW_Reporting_Site_ApplyListSchemas.ps1** (note: you must be in the same directory as the script and the XML file when you run this.)
9. The new lists will then be created on the target reporting SharePoint site.
10. For the reporting site configure the permissions of the SharePoint site to permit users in the organization to have access to the new lists, for example, by creating a new group containing all desired report users. The permissions for the group could be: &quot;Users will only be able to view items from a remote interface.&quot;
11. If interested, refer to file **-GetListSchemas.ps1** files to see how the XML file was generated. This may come in handy if you wish to create a copy of the list templates on your own site to migrate to a different environment.

### Populating SharePoint Lists

Before running any -ApplyListData.ps1 files change the $SiteURL and $File_Path values to match you SharePoint URL and local file system.


1. Run the TextTemplate-ApplyListData.ps1 for the application SharePoint to update the ECCC text data from the TextTemplate.csv. This data is needed to popluate the emails and various screen in the application
2. If you've filled out of the Documentation\ECCC RTW Application Building and Floor Information Template.xlsx for floor and building data export the building and floor sheets to CSV. use  '|' as a separator and make sure all values are double quote enclosed
3. Run the Floor-ApplyListData.ps1 on both the application and reporting sites
4. Run the Building-ApplyListData.ps1 on both the application and reporting sites
5. If your organization requires email mapping from office365 accounts to Bell canada.ca account. Upload data into the Application's EmailLookup list using EmailLookup-ApplyListData.ps1

Scripts to upload or download data to all Sharepoint lists are included in the 'PS Scripts\' folder


## Power Apps Setup

### Installation

1. Navigate to the main page for Power Apps. This can be accessed at [https://make.powerapps.com](https://make.powerapps.com/). You will need to login with your Office 365 credentials if you have not already done so. Toggle to your desired environment at the top right of the window if required.
2. On the left hand menu, click **Apps**.
3. At the top menu of the webpage, select **Import canvas app**.
4. Click **Upload**, navigate to the folder that contains the saved ZIP file for the app and select it. It will upload. Once complete, click **Import**.
5. For **Review Package content**, if desired, select the wrench and change the app name to the desired name.
6. Select **Import**.

### App ID Configuration

1. On the main Apps page, click the … beside the imported app and click **Details**.
2. Copy the App ID that appears in the Details.
3. Back on the main Apps page, click the … beside the imported app and click **Edit**.
4. On the editing page, on the left hand side, click the three squares stacked on each other to bring up the **Tree View**.
5. For **Screens**, click **App** (the first item), then in the middle of the screen above the app view, refer to the code window beside the **fx** icon.
6. On the right hand side of the code window, click the down indicator to expand the window.
7. Find the section of the code that refers to **[YOUR_APP_ID_HERE]**. In the quotations, remove the text and paste the App ID that was copied in an earlier step.

###

### Data Source Linkages

All data sources have been stripped from the app prior to sharing it. Several data sources will therefore need to be added to the app as follows:

1. On the main Apps page, click the … beside the imported app and click **Edit**.
2. On the editing page, on the left hand side, click the cylinder to bring up the Data Sources menu.
3. Expand the **Connectors** submenu
4. Select **Office 365 Outlook** and then **Add a connection**. Then **Connect**.
5. Select **Office 365 Users** and then **Add a connection**. Then **Connect**.
6. Select **SharePoint** and then **Add a connection**. Ensure radio button is on **Connect directly (cloud services)** and then click **Connect**. Enter the URL of the application SharePoint site that contains all the lists you created, then click **Connect**. Select these lists that you previously created: AccessRequest, Building, EmailLookup, EmailQueue, Floor, LoginLog, TextTemplate, UserSetting, VisitorAttestation, VisitorLog; then click **Connect**.
7. Select **Power Apps Notification** and then **Add a connection**. For the target application, enter the App ID from the previous section, then click **Connect**.

### Enabling App Usage

1. On the main Apps page, click the … beside the imported app and click **Details**.
2. Select the **Versions** view.
3. Select the … beside the version you wish to publish, if it is not already Live.
4. Select **Publish this version** , then **Publish this version**.
5. On the main Apps page, click the … beside the app and click **Share**.
6. Add users as desired or pick the 'everyone' group if your sharing to all users in your organization, then click **Share**.
7. Each user will require access to the application SharePoint lists in order for the application to function correctly
