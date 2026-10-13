# 04 - Native Vector Search

This section uses an Oracle AI Database 26ai feature that is different from ordinary relational SQL.

The lab stores vectors directly in a column defined with the native `VECTOR` datatype and then compares them using `VECTOR_DISTANCE`.

## Vector table

The table uses:

```sql
ITEM_VECTOR VECTOR(3, FLOAT32)
```

For this exercise I used small, manually defined three-dimensional vectors so the calculation is easy to inspect.

These values are **not AI-generated embeddings**. A real embedding model would normally produce vectors with many more dimensions.

## Test vectors

| Item | Vector |
| --- | --- |
| Oracle Database Administration | [1,0,0] |
| RMAN Backup and Recovery | [0.9,0.1,0] |
| Data Guard High Availability | [0.8,0.2,0.1] |
| Linux System Administration | [0,1,1] |

The reference vector is:

```text
[1,0,0]
```

## Distance query

The query uses the COSINE metric:

```sql
VECTOR_DISTANCE(ITEM_VECTOR, '[1,0,0]', COSINE)
```

A smaller cosine distance means the vectors are closer under this metric.

## Result

| Item | Cosine distance |
| --- | ---: |
| Oracle Database Administration | 0 |
| RMAN Backup and Recovery | 0.006116 |
| Data Guard High Availability | 0.036913 |
| Linux System Administration | 1 |

The result matched the expected ordering for the manually selected vectors.

See [vector-search.sql](vector-search.sql) for the complete script.
