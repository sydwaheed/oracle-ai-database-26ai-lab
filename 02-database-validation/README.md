# 02 - Database Validation

After the Autonomous AI Database became available, I opened **Database Actions SQL Worksheet** as the ADMIN database user.

The goal here was to prove the database version and active SQL session from inside the database.

## Version check

The first query reads the database banner:

```sql
SELECT banner_full
FROM v$version
WHERE banner_full LIKE 'Oracle%Database%';
```

The lab returned Oracle AI Database 26ai with release version 23.26.4.1.0.

## Session identity check

The second query confirms the current database, container, user, and database time:

```sql
SELECT
    SYS_CONTEXT('USERENV','DB_NAME') AS database_name,
    SYS_CONTEXT('USERENV','CON_NAME') AS container_name,
    SYS_CONTEXT('USERENV','CURRENT_USER') AS current_user,
    TO_CHAR(SYSDATE,'DD-MON-YYYY HH24:MI:SS') AS database_time
FROM dual;
```

The session was connected as ADMIN to the Autonomous database container.

## Why I used both checks

The OCI console proves that the cloud resource exists and is available.

The SQL checks prove that Database Actions is connected to the running database and that SQL is being executed against the expected Oracle AI Database 26ai environment.

See [database-validation.sql](database-validation.sql) for the reusable queries.
