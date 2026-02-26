# E-commerce Traffic-to-Transaction Analysis | SQL, BigQuery
# 📊 E-Commerce Website Analytics Project (SQL – Google BigQuery)

**Author:** Van Bat Phuc Tai 
**Tools:** SQL, Google BigQuery  

---

## 📌 Background & Business Context

In the highly competitive e-commerce landscape, understanding user behavior and website performance is critical to driving revenue growth.

This project leverages SQL in Google BigQuery to analyze traffic trends, customer engagement, and purchasing behavior on an e-commerce website. The objective is to transform raw web analytics data into actionable business insights that support data-driven decision making.

---

## 🎯 Key Business Questions

- How are traffic, engagement, and transactions trending over time?
- Which traffic sources contribute most to revenue?
- How does user behavior differ between purchasers and non-purchasers?
- What does the customer journey look like from product view to completed purchase?

---

## 👥 Target Audience

This analysis is designed for:

- Data Analysts & Business Analysts  
- Digital Marketing Teams  
- E-commerce Managers  
- Business Intelligence & Strategy Teams  

---

## 📂 Dataset Description

### 📌 Data Source

This project uses publicly available sample data from Google Analytics, exported to Google BigQuery.

The dataset contains anonymized session-level data from the Google Merchandise Store, including:

- Website traffic metrics (sessions, pageviews, visits)
- User engagement behavior
- Transaction and revenue information
- Traffic acquisition channels

---

## 📊 Dataset Overview

- **Dataset name:** `bigquery-public-data.google_analytics_sample.ga_sessions_*`
- **Time period:** 2017
- **Total sessions:** ~900,000+ rows
- **Structure:** Partitioned by date (one table per day)

This is a sample dataset designed for analytics practice and demonstration purposes.

---

## 🔎 Project Scope & Analytical Approach

The analysis includes:

✔️ Monthly traffic and transaction trend analysis  
✔️ Revenue breakdown by traffic source (weekly & monthly view)  
✔️ Behavioral comparison between purchasers and non-purchasers  
✔️ Funnel exploration: product views → add to cart → purchase  

All transformations and aggregations were performed using:

- SQL Window Functions  
- Common Table Expressions (CTEs)  
- Time-based grouping in BigQuery  

---

## 📌 How to Access the Dataset

1. Log in to your Google Cloud Platform account.
2. Open the BigQuery Console.
3. Click **“Add Data” → “Search a project.”**
4. In the search bar, enter the project ID: bigquery-public-data.google_analytics_sample.ga_sessions and press Enter.
5. Click on the ga_sessions_ table to explore its structure and data.

