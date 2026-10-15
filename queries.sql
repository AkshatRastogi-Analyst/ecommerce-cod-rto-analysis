-- ============================================================================
-- PROJECT: E-Commerce COD vs. Prepaid & Return (RTO) Loss Analysis (FY 2025-26)
-- AUTHOR: Akshat Rastogi
-- DATABASE: PostgreSQL
-- ============================================================================

CREATE TABLE ecommerce_rto_orders (
    record_id INT PRIMARY KEY,
    month_year VARCHAR(10),
    state VARCHAR(50),
    category VARCHAR(50),
    payment_mode VARCHAR(20),
    total_orders INT,
    delivered_orders INT,
    rto_returned_orders INT,
    gross_order_value_inr NUMERIC(12,2),
    delivered_revenue_inr NUMERIC(12,2),
    courier_rto_loss_inr NUMERIC(12,2),
    net_profit_inr NUMERIC(12,2)
);

-- 1. Compare Cash-on-Delivery (COD) vs. Prepaid Return Rates
SELECT 
    payment_mode,
    SUM(total_orders) AS total_orders,
    SUM(delivered_orders) AS delivered_orders,
    SUM(rto_returned_orders) AS returned_orders,
    ROUND((SUM(rto_returned_orders) * 100.0) / SUM(total_orders), 2) AS rto_return_rate_pct,
    ROUND(SUM(gross_order_value_inr) / 100000, 2) AS gross_sales_lakhs,
    ROUND(SUM(delivered_revenue_inr) / 100000, 2) AS delivered_sales_lakhs,
    ROUND(SUM(courier_rto_loss_inr) / 100000, 2) AS courier_loss_lakhs,
    ROUND(SUM(net_profit_inr) / 100000, 2) AS net_profit_lakhs
FROM ecommerce_rto_orders
GROUP BY payment_mode
ORDER BY rto_return_rate_pct DESC;

-- 2. State-Wise Return Rate and Courier Loss Ranking
SELECT 
    state,
    SUM(total_orders) AS total_orders,
    SUM(delivered_orders) AS delivered_orders,
    SUM(rto_returned_orders) AS returned_orders,
    ROUND((SUM(rto_returned_orders) * 100.0) / SUM(total_orders), 2) AS rto_return_rate_pct,
    ROUND(SUM(delivered_revenue_inr) / 100000, 2) AS delivered_sales_lakhs,
    ROUND(SUM(courier_rto_loss_inr) / 100000, 2) AS courier_loss_lakhs,
    ROUND(SUM(net_profit_inr) / 100000, 2) AS net_profit_lakhs
FROM ecommerce_rto_orders
GROUP BY state
ORDER BY courier_loss_lakhs DESC, rto_return_rate_pct DESC;

-- 3. Product Category Profitability and Courier Loss Analysis
SELECT 
    category,
    SUM(total_orders) AS total_orders,
    SUM(delivered_orders) AS delivered_orders,
    SUM(rto_returned_orders) AS returned_orders,
    ROUND((SUM(rto_returned_orders) * 100.0) / SUM(total_orders), 2) AS rto_return_rate_pct,
    ROUND(SUM(gross_order_value_inr) / 100000, 2) AS gross_sales_lakhs,
    ROUND(SUM(courier_rto_loss_inr) / 100000, 2) AS courier_loss_lakhs,
    ROUND(SUM(net_profit_inr) / 100000, 2) AS net_profit_lakhs
FROM ecommerce_rto_orders
GROUP BY category
ORDER BY net_profit_lakhs DESC;

-- 4. Monthly Fulfillment & Seasonal Return Trend (Apr 2025 – Mar 2026)
SELECT 
    month_year,
    SUM(total_orders) AS monthly_orders,
    ROUND(SUM(delivered_revenue_inr) / 100000, 2) AS delivered_sales_lakhs,
    ROUND(SUM(courier_rto_loss_inr) / 100000, 2) AS courier_loss_lakhs,
    ROUND(SUM(net_profit_inr) / 100000, 2) AS net_profit_lakhs
FROM ecommerce_rto_orders
GROUP BY month_year
ORDER BY month_year ASC;

-- 5. Automated Regional Risk Classification Using CASE WHEN
SELECT 
    state,
    ROUND((SUM(rto_returned_orders) * 100.0) / SUM(total_orders), 2) AS rto_return_rate_pct,
    CASE 
        WHEN (SUM(rto_returned_orders) * 100.0) / SUM(total_orders) >= 20.0 
            THEN 'High Risk - Mandatory WhatsApp Order Confirmation'
        WHEN (SUM(rto_returned_orders) * 100.0) / SUM(total_orders) >= 15.0 
            THEN 'Moderate Risk - Promote Rs 25 UPI Discount at Checkout'
        ELSE 'Low Risk - Standard Express Fulfillment'
    END AS operational_policy
FROM ecommerce_rto_orders
GROUP BY state
ORDER BY rto_return_rate_pct DESC;
