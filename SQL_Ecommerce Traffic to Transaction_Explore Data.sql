-- Query 1
SELECT 
    FORMAT_DATE('%Y-%m', PARSE_DATE('%Y%m%d', date)) AS month,
    SUM(totals.visits) AS visits,
    SUM(totals.pageviews) AS pageviews,
    SUM(totals.transactions) AS transactions
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_2017*`
WHERE _table_suffix BETWEEN '0101' AND '0331'
GROUP BY month
ORDER BY month ASC;


-- Query 2
SELECT 
    trafficSource.source AS source,
    SUM(totals.visits) AS total_visit,
    SUM(totals.bounces) AS total_no_of_bounce,
    ROUND((SUM(totals.bounces) / SUM(totals.visits)) * 100, 3) AS bounce_rate
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201707*`
GROUP BY source
ORDER BY total_visit DESC;


-- Query 3
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


-- Query 4
WITH purchaser_data AS (
  SELECT
      FORMAT_DATE('%Y%m', PARSE_DATE('%Y%m%d', date)) AS month,
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
      FORMAT_DATE('%Y%m', PARSE_DATE('%Y%m%d', date)) AS month,
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


-- Query 5
SELECT
    FORMAT_DATE('%Y%m', PARSE_DATE('%Y%m%d', date)) AS month,
    SUM(totals.transactions) / COUNT(DISTINCT fullvisitorid) AS Avg_total_transactions_per_user
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201707*`,
     UNNEST(hits) hits,
     UNNEST(product) product
WHERE totals.transactions >= 1
  AND product.productRevenue IS NOT NULL
GROUP BY month;


-- Query 6
SELECT
    FORMAT_DATE('%Y%m', PARSE_DATE('%Y%m%d', date)) AS month,
    ((SUM(product.productRevenue)/SUM(totals.visits))/POWER(10,6)) AS avg_revenue_by_user_per_visit
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201707*`,
     UNNEST(hits) hits,
     UNNEST(product) product
WHERE product.productRevenue IS NOT NULL
  AND totals.transactions >= 1
GROUP BY month;


-- Query 7
WITH filtered_users AS (
    SELECT fullVisitorId
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


-- Query 8
WITH product_view AS (
    SELECT
        FORMAT_DATE('%Y%m', PARSE_DATE('%Y%m%d', date)) AS month,
        COUNT(product.productSKU) AS num_product_views
    FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*`,
         UNNEST(hits) AS hits,
         UNNEST(hits.product) AS product
    WHERE _TABLE_SUFFIX BETWEEN '20170101' AND '20170331'
      AND hits.eCommerceAction.action_type = '2'
    GROUP BY month
),
add_to_cart AS (
    SELECT
        FORMAT_DATE('%Y%m', PARSE_DATE('%Y%m%d', date)) AS month,
        COUNT(product.productSKU) AS num_add_to_cart
    FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*`,
         UNNEST(hits) AS hits,
         UNNEST(hits.product) AS product
    WHERE _TABLE_SUFFIX BETWEEN '20170101' AND '20170331'
      AND hits.eCommerceAction.action_type = '3'
    GROUP BY month
),
purchase AS (
    SELECT
        FORMAT_DATE('%Y%m', PARSE_DATE('%Y%m%d', date)) AS month,
        COUNT(product.productSKU) AS num_purchase
    FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*`,
         UNNEST(hits) AS hits,
         UNNEST(hits.product) AS product
    WHERE _TABLE_SUFFIX BETWEEN '20170101' AND '20170331'
      AND hits.eCommerceAction.action_type = '6'
      AND product.productRevenue IS NOT NULL
    GROUP BY month
)
SELECT
    pv.month,
    pv.num_product_views,
    a.num_add_to_cart,
    p.num_purchase,
    ROUND(a.num_add_to_cart * 100 / pv.num_product_views, 2) AS add_to_cart_rate_pct,
    ROUND(p.num_purchase * 100 / pv.num_product_views, 2) AS purchase_rate_pct
FROM product_view pv
LEFT JOIN add_to_cart a ON pv.month = a.month
LEFT JOIN purchase p ON pv.month = p.month
ORDER BY pv.month;
