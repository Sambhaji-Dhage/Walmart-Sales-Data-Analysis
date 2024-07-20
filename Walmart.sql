use walmartsales;
SELECT * FROM walmartsales.sales;

SELECT * FROM sales;

----------- Feature Engineering -------------

-- Adding time of the day column

Alter TABLE sales ADD COLUMN time_of_day VARCHAR(20);

Update sales set time_of_day=
( CASE
   WHEN `time` BETWEEN '00:00:00' and '12:00:00' THEN 'Morning'
   WHEN `time` BETWEEN  '12:01:00' and '16:00:00' THEN 'Afternoon'
   ELSE 'Evening' 
   END 
   );
   
-- Adding dayname column

Alter Table sales ADD COLUMN dayname Varchar(10);

Update sales set dayname=dayname(date);

-- Adding monthname column

Alter Table sales ADD COLUMN month_name VARCHAR(10);

Update sales set month_name = monthname(date);

-- --------------------------------------------------------------------
-- ---------------------------- Generic ------------------------------
-- --------------------------------------------------------------------
-- How many unique cities does the data have?

select DISTINCT(city) from sales;

-- In which city is each branch?

SELECT distinct city,branch from sales;

-- Distribution of customer types across different branches?

Select branch, customer_type, COUNT(*) as customer_ount
from sales
group by branch, customer_type
order by branch;

-- How do sales trends by time of day?

SELECT time_of_day, COUNT(*) as num_sales
from sales
group by time_of_day
order by num_sales desc;

-- How do sales trends by day of the week?

SELECT dayname(date) as day_of_week, COUNT(*) as num_sales
from sales
group by day_of_week
order by num_sales desc;


-- --------------------------------------------------------------------
-- ---------------------------- Product -------------------------------
-- --------------------------------------------------------------------

-- How many unique product lines does the data have?

select DISTINCT product_line from sales;

select count(DISTINCT product_line) as unique_product_lines
 from sales;

-- What is the most common payment method?

SELECT payment,count(payment) as count from sales
group by payment order by count desc;

-- What is the most selling product line?

SELECT product_line,count(product_line) as count from sales
group by product_line order by count desc;

-- What is the total revenue by month?

select month_name,sum(total) as total_revenue from sales 
group by month_name 
order by total_revenue desc;

-- What month had the largest COGS?

select month_name,sum(cogs) as total_cogs from sales group by
month_name order by total_cogs desc limit 1;

-- What product line had the largest revenue?

SELECT distinct product_line,sum(total)as revenue from sales
group by product_line 
order by revenue desc;

-- What is the city with the largest revenue?

SELECT branch,city,sum(total)as revenue from sales
group by branch,city 
order by revenue desc;

-- What product line had the largest VAT?

SELECT product_line,avg(tax)as avg_VAT from sales
group by product_line 
order by avg_VAT desc;


-- Which branch sold more products than average product sold?

SELECT branch,sum(quantity) as qty from sales group by
branch having qty>(SELECT avg(quantity) from sales);

-- What is the most common product line by gender?

SELECT gender,product_line,count(gender) as gender_cnt
 from sales group by
gender,product_line order by gender_cnt desc;

-- What is the average rating of each product line?

SELECT product_line,round(avg(rating),2) as avg_rating
from sales group by
product_line;


-- Fetch each product line and add a column to those product 
-- line showing "Good", "Bad". 
-- Good if its greater than average sales

SELECT 
   product_line,
   case
	   when sum(cogs) > (select avg(total) from sales) THEN "Good"
       else "Bad"
   end as `status`
from sales
group by product_line limit 10;

 
-- --------------------------------------------------------------------
-- ---------------------------- Sales -------------------------------
-- --------------------------------------------------------------------

-- Number of sales made in each time of the day per weekday

select dayname, time_of_day,COUNT(*) as total_Sales
from sales
group by dayname, time_of_day 
order by total_Sales DESC;

select time_of_day,COUNT(*) as total_Sales from sales
where dayname="Monday"
group by time_of_day order by total_Sales DESC;

-- Evenings experience most sales, the stores are filled during the evening hours


-- Which of the customer types brings the most revenue?

Select customer_type,sum(total) as total_revenue from sales
group by customer_type order by total_revenue desc;

-- Which city has the largest tax percent/ VAT (Value Added Tax)?

SELECT
	city,
    ROUND(AVG(tax), 2) AS avg_tax_pct
FROM sales
GROUP BY city 
ORDER BY avg_tax_pct DESC;

-- Which customer type pays the most in VAT?
SELECT
	customer_type,
	AVG(tax) AS total_tax
FROM sales
GROUP BY customer_type
ORDER BY total_tax;

-- --------------------------------------------------------------------
-- -------------------------- Customers -------------------------------
-- --------------------------------------------------------------------

-- How many unique customer types does the data have?
SELECT DISTINCT customer_type 
FROM sales;

-- How many unique payment methods does the data have?
SELECT DISTINCT payment
FROM sales;


-- What is the most common customer type?
SELECT customer_type, count(*) as count
FROM sales
GROUP BY customer_type
ORDER BY count DESC;

-- Which customer type buys the most?
SELECT customer_type, COUNT(*)
FROM sales
GROUP BY customer_type;


-- What is the gender of most of the customers?
SELECT
	gender,
	COUNT(*) as gender_cnt
FROM sales
GROUP BY gender
ORDER BY gender_cnt DESC;

-- What is the gender distribution per branch?
SELECT
	branch, gender,
	COUNT(*) as gender_cnt
FROM sales
GROUP BY branch, gender
ORDER BY branch, gender_cnt DESC;
-- Gender per branch is more or less the same hence, I don't think has
-- an effect of the sales per branch and other factors.

-- Which time of the day do customers give most ratings?
SELECT
	time_of_day,
	AVG(rating) AS avg_rating
FROM sales
GROUP BY time_of_day
ORDER BY avg_rating DESC;
-- Looks like time of the day does not really affect the rating, its
-- more or less the same rating each time of the day.alter


-- Which time of the day do customers give most ratings per branch?
SELECT
	branch,
	time_of_day,
	Avg(rating) AS avg_rating
FROM sales
GROUP BY branch, time_of_day
ORDER BY branch, avg_rating DESC;
-- Branch A and C are doing well in ratings, branch B needs to do a 
-- little more to get better ratings.


-- Which day of the week has the best avg ratings?
SELECT
	dayname,
	AVG(rating) AS avg_rating
FROM sales
GROUP BY dayname 
ORDER BY avg_rating DESC;
-- Mon, Fri and Tuesday are the top best days for good ratings

-- why is that the case, how much revenue was made on these days?
Select dayname, sum(total) as total_revenue
from sales
where 
    dayname = 'Monday'
    or dayname ='Friday' 
    or dayname ='Tuesday'
group by dayname
order by total_revenue desc;



-- Which day of the week has the top average ratings per branch?
SELECT t.branch, t.dayname, t.avg_rating
FROM (
	SELECT branch, dayname,
        AVG(rating) AS avg_rating,
        ROW_NUMBER() OVER (PARTITION BY branch ORDER BY AVG(rating) DESC) as rn
    FROM sales
    GROUP BY branch, dayname) as t
WHERE t.rn = 1;

-- Branch A on the friday, Branch B on monday and
-- Branch C on Saturday has the highest average ratings
