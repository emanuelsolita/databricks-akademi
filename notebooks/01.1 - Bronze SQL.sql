-- Databricks notebook source
-- MAGIC %md
-- MAGIC # Translate ingestion flow from pyspark

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Skapa en ny elpristabell med samma kolumner som i den andra tabellen fast med Spark SQL
-- MAGIC ```
-- MAGIC CREATE TABLE [IF NOT EXITS] catalog.schema.table
-- MAGIC (
-- MAGIC   COL1  DATA_TYPE,
-- MAGIC   COL2  DATA_TYPE,
-- MAGIC   ...
-- MAGIC   COLN  DATA_TYPE
-- MAGIC )
-- MAGIC ```

-- COMMAND ----------

create table if not exists emanuel_db.bronze.elprizer_bronze_sql
(
  EUR_per_kWh double, 
  EXR double,
  SEK_per_kWh double,
  elzon string,
  time_end string,
  time_start string
)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Use ```COPY INTO``` för data ingestion till den nyskapade tabellen
-- MAGIC
-- MAGIC - Filformat ```json```
-- MAGIC - Format Option ```('mergeSchema' = 'true')```
-- MAGIC - Copy Option ```('mergeSchema' = 'true')```

-- COMMAND ----------

copy into emanuel_db.bronze.elprizer_bronze_sql
from '/databricks_academy/raw/elpriser/'
FILEFORMAT = json
FORMAT_OPTIONS ('mergeSchema' = 'true')
COPY_OPTIONS ('mergeSchema' = 'true');

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Validera att allt ser ok ut med tex ```count(*)``` eller ```select * ... limit 10 ```

-- COMMAND ----------

select * from emanuel_db.bronze.elprizer_bronze_sql limit 10

-- COMMAND ----------

select count(*) from emanuel_db.bronze.elprizer_bronze_sql

-- COMMAND ----------

select count(*) from emanuel_db.bronze.elpriser_bronze

-- COMMAND ----------


