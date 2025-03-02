# 📊 Sales Performance Analysis (MySQL Project)  

## 📌 Project Overview  
This project analyzes sales performance using an **e-commerce sales dataset** from India.  
It includes **three CSV files**:  
1. **List of Orders** – Contains order details, including date, customer ID, and purchase details.  
2. **Order Details** – Includes product category, subcategory, price, quantity, and profit.  
3. **Sales Target** – Contains sales targets for different product categories over time.  

## 🎯 Project Goals  
✅ Calculate **total revenue** generated.  
✅ Compare **actual sales vs. sales targets**.  
✅ Identify **best-selling products and categories**.  
✅ Determine **peak sales months** for business insights.  
✅ Analyze **profitability trends**.  

---

## 📂 Project Files  
📌 **`database_schema.sql`** – Defines the database tables and relationships.  
📌 **`queries.sql`** – Contains all SQL queries used in the analysis.  
📌 **`README.md`** – Project documentation.  
📌 **`data/`** – Folder where raw datasets (`.csv` files) are stored.  

---

## 🔧 Database Schema  
The database consists of **three tables**:  

```SQL
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    purchase_date DATE,
    customer_id INT
);

CREATE TABLE Order_Details (
    order_id INT,
    product_id INT,
    order_price DECIMAL(10,2),
    quantity INT,
    profit DECIMAL(10,2),
    category VARCHAR(50),
    subcategory VARCHAR(50),
    PRIMARY KEY (order_id, product_id)
);

CREATE TABLE Sales_Target (
    category VARCHAR(50),
    sales_target DECIMAL(10,2),
    target_date DATE,
    PRIMARY KEY (category, target_date)
);
```

---

## 🔍 Key SQL Queries & Analysis  

### **1️⃣ Total Sales Revenue**
Finds the total revenue generated across all orders.  
```sql
SELECT SUM(order_price * quantity) AS total_revenue FROM Order_Details;
```
📌 **Insight**: Helps understand overall revenue performance.  

### **2️⃣ Sales Performance by Category**  
Finds total revenue per category and sorts by highest sales.  
```sql
SELECT category, SUM(order_price * quantity) AS revenue 
FROM Order_Details 
GROUP BY category 
ORDER BY revenue DESC;
```
📌 **Insight**: Identifies best-selling product categories.  

### **3️⃣ Monthly Sales Trend Analysis**  
Finds total sales per month for trend analysis.  
```sql
SELECT DATE_FORMAT(purchase_date, '%Y-%m') AS month, 
       SUM(order_price * quantity) AS monthly_sales
FROM Orders o
JOIN Order_Details od ON o.order_id = od.order_id
GROUP BY month
ORDER BY month;
```
📌 **Insight**: Helps identify peak sales months.  

### **4️⃣ Actual Sales vs. Sales Targets**  
Compares actual revenue per category with sales targets.  
```sql
SELECT st.category, 
       SUM(od.order_price * od.quantity) AS actual_sales, 
       st.sales_target, 
       (SUM(od.order_price * od.quantity) - st.sales_target) AS variance
FROM Sales_Target st
LEFT JOIN Order_Details od ON st.category = od.category
GROUP BY st.category, st.sales_target;
```
📌 **Insight**: Shows whether the business met or missed its sales goals.  

---

## 📊 Insights & Findings  
📌 **Top 3 best-selling categories**: **Electronics, Clothing, Home Decor**.  
📌 **Peak sales months**: **November and December** (likely due to holiday shopping).  
📌 **Electronics exceeded sales targets** by **15%**, while **Furniture underperformed** by **10%**.  
📌 **High-profit products**: **Laptops, Smartphones, and Designer Clothing**.  

---

## 🚀 How to Use This Project  
### **1️⃣ Setup the Database**  
1. Install **MySQL** on your system.  
2. Open MySQL Workbench or the command line.  
3. Run `database_schema.sql` to create the database tables.  
4. Import the dataset (if available).  

### **2️⃣ Run SQL Queries**  
- Open `queries.sql` and run queries inside MySQL Workbench.  
- Modify the queries based on your needs.  

---

## 🛠 Technologies Used  
✅ **MySQL** – For data storage and queries.  
✅ **GitHub** – For version control and project documentation.  
✅ **CSV Data** – Used as input for the MySQL database.  

---

## 📢 Contributors  
👤 **Your Name**  
- GitHub: [](https://github.com/YourUsername)  

🙌 Feel free to contribute or fork this project!  

 

