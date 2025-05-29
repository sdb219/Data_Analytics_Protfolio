# Blinkit Sales Performance Dashboard – Power BI Analysis of KPIs & Business Insights

## 📌 Business Requirement
To conduct a comprehensive analysis of Blinkit's sales performance, customer satisfaction, and inventory distribution to identify key insights and opportunities for optimization using various KPIs and visualizations in Power BI.

## 🔑 KPI Requirements
1. **Total Sales**: The overall revenue generated from all items sold.
2. **Average Sales**: The average revenue per sale.
3. **Number of Items**: Total count of different items sold.
4. **Average Rating**: Average customer rating for items sold.

## 📊 Chart Requirements
1. **Total Sales by Fat Content**
   - Objective: Analyze the impact of fat content on total sales.
   - Chart Type: Donut Chart

2. **Total Sales by Item Type**
   - Objective: Identify performance of item types.
   - Chart Type: Bar Chart

3. **Fat Content by Outlet for Total Sales**
   - Objective: Compare sales by outlet segment.
   - Chart Type: Stacked Column Chart

4. **Total Sales by Outlet Establishment**
   - Objective: Evaluate how outlet age/type affects sales.
   - Chart Type: Line Chart

## 🧠 Insights
- Regular fat items have higher sales than low-fat ones.
- Tier 3 outlets outperform others in total sales.
- Fruits, snacks, and household items dominate sales volume.
- Outlet establishment year impacts revenue trends significantly.

## 🔢 DAX Formulas
```dax
Total Sales = SUM(Sales[Revenue])
Average Sales = AVERAGE(Sales[Revenue])
Number of Items = COUNTROWS(Items)
Average Rating = AVERAGE(Ratings[Customer_Rating])

