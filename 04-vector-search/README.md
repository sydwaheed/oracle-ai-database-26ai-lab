# 04 - Native Vector Search

For this lab I used the native `VECTOR` datatype in Oracle AI Database 26ai and compared stored vectors with `VECTOR_DISTANCE`.

## Vector column

```sql
ITEM_VECTOR VECTOR(3, FLOAT32)
```

I entered small three dimensional vectors manually so the values and results are easy to inspect. They are not embeddings produced by a model.

## Test data

| Item | Vector |
| --- | --- |
| Oracle Database Administration | [1,0,0] |
| RMAN Backup and Recovery | [0.9,0.1,0] |
| Data Guard High Availability | [0.8,0.2,0.1] |
| Linux System Administration | [0,1,1] |

Reference vector:

```text
[1,0,0]
```

## Distance calculation

```sql
VECTOR_DISTANCE(ITEM_VECTOR, '[1,0,0]', COSINE)
```

A lower cosine distance means the two vectors are closer for this calculation.

## Result

| Item | Cosine distance |
| --- | ---: |
| Oracle Database Administration | 0 |
| RMAN Backup and Recovery | 0.006116 |
| Data Guard High Availability | 0.036913 |
| Linux System Administration | 1 |

The exact matching vector returned zero and the remaining rows were ordered by their calculated distance.

The complete SQL is in [vector-search.sql](vector-search.sql).
