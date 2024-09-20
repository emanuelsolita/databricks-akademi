-- Databricks notebook source
-- MAGIC %md
-- MAGIC # Andra delen - Data transformation

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Skapa tabellerna ```elpriser``` och ```calendar``` i schemat ```silver```
-- MAGIC
-- MAGIC ***Tips*** för calendar som har så många kolumner. Skriv ut schemat från ```silver.calendar```. Notera python dekoreringen

-- COMMAND ----------

-- MAGIC %python
-- MAGIC spark.read.table("emanuel_db.silver.calendar").printSchema()

-- COMMAND ----------

create table if not exists emanuel_db.silver.calendar_sql
(
  Date timestamp,
  Day_Name string, 
  Day long,
  Week long,
  Month_Name string,
  Month long,
  Quarter long,
  Year long,
  Year_half long,
  FY long,
  EndOfMonth timestamp,
  date_start date
)

-- COMMAND ----------

create table if not exists emanuel_db.silver.elpriser_sql
(
  EUR_per_kWh   double,
  exchange_rate   double,
  SEK_per_kWh   double,
  elzon   string,           
  time_end  timestamp,
  time_start  timestamp,
  date_start  timestamp
)

-- COMMAND ----------

insert into emanuel_db.silver.calendar_sql
select 
  Date,
  Day_Name, 
  Day,
  Week,
  Month_Name,
  Month,
  Quarter,
  Year,
  Year_half,
  FY,
  EndOfMonth, 
  to_date(date) as date_start
from emanuel_db.bronze.calendar_bronze src
--no duplicate handler
where not exists 
  (
    select 1 from emanuel_db.silver.calendar_sql trg
    where trg.date = src.date
  )

-- COMMAND ----------

select count(*) from emanuel_db.silver.calendar_sql

-- COMMAND ----------

insert into emanuel_db.silver.elpriser_sql
select
  EUR_per_kWh,
  EXR as exchange_rate,
  SEK_per_kWh,
  elzon,           
  to_timestamp(time_end) as time_end,
  to_timestamp(time_start) as time_start,
  to_date(time_start) as date_start
from emanuel_db.bronze.elprizer_bronze_sql src
where not exists
  (
    select 1 from emanuel_db.silver.elpriser_sql trg
    where trg.time_start = src.time_start
    and trg.elzon = src.elzon
  )


-- COMMAND ----------

select count(*) from emanuel_db.silver.elpriser_sql

-- COMMAND ----------


