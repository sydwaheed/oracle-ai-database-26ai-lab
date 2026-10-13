# 01 - Autonomous AI Database Setup

This section records the setup choices used for the cloud lab.

## Lab configuration

| Setting | Value |
| --- | --- |
| Display name | ADB26AI-LAB |
| Database name | ADB26AILAB |
| Workload | Transaction Processing |
| Database version | Oracle AI Database 26ai |
| Service | Autonomous AI Database Serverless |
| Instance type | Always Free |
| Region used in the lab | India West (Mumbai) |

## Provisioning approach

I used an Always Free Autonomous AI Database so the environment could remain available as a repeatable learning lab without creating a paid database resource.

For the workload, I selected **Transaction Processing** because the SQL activity in this lab is centered on relational DDL, DML, querying, and vector operations rather than an analytics-only workload.

The database version was set to **26ai** so the same environment could be used to explore the native VECTOR datatype and vector distance functions.

## Network access

For this personal lab, database access was configured through the public service endpoint.

This choice was made for convenience in a disposable learning environment. A production design should apply network restrictions and security controls appropriate to the application and organization.

## Validation checkpoint

Before running SQL, I waited for the database state to become:

```text
Available
```

The next section validates the running database from Database Actions instead of relying only on the OCI resource page.
