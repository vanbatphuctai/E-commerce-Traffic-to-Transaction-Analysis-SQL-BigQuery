# 📊 E-Commerce Website Performance & Customer Behavior Analysis | SQL & Google BigQuery

**Author:** Van Bat Phuc Tai  
**Tools:** SQL, Google BigQuery  

---

## 📌 Background & Business Context

In today’s data-driven e-commerce environment, understanding how users interact with a website is essential for optimizing conversion rates and driving sustainable revenue growth.

This project analyzes website performance and customer purchasing behavior using SQL in Google BigQuery. By transforming raw session-level analytics data into structured insights, the project aims to support data-informed decision-making across marketing, product, and business strategy functions.

---

## 🎯 Key Business Questions

- How do traffic, engagement, and transaction metrics evolve over time?  
- Which acquisition channels contribute most effectively to revenue?  
- What behavioral differences exist between purchasers and non-purchasers?  
- How does the user journey progress from product view to completed transaction?  

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

> Note: This is a public sample dataset provided for analytics training and demonstration purposes.

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
