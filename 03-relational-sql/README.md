# 03 - Relational SQL

Before testing vector features, I ran a normal relational SQL exercise in Database Actions.

The lab creates a small activity table, inserts rows, commits the transaction, queries the data and updates one row.

## Table

`LAB_ACTIVITY_LOG` contains:

| Column | Use |
| --- | --- |
| ACTIVITY_ID | Identity primary key |
| ACTIVITY_NAME | Lab activity |
| STATUS | Activity status |
| CREATED_ON | Database generated timestamp |

## SQL flow

```text
CREATE TABLE
INSERT
COMMIT
SELECT
UPDATE
COMMIT
SELECT
```

At the end of the lab all four rows showed `COMPLETED`.

The SQL used is in [relational-lab.sql](relational-lab.sql).
