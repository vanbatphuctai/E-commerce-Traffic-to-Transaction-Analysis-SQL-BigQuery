# 📊 E-Commerce Traffic-to-Transaction Analysis | SQL & Google BigQuery

**Author:** Van Bat Phuc Tai  
**Tools:** SQL, Google BigQuery  

---

## 📑 Table of Contents

- 📌 [Background & Business Context](#-background--business-context)
- 🎯 [Key Business Questions](#-key-business-questions)
- 👥 [Target Audience](#-target-audience)
- 📂 [Dataset Description](#-dataset-description)
- 📊 [Dataset Overview](#-dataset-overview)
- 🔎 [Final Conclusion & Recommendations](#-final-conclusion--recommendations)


---

## 📌 Background & Business Context

In today’s **data-driven e-commerce environment**, understanding how users interact with a website is essential for **optimizing conversion rates** and driving **sustainable revenue growth**.

This project analyzes **website performance** and **customer purchasing behavior** using **SQL in Google BigQuery**. By transforming **raw session-level analytics data** into **structured insights**, the project supports **data-informed decision-making** across **marketing, product, and business strategy** functions.

---

## 🎯 Key Business Questions

- 📈 Evaluate how **traffic, engagement, and transaction trends** evolve over time to identify growth patterns and performance gaps.

- 💰 Identify **high-performing acquisition channels** that drive the strongest revenue contribution and ROI.

- 👥 Compare **purchaser vs. non-purchaser behavior** to uncover key behavioral drivers influencing conversion.

- 🔄 Analyze the **end-to-end conversion funnel** (product view → add to cart → purchase) to detect drop-offs and optimization opportunities.


---

## 👥 Target Audience

This analysis is relevant for:

- Data Analysts & Business Analysts  
- Digital Marketing Teams  
- E-commerce & Growth Managers  
- Business Intelligence & Strategy Teams  

---

## 📂 Dataset Description

### 📌 Data Source

This project uses publicly available sample data from **Google Analytics (Universal Analytics)**, hosted in Google BigQuery.

The dataset contains anonymized session-level activity from the Google Merchandise Store e-commerce website, including:

- Website traffic metrics (sessions, pageviews, visits)  
- User engagement behavior  
- Transaction and revenue data  
- Traffic acquisition sources  

---

## 📊 Dataset Overview

- **Dataset:** `bigquery-public-data.google_analytics_sample`  
- **Tables used:** `ga_sessions_2017*`  
- **Time period:** 2017  
- **Total sessions:** ~900,000+ rows  
- **Structure:** Date-partitioned tables (one table per day)
  
---

## 🔎 Project Scope & Analytical Approach

The analysis includes:

✔️ Monthly traffic and transaction trend analysis  
✔️ Revenue breakdown by traffic source (weekly & monthly)  
✔️ Behavioral comparison between purchasers and non-purchasers  
✔️ Conversion funnel exploration: product view → add to cart → purchase  

### 🛠 Technical Implementation

All transformations and aggregations were performed using:

- SQL aggregations and conditional logic  
- Common Table Expressions (CTEs)  
- Window Functions  
- Time-based grouping and date formatting in BigQuery  

---

## 📌 How to Access the Dataset

1. Log in to your Google Cloud Platform account and create a project.  
2. Open the **BigQuery Console**.  
3. Click **“Add Data” → “Search a project.”**  
4. Enter:

   ```
   bigquery-public-data
   ```

5. Navigate to the dataset:

   ```
   google_analytics_sample
   ```

6. Explore the tables starting with:

   ```
   ga_sessions_2017*
   ```
---

## ⚒️ Main Process


### 🔍 Calculate total visit, pageview, transaction and revenue for January, February and March 2017 (order by month).

This analysis measures **total visits, pageviews, transactions, and revenue** for **Jan–Mar 2017** to evaluate overall business performance. By organizing results **monthly**, it highlights **traffic growth, conversion efficiency, and revenue trends**, offering a concise snapshot of Q1 performance dynamics.

#### 🚀 **Queries**
```sql
SELECT 
    FORMAT_DATE ('%Y-%m', PARSE_DATE('%Y%m%d',date)) as month,
    SUM(totals.visits) AS visits,
    SUM(totals.pageviews) AS pageviews,
    SUM(totals.transactions) AS transactions
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_2017*`
WHERE _table_suffix BETWEEN '0101' AND '0331'
GROUP BY month
ORDER BY month ASC;
```
#### 💡 Queries result
<img width="900" alt="image" src="https://github.com/user-attachments/assets/a7fa1c30-3509-46bc-9ff3-29599c9c041c" />


## 🔍 Calculate bounce rate traffic source in July 2017.

The goal of this analysis is to **calculate the bounce rate by traffic source in July 2017** and compare performance across acquisition channels. The findings help identify **which sources drive stronger engagement** and uncover **optimization opportunities to improve user retention and overall website performance**.

#### 🚀 **Queries**
```sql
SELECT 
  trafficSource.source AS source,
  SUM(totals.visits) AS total_visit,
  SUM(totals.bounces) AS total_no_of_bounce,
  ROUND((SUM(totals.bounces) / SUM(totals.visits)) * 100, 3) AS bounce_rate
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201707*`
GROUP BY source
ORDER BY total_visit DESC;
```
#### 💡 Queries result
<img width="900" alt="image" src="https://github.com/user-attachments/assets/8175e1a4-d28d-445e-9030-01287039f4d9" />


## 🔍 Calculate revenue by traffic source by week, by month in June 2017

This analysis aims to **evaluate revenue performance by traffic source in June 2017**, with breakdowns at both **weekly and monthly levels**. By examining revenue trends over time, the study identifies **the most profitable acquisition channels**, enabling more targeted marketing decisions and revenue optimization strategies.

#### 🚀 **Queries**
```sql
WITH month_type AS (
  SELECT 
    FORMAT_DATE('%Y%m', PARSE_DATE('%Y%m%d', date)) AS time,
    trafficSource.source AS source,
    ROUND(SUM(products.productRevenue) / 1000000, 4) AS revenue,
    'Month' AS time_type
  FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201706*`, 
  UNNEST(hits) AS hits,
  UNNEST(hits.product) AS products
  WHERE products.productRevenue IS NOT NULL
  GROUP BY source, time
),
week_type AS (
  SELECT 
    FORMAT_DATE('%Y%W', PARSE_DATE('%Y%m%d', date)) AS time,
    trafficSource.source AS source,
    ROUND(SUM(products.productRevenue) / 1000000, 4) AS revenue,
    'Week' AS time_type
  FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201706*`, 
  UNNEST(hits) AS hits,
  UNNEST(hits.product) AS products
  WHERE products.productRevenue IS NOT NULL
  GROUP BY source, time
)
SELECT time_type, time, source, revenue
FROM month_type
UNION ALL
SELECT time_type, time, source, revenue
FROM week_type
ORDER BY revenue DESC;
```
#### 💡 Queries result
<img width="900" alt="image" src="https://github.com/user-attachments/assets/e09939b4-db3a-4b7c-b630-4acce89393be" />




## 🔎 Final Conclusion & Recommendations
