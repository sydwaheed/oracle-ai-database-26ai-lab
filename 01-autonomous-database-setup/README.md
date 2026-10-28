# 01 - Autonomous AI Database Setup

I used an Always Free Autonomous AI Database for the first cloud lab.

## Configuration

| Setting | Value |
| --- | --- |
| Display name | ADB26AI-LAB |
| Database name | ADB26AILAB |
| Workload | Transaction Processing |
| Database version | Oracle AI Database 26ai |
| Service | Autonomous AI Database Serverless |
| Instance type | Always Free |
| Region | India West (Mumbai) |

## Why I selected these options

I selected Transaction Processing because the lab uses normal relational DDL, DML and queries before moving to vector operations.

Oracle AI Database 26ai was selected so I could test the native `VECTOR` datatype in the same environment.

For this personal lab I used the public service endpoint. In a production environment the access model would depend on the network and security requirements.

## Check after creation

I waited until the database status showed:

```text
Available
```

After that I opened Database Actions and continued with the SQL checks in the next folder.
