-- Databricks notebook source
-- MAGIC %md
-- MAGIC # Sista delen - Gold

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Skapa en vy som är redo att konsumeras av verksamheten

-- COMMAND ----------

CREATE OR REPLACE view emanuel_db.gold.view_elpriser_sql AS
  SELECT
      el.date_start,
      SEK_per_kWh,
      EUR_per_kWh,
      exchange_rate,
      elzon,
      time_start,
      time_end,
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
      EndOfMonth
FROM emanuel_db.silver.elpriser_sql el
left JOIN 
(select *, to_date(date) as date_start_cal from emanuel_db.silver.calendar_sql) cal
on el.date_start = cal.date_start_cal

-- COMMAND ----------

select * from emanuel_db.gold.view_elpriser_sql

-- COMMAND ----------


