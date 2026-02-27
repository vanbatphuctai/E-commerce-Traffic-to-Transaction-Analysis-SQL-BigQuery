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
- 
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

---

## 🔍 Calculate total visit, pageview, transaction and revenue for January, February and March 2017 (order by month).

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
   
