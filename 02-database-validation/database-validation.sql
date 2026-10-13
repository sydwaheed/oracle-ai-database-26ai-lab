-- Oracle AI Database 26ai
-- Database validation queries

SELECT banner_full
FROM v$version
WHERE banner_full LIKE 'Oracle%Database%';

SELECT
    SYS_CONTEXT('USERENV','DB_NAME') AS database_name,
    SYS_CONTEXT('USERENV','CON_NAME') AS container_name,
    SYS_CONTEXT('USERENV','CURRENT_USER') AS current_user,
    TO_CHAR(SYSDATE,'DD-MON-YYYY HH24:MI:SS') AS database_time
FROM dual;
