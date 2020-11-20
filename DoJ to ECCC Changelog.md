1. **Bypass Code Changes**
To support the manager approval bypass requirement the follow is required:

- SelectTimeSlot screen; BtnNext_7 requires the following code: If(_userSetting.BypassApprovalStep = true && !IsBlank(_userSetting.ManagerLogin) ,Navigate(AgreeToCancel, None),
Navigate(SelectManager,ScreenTransition.None)); //bypass code

- SubmitScreen screen; btnSubmit requires the following code:
ManagerLogin: If(_userSetting.BypassApprovalStep = true && !IsBlank(_userSetting.ManagerLogin), _userSetting.ManagerLogin, _selectedManager.UserPrincipalName),//bypass code
            ManagerName: If(_userSetting.BypassApprovalStep = true && !IsBlank(_userSetting.ManagerLogin), _userSetting.ManagerLogin, _selectedManager.DisplayName), //bypass code
            ManagerEmail: If(_userSetting.BypassApprovalStep = true && !IsBlank(_userSetting.ManagerLogin), _userSetting.ManagerLogin,managerEmail) //bypass code

2. **Building ID**
Need to add building ID to the app + SharePoint Lists
- BuildingID (single line of text) was added to the AccessRequest SharePoint List.

- SubmitScreen; btnSubmit added following code under "ForAll(VarRequests,: BuildingID: _selectedBuilding.Title,

- Manage Screen; Label13_2 added following code: LookUp(Building, Title = _selectedRequest.BuildingID, If(_myLang = "fr", BuildingFrenchText,BuildingEnglishText)) & " - " &

- OfficeEntry Screen; Label30 (newly created) added following code:
LookUp(Building, Title = _officeEntry.BuildingID, If(_myLang = "fr", BuildingFrenchText, BuildingEnglishText))

- EmployeeHome Screen created Label35 then added code:
ThisItem.BuildingLabel

- ManagerHome Screen created Label36 then added code:
ThisItem.BuildingLabel

- MangerHome Screen; Gallery4_1 added code:
"BuildingLabel",
        LookUp(Building, Title = BuildingID, If(_myLang = "fr", BuildingFrenchText, BuildingEnglishText))

- OfficeEntryShow Screen created Label37 then added code:
LookUp(Building, Title = _officeEntry.BuildingID, If(_myLang = "fr", BuildingFrenchText, BuildingEnglishText))

- SelectTimeSlot Screen created Label38 then added code:
_selectedBuilding.Label


3. **Text Changes DOJ to ECCC**
Need to change some text to remove references to DOJ materials
- OfficeEntryShow; Label5:
If(_myLang = "fr", "Environnement et Changement climatique Canada", "Environment and Climate Change Canada")

- UpdateStatus Screen; btnSendApprovedEmail:

- OfficeEntryShow Screen; Label5 add code:
If(_myLang = "fr", "Environnement et Changement climatique Canada", "Environment and Climate Change Canada")

- EquipmentConsideration Screen; HTMLText2_1 added code:
If(_myLang = "fr", "<p>Si l’option d’accéder l’édifice n’est pas envisageable pour vous, d’autres alternatives telles que l'achat ou la livraison d'équipements devraient être considérées (à noter : Si des déménageurs sont nécessaires, le gestionnaire est responsable des coûts).</p>
<p>Si cette demande concerne une obligation de prendre des mesures d’adaptation, les gestionnaires devraient communiquer avec leur conseiller en relations de travail afin d’obtenir des conseils et des directives. Dans le cas où l'employé a besoin d'aide pour récupérer un item plus imposant, veuillez contacter votre service d’installations régionales pour obtenir de l’aide :</p><ul><li><a href='mailto:ec.installationsatl-facilitiesatl.ec@canada.ca'>Installations ATL / Facilities ATL</a></li><li><a href='mailto:ec.installationsque-facilitiesque.ec@canada.ca'>Installations QUE / Facilities QUE</a></li><li><a href='mailto:ec.installationsrcn-facilitiesncr.ec@canada.ca'>Installations RCN / Facilities NCR</a></li><li><a href='mailto:ec.facilitiesmanagement.ontario.ec@canada.ca'>Installations Ontario / Facilities Ontario</a></li><li><a href='mailto:ec.installationsrpn-facilitiespnr.ec@canada.ca'>Installations RPN / Facilities PNR</a></li><li><a href='mailto:ec.installationsrpy-facilitiespyr.ec@canada.ca'>Installations RPY / Facilities PYR</a></li></ul>",
"<p>If the option to access the building to retrieve equipment is deemed not viable for you, other alternatives such as purchasing or delivery of items should be considered. (note: If movers are required, the manager is responsible for the cost).</p>
<p>If this request relates to a Duty to Accommodate Plan, managers should contact their Labour Relations Advisor for advice and guidance. In the event the employee requires support to retrieve a larger asset, please contact your regional facilities service for assistance: </p><ul><li><a href='mailto:ec.installationsatl-facilitiesatl.ec@canada.ca'>Installations ATL / Facilities ATL</a></li><li><a href='mailto:ec.installationsque-facilitiesque.ec@canada.ca'>Installations QUE / Facilities QUE</a></li><li><a href='mailto:ec.installationsrcn-facilitiesncr.ec@canada.ca'>Installations RCN / Facilities NCR</a></li><li><a href='mailto:ec.facilitiesmanagement.ontario.ec@canada.ca'>Installations Ontario / Facilities Ontario</a></li><li><a href='mailto:ec.installationsrpn-facilitiespnr.ec@canada.ca'>Installations RPN / Facilities PNR</a></li><li><a href='mailto:ec.installationsrpy-facilitiespyr.ec@canada.ca'>Installations RPY / Facilities PYR</a></li></ul>") `

- Contact Screen; AboutBannerDescription_1 and added code:
**need code changes**

- VisitorConsideration Screen; HtmlText2_2 added code:
**need code changes**

- LoginScreen Screen ; Label8_3 added code:
If(_myLang = "fr", "Soutien: ec.servicedesk.ec@canada.ca", "Support: ec.servicedesk.ec@canada.ca")

- Update all Text in the TextTemplate List in EN and FR
About_, Privacy_, Visitor_Attestation_Impersonating_, Approved_Email, Check_in_Reminder, Visitor_Attestation_Email, Denied_Cancelled_Email, Check_out_Reminder, Health_and_Safety_01, Health_and_Safety_02, Health_and_Safety_03, Health_and_Safety_08, 

4. **Feedback Feature**

5. **Office Equipment**
- Currently EC has turned off the office equipment pick-up. The code changes below mark how we disabled the feature

6. **Manager re-select Screen**
- added a duplicate of the SelectManager screen, called it SelectNewManager
- Change the new screen's title to 'select your manager'
- Changed the new screen's select action when clicking a name on the search results. The new action updates the usersetting list with the selected manager email. Here is the new action code:


>>>> Set(_selectedManager, ThisItem);
UpdateIf(UserSetting, Title = _myProfile.userPrincipalName, {ManagerLogin: _selectedManager.UserPrincipalName});
Navigate(EmployeeHome, None);

- Added a link in the Nav Menu to get to the select your manager screen

7. **Email Lookup Feature & Office365Outlook**

on the apps code added this line:
>> Set(_alternateEmail, LookUp(EmailLookup, O365LoginName = _myUPN, EmailAddress));


On the submit screen btnsubmit changed this code:
>>>>Set(
    _alternateManagerEmail,
    LookUp(
        EmailLookup,
        Lower(O365LoginName) = Lower(managerEmail),
        EmailAddress
    )
);
UpdateContext(
    {
        EmailTo: Concatenate(
            managerEmail,
            ";",
            _myPreferredEmail,
            ";",
            If(
                IsBlank(_alternateEmail),
                Substitute(
                    _myPreferredEmail,
                    "ec.gc.ca",
                    "canada.ca"
                ),
                _alternateEmail
            ),
            ";",
            If(
                IsBlank(_alternateManagerEmail),
                Substitute(
                    managerEmail,
                    "ec.gc.ca",
                    "canada.ca"
                ),
                _alternateManagerEmail
            )
        ),
        EmailSubject

and this block
>>>>Office365Outlook.SendEmailV2(
            EmailTo,
            Substitute(Substitute(Substitute(EmailSubject,"â","a"),"é","e"),"É","E"),
            Substitute(Substitute(Substitute(EmailBody,"â","&acirc;"),"é","&eacute;"),"É","&Eacute;")
        );

on the UpdateStatus Screen, btnSendApproveEmail

>>>>Set(_alternateEmployeeEmail, LookUp(EmailLookup, _selectedRequest.EmployeeEmail = O365LoginName, EmailAddress));

>>>>UpdateContext(
{    
    EmailTo: Concatenate(_selectedRequest.EmployeeEmail,";", If(IsBlank(_alternateEmployeeEmail), Substitute(_selectedRequest.EmployeeEmail,"ec.gc.ca","canada.ca"),_alternateEmployeeEmail)),    
    EmailSubject:

and this block
>>>>Office365Outlook.SendEmailV2(
            EmailTo,
            Substitute(Substitute(Substitute(EmailSubject,"â","a"),"é","e"),"É","E"),
            Substitute(Substitute(Substitute(EmailBody,"â","&acirc;"),"é","&eacute;"),"É","&Eacute;")
        );


on the btnSendDeniedCancelledEmail in the UpdateStatus screen. changed the following code:

>>>>Set(_alternateEmployeeEmail, LookUp(EmailLookup, _selectedRequest.EmployeeEmail = O365LoginName, EmailAddress));
Set(_alternateManagerEmail, LookUp(EmailLookup, _selectedRequest.ManagerEmail = O365LoginName, EmailAddress));

>>>>UpdateContext({
    EmailTo: Concatenate(_selectedRequest.ManagerEmail, ";" , If(IsBlank(_alternateManagerEmail), Substitute(_selectedRequest.ManagerEmail,"ec.gc.ca","canada.ca"),_alternateManagerEmail),";", _selectedRequest.EmployeeEmail, ";", If(IsBlank(_alternateEmployeeEmail), Substitute(_selectedRequest.EmployeeEmail,"ec.gc.ca","canada.ca"),_alternateEmployeeEmail)),    
    EmailSubject:

and this block
>>>>Office365Outlook.SendEmailV2(
            EmailTo,
            Substitute(Substitute(Substitute(EmailSubject,"â","a"),"é","e"),"É","E"),
            Substitute(Substitute(Substitute(EmailBody,"â","&acirc;"),"é","&eacute;"),"É","&Eacute;")
        );


8. **Proof Screen Link**
on the OfficeEntry screen added a 'proof screen' button at the bottom of the screen. The button is defaulted to disabled. In the display mode property of the button the following code is set:

>>If(entryStatus <> "NOT_APPROVED", DisplayMode.Edit, DisplayMode.Disabled)

9. **Misc Changes**
Miscellaneous APP changes that should be captured

- fix issue with spacing on the screen
Manage Screen; HTMLText2 edited the code like this:
Concatenate(
    "<strong>" & If(_myLang = "fr", 
        _selectedRequest.ReasonFrenchText, 
        _selectedRequest.ReasonEnglishText) & "<br/></strong> ",
    If(!IsBlank(_selectedRequest.EquipmentEnglishText), 
        If(_myLang = "fr", _selectedRequest.EquipmentFrenchText, _selectedRequest.EquipmentEnglishText) & ". "
    ),
    _selectedRequest.ReasonDetail
)
