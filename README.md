# E-Commerce COD vs. Prepaid & Return (RTO) Loss Analysis (FY 2025–26)

**Author:** Akshat Rastogi  
**Live Dashboard:** [akshatrastogi-analyst.github.io/ecommerce-cod-rto-analysis](https://akshatrastogi-analyst.github.io/ecommerce-cod-rto-analysis)  
**SQL Script:** [queries.sql](https://github.com/AkshatRastogi-Analyst/ecommerce-cod-rto-analysis/blob/main/queries.sql)  
**Tech Stack:** PostgreSQL, MS Excel, HTML5 / CSS3 / Vanilla JS  

---

## 1. Executive Summary
In Indian e-commerce, **Cash-on-Delivery (COD)** accounts for **56.55%** of total customer orders (82,000 out of 1,45,000 orders) but drives a high rate of doorstep refusals (**RTO — Return to Origin**). Every returned parcel costs **Rs 110 in two-way courier charges** (Rs 55 forward shipping + Rs 55 reverse shipping), directly reducing net profit.

This project analyzes **1,45,000 e-commerce orders (Rs 6.38 Crore Gross Order Value)** across **6 Indian states** and **5 product categories** during **FY 2025–26** to quantify courier losses and build profit recovery solutions.

---

## 2. Key Findings (100% Reconciled Across SQL, CSV & Dashboard)
* **COD vs. Prepaid Return Gap:** Cash-on-Delivery orders have a **25.00% return rate** (20,500 returned out of 82,000), compared to only **7.14%** on Prepaid UPI/Card orders (4,500 returned out of 63,000).
* **Courier Loss Impact:** Undelivered returns (25,000 parcels) wasted **Rs 27.50 Lakhs** in two-way shipping charges, leaving **Rs 51.70 Lakhs** in net profit on **Rs 5.28 Crore** in delivered sales.
* **High-Risk States:** High-COD states such as **Bihar (26.92% overall return rate)** and **Uttar Pradesh (20.00% overall return rate)** recorded the highest doorstep refusal rates.
* **Category Performance:** *Beauty & Personal Care* generated the highest net profit (**Rs 14.74 Lakhs**, lowest return rate at **8.62%**), while *Fashion Apparel* suffered the highest return rate (**22.99%**) and highest courier loss (**Rs 11.00 Lakhs**).

---

## 3. Business Recommendations
1. **Give Rs 25 Instant UPI Checkout Discount:** Shifting 20% of COD buyers to UPI prevents Rs 110 in two-way courier losses per refused parcel and adds **+Rs 5.65 Lakhs** in annual net profit.
2. **Automated WhatsApp Order Confirmation:** Require one-click WhatsApp confirmation before shipping COD parcels in high-risk pin codes (Bihar & UP), cutting fake dispatches by **25%**.
3. **Block COD for Repeat Rejectors:** Automatically disable COD for customer accounts with 2 or more past doorstep refusals.

---

## 4. Repository Files
* `index.html` — Interactive Operations Dashboard with live State, Payment Mode, and Category filters, Order-to-Cash Pipeline, Business Analysis Section, Unit Economics Lab, and Profit Simulator.
* `ecommerce_cod_rto_data.csv` — Complete 720-row dataset across 12 months, 6 states, 5 categories, and 2 payment modes (sums to exactly 1,45,000 orders).
* `queries.sql` — 5 PostgreSQL queries used for the analysis.
