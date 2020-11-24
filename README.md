# ECCC-RetourauLieudeTravail-ReturntotheWorkplace
Environment and Climate Change Canada is committed to ensuring that the health and safety of every employee is protected while they are at work.  In the midst of the COVID-19 pandemic, this app was developed to support a safe, organized and gradual return to Environment and Climate Change Canada workplaces.  The app allows employees to request access to Environment and Climate Change Canada workplace sites, and managers to monitor, review and approve employee requests.

## Architecture Overview

The Return to the Workplace system is based on architecture dependant on office 365 E3 level standard licensing. In ECCC we do not have a gateway setup to connect from office 365 to local databases; this is the primary reason why the application and reporting all connect to SharePoint lists.

In order to setup the ECCC solution as-is you will need to have the following things available in your organization:

* Office 365 Outlook
* SharePoint (ECCC's solution uses two separate sites)
* Power BI Desktop
* PowerApps
* PowerAutomate

## PowerApp

The ECCC PowerApp is based on the Department of Justice's Covid-19 reentry application. ECCC has disabled, customized, and added functionality to support its unique requirements. Where possible we have simply commented our features that have been disabled. This should allow other department to easier re-add them into their application if they wish too.

## Flows

ECCC has created two separate SharePoint sites; one to drive the application and one to drive reporting. PowerAutomate Flows synchronize the data between these two sites.

The primary reason to separate out the reporting site from the master lists was to better secure the data. Reports such as the capacity planning dashboard have employee names remove to protect private information.


## PowerBI Reporting 
ECCC has customized two PowerBI dashboards that were created by DoJ. These are the capacity planning dashboard and the contact tracing dashboard. Both dashboard are run from user's desktop PowerBI program and they both are connected to the reporting SahrePoint site.

## Setup Guide

[read our setup guide](https://github.com/BillNixon/ECCC-RetourauLieudeTravail-ReturntotheWorkplace/blob/main/setup-manual.md)


## Changes From DoJ Version

The ECCC return to workplace application was based on the Department of Justice's Covid-19 Reentry application. Our customizations and changes have been documented in our [DoJ to ECCC Changelog](https://github.com/BillNixon/ECCC-RetourauLieudeTravail-ReturntotheWorkplace/blob/main/DoJ%20to%20ECCC%20Changelog.md)
