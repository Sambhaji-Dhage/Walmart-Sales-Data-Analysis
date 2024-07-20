# Walmart Sales Data Analysis


## Purposes Of The Project

This project aims to analyze Walmart sales data to identify top-performing branches and products, discern sales trends, and understand customer behavior. The goal is to optimize sales strategies by evaluating current approaches and making data-driven recommendations for improvement, ultimately enhancing overall sales performance.

## About Data

This dataset contains sales transactions from a three different branches of Walmart, respectively located in Mandalay, Yangon and Naypyitaw. The data contains 17 columns and 1000 rows:

| Column                  | Description                             | Data Type      |
| :---------------------- | :-------------------------------------- | :------------- |
| invoice_id              | Invoice of the sales made               | VARCHAR(30)    |
| branch                  | Branch at which sales were made         | VARCHAR(5)     |
| city                    | The location of the branch              | VARCHAR(30)    |
| customer_type           | The type of the customer                | VARCHAR(30)    |
| gender                  | Gender of the customer making purchase  | VARCHAR(30)    |
| product_line            | Product line of the product solf        | VARCHAR(100)   |
| unit_price              | The price of each product               | DECIMAL(10, 2) |
| quantity                | The amount of the product sold          | INT            |
| tax                     | The amount of tax on the purchase       | FLOAT(6, 4)    |
| total                   | The total cost of the purchase          | DECIMAL(12, 4) |
| date                    | The date on which the purchase was made | DATE           |
| time                    | The time at which the purchase was made | TIMESTAMP      |
| payment                 | The total amount paid                   | VARCHAR(15)    |
| cogs                    | Cost Of Goods sold                      | DECIMAL(10, 2) |
| gross_margin_pct        | Gross margin percentage                 | FLOAT(11, 9)   |
| gross_income            | Gross Income                            | DECIMAL(12, 4) |
| rating                  | Rating                                  | FLOAT(2, 1)    |

### Analysis List

1. Product Analysis

> Conducted analysis on the data to understand the different product lines, the products lines performing best and the product lines that need to be improved.

2. Sales Analysis

> This analysis aims to answer the question of the sales trends of product. The result of this can help use measure the effectiveness of each sales strategy the business applies and what modificatoins are needed to gain more sales.

3. Customer Analysis

> This analysis aims to uncover the different customers segments, purchase trends and the profitability of each customer segment.

## Approach Used

1. **Data Wrangling:** This is the first step where inspection of data is done to make sure **NULL** values and missing values are detected and data replacement methods are used to replace, missing or **NULL** values.

> 1. Build a database
> 2. Created a table and inserted the data.
> 3. Selected columns with null values in them. There are no null values in our database as in creating the tables, we set **NOT NULL** for each field, hence null values are filtered out.

2. **Feature Engineering:** This will help use generate some new columns from existing ones.

> 1. Added a new column named `time_of_day` to give insight's of sales in the Morning, Afternoon and Evening. This will help answer the question on which part of the day most sales are made.

> 2. Added a new column named `day_name` that contains the extracted days of the week on which the given transaction took place (Mon, Tue, Wed, Thur, Fri). This will help answer the question on which week of the day each branch is busiest.

> 3. Added a new column named `month_name` that contains the extracted months of the year on which the given transaction took place (Jan, Feb, Mar). Help determine which month of the year has the most sales and profit.

3.**Exploratory Data Analysis (EDA):** Exploratory data analysis is done to answer the listed questions.


## Business Questions To Answer

### Generic Question

1. How many unique cities does the data have?
2. In which city is each branch?
3. Distribution of customer types across different branches?
4. How do sales trends by time of day?
5. How do sales trends by day of the week?
   
### Product

1. How many unique product lines does the data have?
2. What is the most common payment method?
3. What is the most selling product line?
4. What is the total revenue by month?
5. What month had the largest COGS?
6. What product line had the largest revenue?
7. What is the city with the largest revenue?
8. What product line had the largest tax/ VAT?
9. Which branch sold more products than average product sold?              
10. What is the most common product line by gender?                     
11. What is the average rating of each product line?
12. Fetch each product line and add a column to those product line showing "Good", "Bad".
    Good if its greater than average sales

### Sales

1. Number of sales made in each time of the day per weekday
2. Which of the customer types brings the most revenue?
3. Which city has the largest tax percent/ VAT (**Value Added Tax**)?
4. Which customer type pays the most in VAT?

### Customer

1. How many unique customer types does the data have?
2. How many unique payment methods does the data have?
3. What is the most common customer type?
4. Which customer type buys the most?
5. What is the gender of most of the customers?
6. What is the gender distribution per branch?
7. Which time of the day do customers give most ratings?
8. Which time of the day do customers give most ratings per branch?
9. Which day fo the week has the best avg ratings?
10. Why is that the case, how much revenue was made on these days?
11. Which day of the week has the best average ratings per branch?
