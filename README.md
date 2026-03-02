# 📊 Retail Performance & Market Expansion For A Global Superstore | Power BI

**Author:** Van Bat Phuc Tai  
**Tools Used:** Power BI

---

## 📑 Table of Contents
- [📌 Background & Overview](#-background--overview)  
- [📂 Dataset Description & Data Structure](#-dataset-description--data-structure)  
- [🧠 Design Thinking Process](#-design-thinking-process)  
- [📊 Key Insights & Visualizations](#-key-insights--visualizations)  
- [🔎 Final Conclusion & Recommendation](#-final-conclusion--recommendation)  

---

## 📌 Background & Overview  

### 🎯 Objective  

Developed a **Power BI dashboard** using the Global Superstore dataset (Orders, People, Returns) to transform transactional data into **actionable business insights** for strategic decision-making.  

The project focuses on:  

- Evaluating overall **sales and profitability performance**  
- Identifying **high-potential markets for expansion**  
- Prioritizing **profitable and scalable product categories**  
- Supporting **ROI-driven decision-making**  

---

### 👤 Target Users  

- Data Analysts & Business Analysts  
- Sales & Marketing teams  
- Route-to-Market & Strategy teams  

---

### ❓ Key Business Questions  

- What is the current performance baseline?  
- Which markets show the strongest growth and ROI potential?  
- Which products should be prioritized for strategic investment?  

---

### 🎯 Project Outcome  

Revenue scaled steadily, but **margin expansion remained constrained**, indicating operational cost pressure.  

Several regions demonstrated **strong margin quality and growth momentum**, highlighting expansion opportunities.  

Technology led revenue performance, though **return-heavy SKUs impacted profitability**. High-margin categories outperformed, while weaker segments diluted overall results.  

This analysis supports alignment between **market expansion strategy, product portfolio optimization, and profitability improvement**.  

---

## 📂 Dataset Description & Data Structure  

### 📌 Data Source  

- Source: Kaggle  
- Format: CSV  
- ~51K transaction records (Orders table)  

### 📊 Data Structure  

### 1️⃣ Tables Used:

The dataset consists of three relational tables:  

🛒 Orders – Contains detailed transaction and customer information (51,290 records).

<details>
<summary><strong>Table 1: Orders</strong></summary>

| Column Name   | Data Type | Description |
|--------------|----------|------------|
| Order ID     | VARCHAR  | Unique identifier for each order. |
| Order Date   | DATE     | Date when the order was placed. |
| Ship Date    | DATE     | Date when the order was shipped. |
| Ship Mode    | VARCHAR  | Shipping method used for delivery. |
| Customer ID  | VARCHAR  | Unique identifier for each customer. |
| Customer Name| VARCHAR  | Full name of the customer. |
| Segment      | VARCHAR  | Customer segment (e.g., Consumer, Corporate). |
| City         | VARCHAR  | City where the order was placed. |
| State        | VARCHAR  | State where the order was placed. |
| Country      | VARCHAR  | Country where the order was placed. |
| Postal Code  | VARCHAR  | Postal code of the shipping address. |
| Market       | VARCHAR  | Market region (e.g., APAC, EMEA). |
| Region       | VARCHAR  | Geographical region of the order. |
| Product ID   | VARCHAR  | Unique identifier for each product. |
| Category     | VARCHAR  | Product category (e.g., Furniture, Office Supplies). |
| Sub-Category | VARCHAR  | Sub-category of the product. |
| Product Name | VARCHAR  | Name of the product ordered. |
| Sales        | DECIMAL  | Revenue generated from the order. |
| Quantity     | INT      | Number of items ordered. |
| Profit       | DECIMAL  | Profit earned from the order. |

</details>

🔄 Returns – Stores data on returned orders.

<details>
<summary><strong>Table 2: Returns</strong></summary>

| Column Name | Data Type | Description |
|-------------|----------|------------|
| Returned    | VARCHAR  | Indicates whether the order was returned (e.g., 'Yes' or 'No'). |
| Order ID    | VARCHAR  | Unique identifier for each order. |

</details>

👥 People – Holds information about sales representatives.

<details>
<summary><strong>Table 3: People</strong></summary>

> 👥 Holds information about sales representatives.

| Column Name | Data Type | Description |
|-------------|----------|------------|
| Person      | VARCHAR  | Name of the salesperson. |
| Region      | VARCHAR  | Geographic region where the salesperson operates. |

</details>

### 2️⃣ Data Relationships:

<img width="1380" height="800" alt="image" src="https://github.com/user-attachments/assets/c21503b1-f855-48f0-8833-2f67b4aa0257" />

### 🔗 Data Model Relationships

| From Table     | To Table        | Join Key        | Relationship Type |
|---------------|----------------|----------------|-------------------|
| Fact_Orders   | Dim_Product    | Product ID     | Many-to-One (*:1) |
| Fact_Orders   | Dim_Customer   | Customer ID    | Many-to-One (*:1) |
| Fact_Orders   | Dim_Date       | Order Date     | Many-to-One (*:1) |
| Fact_Orders   | Dim_Location   | Location ID    | Many-to-One (*:1) |
| Fact_Orders   | Dim_Market     | Market ID      | Many-to-One (*:1) |
| Fact_Orders   | Dim_Ship_Mode  | Ship Mode ID   | Many-to-One (*:1) |
| Fact_Orders   | Dim_Segment    | Segment ID     | Many-to-One (*:1) |
| Fact_Orders   | Dim_Returns    | Order ID       | Many-to-One (*:1) | 
| Dim_Product   | Dim_Subcategory| Subcategory ID | Many-to-One (*:1) |
| Dim_Subcategory | Dim_Category | Category ID    | Many-to-One (*:1) |
| Dim_Market    | Dim_People     | Region         | Many-to-One (*:1) |

## 🧠 Design Thinking Process

### 1️⃣ Empathize

### 🧠 STAGE 1: EMPATHIZE - 5W1H

| Who will view this Dashboard? | What problem does this dashboard solve? | When and where will stakeholders view this dashboard? | Why is this analysis needed? | How do stakeholders make decisions? |
|--------------------------------|------------------------------------------|--------------------------------------------------------|------------------------------|--------------------------------------|
| - Senior Manager <br> - Board of Directors (CEO, COO) <br> - Sales Director / Head of Sales <br> - Regional Sales Managers <br> - Marketing Manager <br> - Product Manager <br> - Finance Manager | - Overall business performance: revenue, profit, growth. <br> - Market performance: which regions are growing and which need improvement. <br> - Product performance: leading products and high-potential products. <br> - Customer trends: purchasing behavior, retention rate, order value. <br> - Risks & opportunities: declining markets, high return rates, rising costs. | **When:** <br> - Weekly / monthly performance tracking. <br> - Before investment or expansion decisions. <br> - After marketing campaigns or new product launches. <br><br> **Where:** <br> - Strategic meetings, periodic reports, executive presentations. <br> - On personal computers, tablets, or presentation screens. | - To support strategic market expansion decisions. <br> - To select key products for investment and development. <br> - To optimize product portfolio and sales channels. <br> - To present insights to executives or the board. | - Through interactive and easy-to-understand visuals (filters by market, product, time). <br> - Insight-focused, not overly technical. <br> - Using executive scorecards, trend charts, and regional/product comparisons. <br> - Exportable to PDF or presentation format. |
| **If only one key stakeholder is chosen, who would it be?** | **Summarize the problem in one sentence:** |  |  |  |
| Senior Sales Manager | Provide business data to support market expansion and strategic product selection. |  |  |  |

### 🧠 STAGE 1: EMPATHY MAP

| Thinking & Feeling <br><sub>What does the stakeholder think and feel?</sub> | Seeing <br><sub>What does the stakeholder see?</sub> | Saying & Doing <br><sub>What does the stakeholder say and do?</sub> |
|--------------------------------|--------------------------------|--------------------------------|
| - Concerned that wrong decisions may significantly impact the business. <br> - Wants data that is easy to understand and actionable. <br> - Feels pressure to make fast but accurate decisions. <br> - Lacks time to analyze excessive or complex information. <br> - Wants to control risks while still driving growth. | - Dense reports and multiple spreadsheets. <br> - Data scattered across departments. <br> - Increasing market competition. <br> - Market fluctuations. <br> - Rapid global economic changes. | - "I need an intuitive and easy-to-understand dashboard." <br> - "Can I trust this data?" <br> - Frequently requests quick reports and updates. <br> - Participates in strategy meetings and presents to executives. |
| **Pains** <br><sub>What are the biggest problems and challenges?</sub> | | **Gains** <br><sub>What are the opportunities and benefits?</sub> |
| - Lack of an intuitive tool to consolidate data. <br> - Difficult to compare markets and products clearly. <br> - Data updates are not timely. <br> - No early warning system for risks. <br> - Sometimes decisions rely on intuition instead of data. | | - Interactive and intuitive dashboard with real-time updates. <br> - Clear market and product insights. <br> - Data-driven strategic recommendations. <br> - Early risk detection capability. <br> - Greater confidence in data-driven decisions. |


### 2️⃣ Define Point of View

### 🚀 STAGE 2: STAKEHOLDERS JOURNEY

| Step | Description |
|------|------------|
| 🟢 **Step 1 – Business Assessment** | Starting from the company’s actual business situation, BOD and relevant managers want to understand business performance and trends over the years. If things look good, they plan to expand to new markets and choose suitable products to maximize revenue. |
| 🔵 **Step 2 – Data Insights & Dashboard** | To get the needed insights, stakeholders reach out to Data Analysts to build dashboards that visualize business performance clearly. From this, they can identify growth opportunities and potential products. |
| 🟣 **Step 3 – Strategy & Decision Making** | After receiving the dashboard, stakeholders have meetings to brainstorm ideas and finalize business strategies to move forward. |
| 🟠 **Step 4 – Execution & Monitoring** | New products are launched in new markets, and sell-in/sell-out data is regularly updated. |

### 🚀 STAGE 2: NORTHSTAR METRICS & DEFINE POV

#### NORTHSTAR METRICS

|                          | **NORTHSTAR 1** | **NORTHSTAR 2 (Optional)** |
|--------------------------|------------------|-----------------------------|
| **What VALUE do you want to measure?** | Revenue Growth Rate | Profit (Profit Margin) |
| **WHEN does the value indicate DELIVERY SUCCESS?** | - Increase order volume <br> - Increase number of customers <br> - Increase customer spending per order <br> - Improve sales team performance <br> - Expand market coverage <br> - Optimize conversion rate <br> - Increase Customer Lifetime Value (CLV) <br> - Implement threshold-based promotions <br> - Reduce return and complaint rates | - Achieve high profit margins <br> - Maintain effective cost control <br> - Set competitive yet profitable pricing <br> - Increase Average Order Value (AOV) <br> - Improve conversion rate <br> - Focus on high-margin products |
| **Northstar Metric Name** | Revenue Growth Rate | Profit Margin |
| **WHY do you choose this metric?** | Revenue Growth Rate reflects overall business performance, market penetration, and sustainable growth through customer acquisition, increased spending, and operational scalability. | Profit Margin reflects true operational efficiency by measuring value creation and cost control, ensuring sustainable net profitability across products and markets. |

#### DEFINE POINT OF VIEW

| Dimension | View 1 | View 2 | View 3 | View 4 | View 5 | View 6 |
|------------|----------|----------|----------|----------|----------|----------|
| Brainstorming Point of View | Overall (Timing) | Market | Product | Sales Agent | Customer | Marketing |

#### DEFINE KEY BUSINESS VIEWS

| View | Description | Why do stakeholders need this view? |
|------|------------|--------------------------------------|
| Overall | Understand the overall business situation: revenue, cost, profit. | - Determine whether the business is performing well or not. <br> - Set long-term strategic direction. |
| Market | Business performance by geographical market/region. | - Make accurate investment decisions for each market. <br> - Evaluate market suitability. <br> - Forecast risks and opportunities. |
| Product | Business performance by product line. | - Understand the performance of each product line. <br> - Optimize product portfolio. <br> - Decide whether to develop new products. <br> - Identify products to discontinue. |
| Sales Agent / Distributor | Performance by distributor and best-selling products within each assigned area. | - Identify which distributors generate the highest revenue. <br> - Evaluate channel management efficiency. <br> - Decide whether to expand or narrow the distribution network. |
| Customer | - Customer segmentation. <br> - Consumption behavior and trends. <br> - Customer acquisition cost. <br> - Customer lifetime value. <br> - Expansion potential and retention. | - Understand which customer segments create the most value. <br> - Optimize customer acquisition cost. <br> - Forecast growth and risks. |
| Marketing | Optimize campaigns to attract potential customers. | - Improve conversion rate. |

#### NORTHSTAR FORMULA: GROWTH FORMULA - Revenue (Revenue Growth Rate)

| Breakdown | Formula |
|------------|----------|
| Growth formula breakdown by View 1 | **Total Revenue Growth Rate** = (Total Revenue Current Period − Total Revenue Previous Period) / Total Revenue Previous Period |
| Growth formula breakdown by View 2 | **Total Revenue Growth Rate by Market** = (Revenue Current Period − Revenue Previous Period) / Revenue Previous Period |
| Growth formula breakdown by View 3 | **Total Revenue Growth Rate by Product Category** = (Revenue Current Period − Revenue Previous Period) / Revenue Previous Period |
| Growth formula breakdown by View 4 | **Total Revenue Growth Rate by Region** = (Revenue Current Period − Revenue Previous Period) / Revenue Previous Period |
| Growth formula breakdown by View 5 | **Total Revenue Growth Rate by Customer Segment** = (Revenue Current Period − Revenue Previous Period) / Revenue Previous Period |


### 3️⃣ Ideate

### STAGE 3: IDEATE – BRAINSTORMING

**Start with:**  
Based on the Growth Formula breakdown of each view, brainstorm related dimensions and insights aligned with the NorthStar Metric.

---

#### Overview Layer (Core Metrics)

| Metric 1 | Metric 2 | Metric 3 | Metric 4 |
|----------|----------|----------|----------|
| Total Revenue | Total Profit | Profit Margin | Revenue Growth Rate |

| Metric 5 | Metric 6 | Metric 7 | Metric 8 |
|----------|----------|----------|----------|
| Total Orders | AOV | Return Rate | |

---

#### Brainstorming Breakdown

| Idea Name | Layer 0 Dimension (Overall) | Layer 1 Dimension (1D Breakdown) | Layer 2 Dimension (2D Breakdown) | Anything Important Missed? |
|------------|----------------------------------|-----------------------------------|-----------------------------------|----------------------------|
| **View 1: Business Overview** | - Total Sales <br> - Total Profit <br> - Profit Margin <br> - Total Orders <br> - Return Rate <br> - Revenue Growth % | - Revenue trend by market/product (Year) <br> - Revenue by market (total sales, total profit, profit margin) <br> - Revenue by category (total sales, total profit, profit margin) <br> - Profit by market/category <br> - Return Rate by market/category <br> - Total Sales vs Sales LY <br> - Revenue YoY by Market/Product |  |  |
| **View 2: Market Analysis** | Top Market | - Total Sales vs Sales LY (%) by market <br> - YoY growth by market |  - Top Sales (Market) <br> - Total Sales, Sales LY, YoY % Growth <br> - Total Profit, Profit Margin, Total Orders, Return Rate (by Region, Country, City) |  |
| **View 3 – Product Analysis** | - Top Product | - Revenue Growth Rate by Product (%)  | - Top Selling Product by Total Sales <br> - Breakdown by Category/Sub-category <br> - Sales, Sales LY, YoY Growth, Total Profit, Profit Margin, Total Orders |   |
| **View 4 – Sales Agent** | 2 Key Metrics: Total Revenue & Total Profit | - Sales Agent Performance <br> - Revenue Growth Rate by Sales Agent |- Detailed breakdown by Region & Sales Agent <br> - 4 Scorecards: Revenue, Profit Margin, Profit, YoY Growth Rate |  |

### STAGE 3: IDEATE – STRUCTURE IDEA

#### Scorecard Metrics

| Metric 1 | Metric 2 | Metric 3 | Metric 4 | Metric 5 | Metric 6 |
|----------|----------|----------|----------|----------|----------|
| Profit | Total Revenue | Profit Margin | Revenue Growth | Profit Growth | AOV |

---

#### Structured Idea Breakdown

| Idea Name | Very Important Information | Important Information | Detailed Information | Anything Important Missed? |
|------------|----------------------------|------------------------|----------------------|
| **View 1 – Business Overview** | Scorecard: Total Sales, Total Profit, Profit Margin, Revenue Growth Rate (%), Total Orders, Return Rate | - Line & Column chart: Total Sales, Total Profit, Profit Margin by Year <br> - Line & Column chart: Total Sales, Total Profit, Profit Margin by Market <br> - Revenue Trend <br> - Bar chart: YoY by Market <br> - Column: Total Orders vs Return Rate by Year | - Top Salesperson by Market (based on Total Sales) <br> - Matrix table: Total Sales, Sales LY, YoY %, Total Profit, Profit Margin, Total Orders, Return Rate (by Market, Country, State, City) |  |
| **View 2 – Market Analysis** | Scorecard: Top Market (by revenue & volume) | - Column & Line: Total Sales vs Sales LY, YoY% (Market) <br> - Scatter Plot: Profit vs Sales by Market <br> - Tree Map: Revenue contribution by Market & Region (drill-down) | - Regional breakdown table (Market → Region → Country → City) including Sales, Sales LY, YoY%, Profit, Profit Margin, Orders |  |
| **View 3 – Product Analysis** | Scorecard: Top Subcategory (by revenue & volume) | - Column & Line: Total Sales vs Sales LY, YoY% (Product) <br> - Total Sales, Total Profit, Total Orders by Sub-Category | - Stacked Column: Top 10 selling products <br> - Matrix table by Category/Sub-category: Total Sales, Sales LY, YoY%, Total Profit, Profit Margin, Total Orders, Return Rate |  |
| **View 4 – Sales Agent** | 2 Scorecards: Total Revenue & Total Profit (with line trend) | - Sales Agent Performance (Scatter: Revenue, Profit Margin, Orders) <br> - Revenue Growth Rate by Sales Agent (parameter by Market & Category) | - Detailed Sales Area Map & Scorecards: Revenue, Profit Margin, Profit, YoY Growth Rate <br> - Sales Agent ranking table showing Revenue & Profit |  |

### 4️⃣ Prototype and Review
This phase is implemented and validated directly within the interactive dashboard.

---

## 📊 Key Insights & Visualizations

### 🔍 Dashboard Preview

### I. Business Overview

<img width="1300" alt="image" src="https://github.com/user-attachments/assets/e2a4dc9f-2b61-44d2-804d-329b18d7def9" />

### 📌 Key Findings:

#### 1. Total Revenue, Total Profit & Profit Margin  

Revenue reached **$12.64M (+51.5%)** and Profit hit **$1.47M (+52.3%)**, with Orders up **+51.7%**.  
→ Growth was strongly **volume-driven**, while margin slightly improved to **11.61%**.

#### 2. Business Performance Overview by Year  

Revenue & profit increased consistently (2011–2014).  
Profit margin peaked at **~11.95% (2013)** and remained stable.  
→ Indicates **sustainable scaling with controlled profitability**.

#### 3. Business Performance Overview by Market  

**APAC & EU** led total revenue.  
**Canada achieved the highest margin (~26.6%)** despite low revenue share.  
→ Large markets drive scale; **Canada shows strongest profitability potential**.

#### 4. Business Performance Overview by Category  

**Technology generated the highest revenue & strong margin (~14%)**.  
**Furniture recorded the lowest margin (~7%)**.  
→ Technology is the **core profit driver**.

#### 5. Trends in Order & Return Rate  

Orders grew steadily, while **Return Rate declined after 2012 (~4.6%)**.  
→ Growth occurred **without increasing operational risk**.

#### 6. Revenue Growth by Market/Category (YoY%)  

**EMEA (~59.8%) & Africa (~56.5%) showed the highest growth**.  
US grew slower (~47%) but remains a core base market.  
→ **Emerging markets are accelerating fastest**.

#### 7. Orders, Customers & Return Rate by Category  

**Office Supplies led order volume**.  
Return rates remained stable (~5–6%).  
→ Volume growth is **healthy and controlled**.


### II. Market Analysis

<img width="1300" alt="image" src="https://github.com/user-attachments/assets/552a57e8-c730-4812-aeb9-58f0556448d1" />

### 📌 Key Findings:

#### 1. Revenue & Profit Distribution

Total Revenue reached **$12.64M** and Total Profit **$1.47M**.
**APAC (\~$3.6M), EU (\~$2.9M), and US (\~$2.3M)** led revenue contribution.
→ **Canada recorded the highest profit margin (~26.6%)** despite minimal revenue, while **EMEA showed the weakest margin (~5.5%)**.

### 2. Revenue vs. Revenue LY (%YoY)

**APAC (\~$3.6M), EU (\~$2.9M), and US (\~$2.3M)** led total revenue.  
**EMEA (\~+59.8%)** and **Africa (\~+56.5%)** recorded the highest **YoY growth**, while **US (\~46.9%)** showed the lowest growth.  
→ **Emerging markets** are expanding faster, while **large markets** remain stable revenue pillars.

#### 3. Revenue, Profit Margin & Total Orders by Market

**APAC and EU combine high revenue with solid margins (~12–13%)**.  
**Canada achieved the highest profit margin (~26.6%)** despite very low revenue.  
EMEA had the weakest margin (~5.5%).  
→ Clear contrast between scale markets (APAC/EU) and high-efficiency niche market (Canada).

#### 4. Top 5 Salesperson Revenue Rankings

Top performer generated **~$2.82M**, significantly higher than others (~$0.88M–$1.60M).  
Revenue contribution is partially concentrated among top reps.  
→ Performance gap suggests opportunity for sales capability optimization.

#### 5. Sales Metrics Overview by Dimension (Market View)

APAC led in **Revenue (\~$3.6M), Profit (\~$436K), and Orders (5,437)**.  
EU and US followed as core contributors.  
Canada delivered **exceptional margin but lowest total orders (~201)**.  
→ Business performance varies clearly between volume-driven and margin-driven markets.

### III. Product Analysis

<img width="1300" alt="image" src="https://github.com/user-attachments/assets/a1975264-8e9c-4e8b-925d-0b22e2e59c86" />

### 📌 Key Findings:

#### 1. Revenue vs. Revenue LY & %YoY by Category  

**Technology** generated the highest revenue (**\~$4.8M**) and maintained strong **YoY growth (\~51–52%)**.  
**Office Supplies** showed the highest YoY growth (**\~52.6%**), while **Furniture** grew slower (**\~50.4%**).  
→ **Technology remains the core revenue engine**, with all categories sustaining **>50% growth**.

#### 2. Total Orders, Total Profit & Revenue by Sub-Category  

Sub-categories with **high orders and strong profit** cluster in the upper-right quadrant (e.g., **Copiers, Phones**).  
Some sub-categories show **high order volume but lower profit contribution**, indicating **margin pressure**.  
→ **Clear gap between volume-driven and profit-efficient sub-categories**.

#### 3. Impact of Shipping Mode on Return Volume  

**Standard Class** recorded the highest return volume (**677 returns**) but maintained a moderate **return rate (\~4.47%)**.  
**First Class** and **Same Day** showed slightly higher return rates (**\~5%**).  
→ **Faster shipping does not significantly reduce return risk**; **volume drives total returns**.


#### 4. Sales Metrics Overview (Revenue / Profit / Return Rate by Sub-Category & Region)  

**Binders, Furnishings, and Art** show strong revenue concentration in **US and EU markets**.  
Revenue distribution varies significantly across regions, with **US contributing the largest share** in most sub-categories.  
→ **Performance heavily depends on geographic demand concentration**.

#### 5. Top 10 Products by Revenue, Profit & Return Rate  

Top products (e.g., **Apple Smart Phone, Cisco Smart Phone, Motorola Smart Phone**) dominate revenue contribution (**\~$47K–$87K range**).  
**Technology products** account for the majority of top-ranking items.  
→ **Profit and revenue leadership is concentrated within Technology**, confirming **category dominance**.

### IV. Sales Agent 

<img width="1300" alt="image" src="https://github.com/user-attachments/assets/54549eaa-4abb-4fdb-8f17-786abc3dcd04" />

### 📌 Key Findings

#### 1. Revenue & Profit Distribution by Sales Agent
**Anna Andreadi (US-West / Multi-US)** generated the highest **Revenue (~$2.82M)** but operated at a moderate **Margin (~11%)**, reflecting a **high-volume, competitive pricing model**.  
**Chuck Magee (US-South)** showed similar **revenue-driven performance** with mid-range margins.  

In contrast, **Nicole Hansen (Canada)** achieved the highest **Margin (~26.6%)** despite a smaller revenue base, while **Shirley Daniels (North Asia)** maintained a strong **Margin (~19.5%)** with steady growth momentum.  

→ **US agents = Revenue engines** | **Canada & North Asia = Profit efficiency leaders**

#### 2. Revenue Growth by Category Across Sales Agents
All agents sustained strong **YoY Growth (~50%+)**.  

High-margin agents (**Nicole Hansen, Shirley Daniels**) align strongly with **Technology (Phones, Copiers)**.  
High-volume US agents maintain broader exposure, including **lower-margin Furniture**.  

→ **Product focus differentiates Profit Leaders from Revenue Leaders**

#### 3. Overall Sales Efficiency Gap
- **Total Revenue:** ~$12.64M  
- **Total Profit:** ~$1.47M  
- **Overall Margin:** ~11.61%  

Margin dispersion ranges from **single-digit levels (US territories)** to **~26% (Canada)**.  

→ **Growth is consistent, but pricing effectiveness and execution quality vary significantly**

#### 4. Regional Impact on Profitability
- **US Regions (West, East, Central, South)** → **High revenue concentration, moderate margin**  
- **Canada (Nicole Hansen)** → **Smaller scale, highest efficiency**  
- **North Asia (Shirley Daniels)** → **Balanced growth, strong margin stability**  

→ **Less price-sensitive regions demonstrate stronger margin sustainability**

#### 5. Product-Level Profit Drivers by Agent
- **Phones (~$1.71M Revenue)** and **Copiers (~$259K Profit)** dominate contribution  
- Technology-focused agents outperform in **Margin Performance**  
- **Furniture-heavy portfolios** dilute profitability impact  

→ **Technology concentration = Structural advantage for top profit agents**

## 🔎 Final Conclusion & Recommendation  

| Strategy | Insight | Recommendation |
|-----------|----------|----------------|
| 🚀 **1. Market & Sales Expansion Strategy** | - The US acts as the primary **volume engine** (high revenue, ~11% margin). <br>- Canada delivers the **highest profitability (~26.6%)** despite small scale. <br>- North Asia maintains strong margin stability (~19.5%). <br>- EMEA & Africa show the fastest growth (~56–60% YoY). | - Maintain the US as the revenue base while improving pricing discipline. <br>- Selectively expand in Canada & North Asia to maximize margin. <br>- Increase investment in EMEA & Africa to capture high-growth momentum. |
| 🛒 **2. Product & Sales Portfolio Optimization** | - Technology is the **core profit driver (~14% margin)**. <br>- Phones & Copiers contribute the largest share of profit. <br>- Furniture drags overall margin (~7%). <br>- Sales agents focused on Technology achieve higher margins. | - Increase Technology mix within the sales portfolio. <br>- Upsell high-margin products (Phones, Copiers). <br>- Tighten control or rationalize low-margin Furniture lines. |
| 👥 **3. Sales Capability & Performance Gap** | - Revenue is partially concentrated among top performers (~$2.82M vs ~$0.9–1.6M). <br>- Significant margin gap across regions (11%–26%). | - Replicate best practices from high-margin agents across teams. <br>- Strengthen pricing and product-mix coaching in volume-driven regions. <br>- Shift KPIs from revenue-only to margin-based performance. |
| ⚙️ **4. Operational Efficiency & Risk Control** | - Orders grew >50% while return rate remained stable (~5%). <br>- Standard Class drives the majority of return volume due to scale. | - Sustain quality control during expansion. <br>- Optimize logistics costs rather than changing shipping structure. |
