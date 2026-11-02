# 09 - Oracle APEX DBA Inventory Application

In this lab I provisioned an OCI Autonomous Database with the APEX workload and built a small DBA inventory application in Oracle APEX.

The activity was completed in my personal OCI lab and uses only lab-created names and sample data.

| Item | Configuration |
| --- | --- |
| OCI region | India West (Mumbai) |
| Compartment | QUALTIQ-WEB |
| Autonomous Database | APEX-LAB-DB |
| Database name | APEXLABDB |
| Workload | APEX |
| APEX workspace | DBA_LAB |
| Workspace administrator | DBAADMIN |
| Application | OCI DBA Lab Manager |
| Application ID | 100 |

## Autonomous Database and APEX workspace

I created a new Autonomous Database Serverless instance using the APEX workload and verified that the database and associated APEX instance were available before starting application development.

I then opened APEX Administration Services with the database administrator account and created a dedicated workspace named `DBA_LAB` with its own schema and workspace administrator.

## DBA inventory data model

Inside SQL Workshop I created the `DBA_LAB_DATABASES` table for a small database inventory.

The table stores:

- database name and type
- environment and version
- host name
- operational status
- DR enabled flag
- region and owner team
- last checked date
- notes

Database constraints restrict the allowed environment, status and DR values.

Seven sample database records were loaded for the lab.

The reusable SQL used for the table and sample data is stored in:

[`dba-lab-databases.sql`](dba-lab-databases.sql)

## APEX application

I created an application named `OCI DBA Lab Manager` using App Builder.

The application includes:

1. Home page
2. Database Inventory Interactive Report
3. Modal DML form for create and edit operations
4. Login page

The Interactive Report is based on `DBA_LAB_DATABASES` and supports normal APEX report functions such as search, Actions and record editing.

## Controlled input values

The generated form initially used free-text items for several fields.

I changed these to Select Lists with static List of Values definitions:

| Item | Allowed values |
| --- | --- |
| Environment | PROD, UAT, DEV, TEST, DR |
| Status | ACTIVE, STANDBY, STOPPED, MAINTENANCE |
| DR Enabled | YES, NO |

This keeps user input aligned with the database data model.

## Server-side validation

I added an APEX validation named `Validate DR Environment`.

The validation prevents a record from being saved with DR enabled while the environment is DEV or TEST.

The PL/SQL expression used is:

```plsql
:P3_DR_ENABLED = 'NO'
OR :P3_ENVIRONMENT NOT IN ('DEV','TEST')
```

The validation was tested by setting DR Enabled to `YES` and Environment to `DEV`.

APEX blocked the submission and displayed the configured error against the Environment item.

## Dynamic Action

I added a Static Content region named `DR Warning` with a short DR configuration notice.

A Dynamic Action named `Toggle DR Warning` runs when `P3_DR_ENABLED` changes.

When the value is `YES`, the native APEX Show action displays the warning region.

When the value is `NO`, the native Hide action removes it.

Both actions fire on initialization so the form state is correct immediately when the dialog opens.

## Final validation

Before considering the lab complete I checked the full flow:

- Autonomous Database available
- APEX instance available
- DBA_LAB workspace operational
- source table and seven sample rows present
- application authentication successful
- Interactive Report displaying the inventory
- modal form loading and editing rows
- Select List controls working at runtime
- invalid DR/environment combination blocked by server-side validation
- DR warning shown and hidden immediately through the Dynamic Action

This lab demonstrates how Oracle APEX can be used as a lightweight DBA-facing interface over normal Oracle database objects while still enforcing data quality at the UI, validation and database layers.
