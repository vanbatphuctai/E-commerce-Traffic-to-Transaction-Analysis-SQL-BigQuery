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


## 🔍 Calculate average number of pageviews by purchaser type (purchasers vs non-purchasers) in June, July 2017.

Calculate the **average number of pageviews** segmented by **purchaser type (purchasers vs. non-purchasers)** for **June and July 2017** to evaluate **engagement differences** and identify variations in **browsing behavior** between **buying and non-buying users**.

#### 🚀 **Queries**
```sql
WITH 
purchaser_data AS (
  SELECT
      FORMAT_DATE("%Y%m", PARSE_DATE("%Y%m%d", date)) AS month,
      SUM(totals.pageviews) / COUNT(DISTINCT fullvisitorid) AS avg_pageviews_purchase
  FROM `bigquery-public-data.google_analytics_sample.ga_sessions_2017*`,
    UNNEST(hits) hits,
    UNNEST(product) product
  WHERE _table_suffix BETWEEN '0601' AND '0731'
    AND totals.transactions >= 1
    AND product.productRevenue IS NOT NULL
  GROUP BY month
),
non_purchaser_data AS (
  SELECT
      FORMAT_DATE("%Y%m", PARSE_DATE("%Y%m%d", date)) AS month,
      SUM(totals.pageviews) / COUNT(DISTINCT fullvisitorid) AS avg_pageviews_non_purchase
  FROM `bigquery-public-data.google_analytics_sample.ga_sessions_2017*`,
    UNNEST(hits) hits,
    UNNEST(product) product
  WHERE _table_suffix BETWEEN '0601' AND '0731'
    AND totals.transactions IS NULL
    AND product.productRevenue IS NULL
  GROUP BY month
)
SELECT
    pd.*,
    avg_pageviews_non_purchase
FROM purchaser_data pd
FULL JOIN non_purchaser_data USING(month)
ORDER BY pd.month;
```
#### 💡 Queries result
<img width="900" alt="image" src="https://github.com/user-attachments/assets/ff5fb846-de6e-4fdc-b57f-f1441c6b6a00" />


## 🔍 Calculate average number of transactions per user that made a purchase in July 2017

**Calculate the average number of transactions per purchasing user in July 2017** to examine buying frequency and repeat purchase behavior. This analysis provides a clearer view of **customer loyalty** and highlights opportunities to improve **retention strategies**.

#### 🚀 **Queries**
```sql
SELECT
    FORMAT_DATE("%Y%m", PARSE_DATE("%Y%m%d", date)) AS month,
    SUM(totals.transactions) / COUNT(DISTINCT fullvisitorid) AS Avg_total_transactions_per_user
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201707*`,
    UNNEST(hits) hits,
    UNNEST(product) product
WHERE totals.transactions >= 1
AND product.productRevenue IS NOT NULL
GROUP BY month;
```
#### 💡 Queries result
<img width="900" alt="image" src="https://github.com/user-attachments/assets/2cc69893-fad1-4a92-aea2-a3128d764551" />


## 🔍 Calculate average amount of money spent per session. Only include purchaser data in July 2017

**Determine the average revenue per session among purchasers in July 2017**, focusing specifically on completed purchases. This evaluation reveals **customer spending behavior**, supports assessment of **marketing effectiveness**, and helps identify **high-value customer segments**.

#### 🚀 **Queries**
```sql
SELECT
    FORMAT_DATE("%Y%m", PARSE_DATE("%Y%m%d", date)) AS month,
    ((SUM(product.productRevenue)/SUM(totals.visits))/POWER(10,6)) AS avg_revenue_by_user_per_visit
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201707*`,
    UNNEST(hits) hits,
    UNNEST(product) product
WHERE product.productRevenue IS NOT NULL
AND totals.transactions >= 1
GROUP BY month;
```
#### 💡 Queries result
<img width="900" alt="image" src="https://github.com/user-attachments/assets/50942eb2-6a50-4c83-9053-1d3064814059" />


## 🔍 Other products purchased by customers who purchased product "YouTube Men's Vintage Henley" in July 2017. Output should show product name and the quantity was ordered.

**Identify additional products purchased by customers who bought "YouTube Men's Vintage Henley" in July 2017.**  
The output should include the **product name** and **quantity ordered**, providing insights into **cross-selling opportunities** and **customer preferences**.

#### 🚀 **Queries**
```sql
WITH filtered_users AS (
    SELECT
        fullVisitorId
    FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201707*`,
         UNNEST(hits) AS hits,
         UNNEST(hits.product) AS product
    WHERE product.v2ProductName = "YouTube Men's Vintage Henley"
      AND product.productRevenue IS NOT NULL
    GROUP BY fullVisitorId
)

SELECT
    product.v2ProductName AS other_purchased_product,
    SUM(product.productQuantity) AS total_quantity_purchased
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201707*`,
     UNNEST(hits) AS hits,
     UNNEST(hits.product) AS product
WHERE fullVisitorId IN (SELECT fullVisitorId FROM filtered_users)
  AND product.productRevenue IS NOT NULL
  AND totals.transactions >= 1
  AND product.v2ProductName <> "YouTube Men's Vintage Henley"
GROUP BY other_purchased_product
ORDER BY total_quantity_purchased DESC;
```
#### 💡 Queries result
<img width="900" alt="image" src="https://github.com/user-attachments/assets/a6e6054d-a75b-49b4-ab26-b55440ab06f5" />


## 🔍 Calculate cohort map from product view to addtocart to purchase in Jan, Feb and March 2017.

**Build a cohort map tracking the customer journey from product view → add-to-cart → purchase** for January, February, and March 2017. This analysis evaluates **conversion rates at each funnel stage**, identifies **drop-off points**, and uncovers opportunities to optimize the **sales process**.

#### 🚀 **Queries**
```sql
WITH product_view AS (
    -- Step 1: Count product detail views
    SELECT
        FORMAT_DATE("%Y%m", PARSE_DATE("%Y%m%d", date)) AS month,
        COUNT(product.productSKU) AS num_product_views
    FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*`,
         UNNEST(hits) AS hits,
         UNNEST(hits.product) AS product
    WHERE _TABLE_SUFFIX BETWEEN '20170101' AND '20170331'
      AND hits.eCommerceAction.action_type = '2'  -- Product view
    GROUP BY month
),

add_to_cart AS (
    -- Step 2: Count add-to-cart actions
    SELECT
        FORMAT_DATE("%Y%m", PARSE_DATE("%Y%m%d", date)) AS month,
        COUNT(product.productSKU) AS num_add_to_cart
    FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*`,
         UNNEST(hits) AS hits,
         UNNEST(hits.product) AS product
    WHERE _TABLE_SUFFIX BETWEEN '20170101' AND '20170331'
      AND hits.eCommerceAction.action_type = '3'  -- Add to cart
    GROUP BY month
),

purchase AS (
    -- Step 3: Count completed purchases
    SELECT
        FORMAT_DATE("%Y%m", PARSE_DATE("%Y%m%d", date)) AS month,
        COUNT(product.productSKU) AS num_purchase
    FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*`,
         UNNEST(hits) AS hits,
         UNNEST(hits.product) AS product
    WHERE _TABLE_SUFFIX BETWEEN '20170101' AND '20170331'
      AND hits.eCommerceAction.action_type = '6'  -- Purchase
      AND product.productRevenue IS NOT NULL
    GROUP BY month
)

-- Step 4: Combine funnel stages & calculate conversion rates
SELECT
    pv.month,
    pv.num_product_views,
    a.num_add_to_cart,
    p.num_purchase,

    ROUND(a.num_add_to_cart * 100 / pv.num_product_views, 2) AS add_to_cart_rate_pct,
    ROUND(p.num_purchase * 100 / pv.num_product_views, 2) AS purchase_rate_pct

FROM product_view pv
LEFT JOIN add_to_cart a 
       ON pv.month = a.month
LEFT JOIN purchase p 
       ON pv.month = p.month
ORDER BY pv.month;

```
#### 💡 Queries result
<img width="900" alt="image" src="https://github.com/user-attachments/assets/a245fc1f-0d2e-4c1e-90db-b88d04284ce2" />


## 🔎 Final Conclusion & Recommendations

## 📌 Key Insights

- **Traffic Trend:** Website traffic remained stable throughout Q1 2017, with March recording the highest volume (69,931 visits).
- **Revenue by Source:** Direct traffic was the leading revenue contributor in June 2017, followed by strong performance from Google and Mail channels.
- **Bounce Rate:** Referral sources such as phandroid.com showed a high bounce rate (77.78%), indicating low landing page engagement.
- **Purchasing Behavior:** Customers who purchased *"YouTube Men's Vintage Henley"* also bought related apparel items, highlighting cross-selling potential.


## 📌 Recommendations

- **Optimize High-Bounce Landing Pages:** Improve content relevance, user experience, and page load speed for underperforming referral traffic.
- **Scale High-Performing Channels:** Increase investment in Direct and Google acquisition channels to maximize revenue growth.
- **Improve Conversion Rate:** Simplify the checkout process and apply targeted promotions to convert high-intent users.
- **Leverage Cross-Selling:** Implement personalized product recommendations to increase average order value (AOV) and customer lifetime value (CLV).
