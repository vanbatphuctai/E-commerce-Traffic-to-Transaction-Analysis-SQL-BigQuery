# 📊 E-Commerce Website Analytics Project | SQL, BigQuery

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

## 📂 Dataset Description & Data Structure

### 📌 Data Source
The sample data is from **Google Analytics (Universal Analytics)**, publicly available in BigQuery.  
It contains session-level website activity data from the Google Merchandise Store e-commerce website.

### 📌 Data Size

- **Dataset:** `bigquery-public-data.google_analytics_sample`  
- **Tables used:** `ga_sessions_2017*`  
- **Time period:** 2017  
- **Total sessions:** ~900,000+ rows  
- **Structure:** One table per day (date-suffixed tables)

### 📌 How to Access the Data

1. Log in to your Google Cloud Platform account and create a new project.  
2. Open the **BigQuery Console** and select your project.  
3. Click on **“Add Data”** → **“Search a project.”**  
4. In the search bar, enter:

   ```
   bigquery-public-data
   ```

5. Locate and open the dataset:

   ```
   google_analytics_sample
   ```

6. Click on the tables starting with:

   ```
   ga_sessions_2017*
   ```

to explore their structure and data.

