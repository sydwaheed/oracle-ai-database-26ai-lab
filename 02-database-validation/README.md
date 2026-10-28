# 02 - Database Validation

After the database became available, I opened Database Actions SQL Worksheet as the ADMIN user.

I wanted to confirm the database from SQL instead of depending only on the OCI console status.

## Database version

```sql
SELECT banner_full
FROM v$version
WHERE banner_full LIKE 'Oracle%Database%';
```

The result showed Oracle AI Database 26ai with release version 23.26.4.1.0.

## Session details

```sql
SELECT
    SYS_CONTEXT('USERENV','DB_NAME') AS database_name,
    SYS_CONTEXT('USERENV','CON_NAME') AS container_name,
    SYS_CONTEXT('USERENV','CURRENT_USER') AS current_user,
    TO_CHAR(SYSDATE,'DD-MON-YYYY HH24:MI:SS') AS database_time
FROM dual;
```

The session was connected as ADMIN to the Autonomous database container.

The OCI page confirmed that the service was available. These SQL queries confirmed that Database Actions was connected to the expected running database.

The reusable SQL is in [database-validation.sql](database-validation.sql).
