select *
from car_prices

--Basic questions

--How many total cars are in the dataset?

select count(*) as total_cars
from car_prices

--What are the top 10 most common car makes?

select top 10 make, count(*) as cars
from car_prices
group by make
order by cars desc

--What are the top 10 most common models?

select top 10 make, model, count(*) as cars
from car_prices
where make is not null
group by make, model
order by count(*) desc

--What is the average selling price overall?

select round(avg(sellingprice),0) as avg_price
from car_prices

--What is the average selling price by make?

select make, round(avg(sellingprice),0) as avg_make_price
from car_prices
group by make
order by avg_make_price desc

--What is the average selling price by body type?

select body, round(avg(sellingprice),0) as avg_body_price
from car_prices
group by body
order by avg_body_price desc

--What is the average odometer reading by year?

select year, round(avg(odometer),0) as avg_odometer
from car_prices
group by year
order by year

--How many cars were sold in each state?

select state, count(*) as cars_sold
from car_prices
group by state
order by cars_sold desc

--What is the most common transmission type?

select transmission, count(*) as cars
from car_prices
where transmission is not null
group by transmission 
order by cars desc

--What is the average selling price by transmission type?

select transmission, round(avg(sellingprice),0) as avg_selling_price
from car_prices
where transmission is not null
group by transmission 
order by avg_selling_price desc

--What is the minimum, maximum, and average condition score?

select min(condition) as min_condition,
max(condition) as max_condition,
avg(condition) as avg_condition
from car_prices

--How many distinct sellers are in the dataset?

select distinct seller, count(*) as cars_sold
from car_prices
group by seller
order by cars_sold desc

--What are the top 10 sellers by number of cars sold?

select distinct seller, count(*) as cars_sold
from car_prices
group by seller
order by cars_sold desc


--What is the average MMR (market value) by make?

select make, avg(mmr) as avg_mmr
from car_prices
group by make
order by avg_mmr desc


--Intermediate Questions

--What is the average selling price vs average MMR by make?

select make, avg(mmr) as avg_mmr, avg(sellingprice) as avg_sellingprice
from car_prices
group by make

--For each make, what is the average profit or loss
-- selling_price - mmr

select make, avg(mmr) as avg_mmr, avg(sellingprice) as avg_sellingprice,
avg(mmr) - avg(sellingprice) as profit_or_loss
from car_prices
group by make
order by profit_or_loss desc

--Which models sell above MMR on average?

select model, avg(mmr) as avg_model_mmr
from car_prices
group by model
having avg(mmr) > (
select avg(mmr) as avg_mmr
from car_prices)
order by avg_model_mmr desc

--Which models sell below MMR on average?

select model, avg(mmr) as avg_model_mmr
from car_prices
group by model
having (
select avg(mmr) as avg_mmr
from car_prices) > avg(mmr)
order by avg_model_mmr desc

--What percentage of cars sell above MMR?

select 
round(cast(sum(CASE WHEN sellingprice > mmr THEN 1 ELSE 0 END) as int)/cast(count(*) as decimal) * 100, 2) as ct
from car_prices

--What is the average selling price by car age
-- (sale_year - year)

select cast(substring(saledate,12,4) as int) - year as car_age, avg(sellingprice) as avg_sellingprice
from car_prices
where cast(substring(saledate,12,4) as int) - year is not null and cast(substring(saledate,12,4) as int) - year >= -1
group by cast(substring(saledate,12,4) as int) - year
order by 1

--How does condition impact selling price? --It appears as condition goes up, average selling price also goes up. But, there are some outliers that skew'ed the results. 

select condition, avg(sellingprice) as avg_sellingprice
from car_prices
where condition is not null
group by condition
order by condition

--How does odometer mileage impact selling price? 
--With lower odometer values, the values of the cars are worth more than higher odometer values. Lower odometer values means the car is less used compared to higher odometer 
--values meaning heavily used.

WITH cte as (
select odometer, 
CASE WHEN odometer BETWEEN 0 AND 15000 THEN 'low_odometer'
	 WHEN odometer BETWEEN 15001 AND 25000 THEN 'mid_odometer'
	 WHEN odometer BETWEEN 25001 AND 35000 THEN 'high_odometer'
	 WHEN odometer BETWEEN 35001 AND 50000 THEN 'very_high_odometer'
	 ELSE 'extremely_high_odometer'
	 END as odometer_category, sellingprice
from car_prices)

select odometer_category, avg(sellingprice) as avg_sellingprice
from cte
group by odometer_category
order by avg_sellingprice desc

--What is the average selling price by color?

select color, avg(sellingprice) as avg_sellingprice
from car_prices
group by color
order by avg_sellingprice desc

--Which states have the highest average selling price?

select top 10 state, round(avg(sellingprice),0) as avg_sellingprice
from car_prices
group by state
order by avg_sellingprice desc

--What are monthly sales volumes?

select substring(saledate, 5,3) as month, sum(sellingprice) as monthly_sum
from car_prices
where substring(saledate, 5,3) is not null and substring(saledate, 5,3) <> '' 
group by substring(saledate, 5,3)
order by monthly_sum desc

--What is average selling price by month?

select substring(saledate, 5,3) as month, avg(sellingprice) as avg_selling
from car_prices
where substring(saledate, 5,3) is not null and substring(saledate, 5,3) <> '' 
group by substring(saledate, 5,3)
order by avg_selling desc

--What are the top 5 makes sold in each year?

with cte as (
select substring(saledate,12,4) as year, make, count(*) as cars_sold
from car_prices
where sellingprice is not null and make is not null and substring(saledate,12,4) <> ''
group by substring(saledate,12,4), make
),

 cte2 as (
select *,
dense_rank() over (partition by year order by cars_sold desc) as rank
from cte
)

select year, make, cars_sold
from cte2
where rank <=5
order by year 


--Which sellers generate the most total revenue?

select seller, sum(sellingprice) as total_sales
from car_prices
group by seller
order by total_sales desc

--Which sellers have the highest average selling price?

select seller, avg(sellingprice) as avg_sales
from car_prices
group by seller
order by avg_sales desc

--What body types sell for the highest prices on average?

select body, avg(sellingprice) as avg_sellingprice
from car_prices
group by body
order by avg_sellingprice desc

--What transmission type sells for more on average?

select transmission, avg(sellingprice) as avg_sellingprice
from car_prices
where transmission is not null
group by transmission
order by avg_sellingprice desc

--What is the average price difference between automatic and manual cars?

select 
avg(case when transmission = 'automatic' then sellingprice end) -
avg(case when transmission = 'manual' then sellingprice end) as difference_price
from car_prices
where transmission is not null and sellingprice is not null

--Hard Questions

--Rank the top 5 most expensive cars sold each year.

with cte as (
select substring(saledate,12,4) as year, make, model, trim, sellingprice as car_price
from car_prices
where sellingprice is not null and make is not null and substring(saledate,12,4) <> ''
),

 cte2 as (
select *,
dense_rank() over (partition by year order by car_price desc) as rank
from cte
)

select *
from cte2
where rank <=5
order by year asc, car_price desc

--Rank the top 5 makes by total revenue each year.

with cte as (
select substring(saledate,12,4) as year, make, sum(sellingprice) as total_revenue
from car_prices
where sellingprice is not null and make is not null and substring(saledate,12,4) <> ''
group by substring(saledate,12,4), make),

cte2 as (
select *,
DENSE_RANK() over (partition by year order by total_revenue desc) as rankings
from cte)

select *
from cte2
where rankings <=5

--Find the best-selling model for each year.

with cte as (
select substring(saledate,12,4) as year, make, model, sum(sellingprice) as total_revenue
from car_prices
where sellingprice is not null and make is not null and substring(saledate,12,4) <> ''
group by substring(saledate,12,4), make, model),

cte2 as (
select *, 
DENSE_RANK() over (partition by year order by total_revenue desc) as ranks
from cte)

select year, make, model
from cte2
where ranks = 1

--Find sellers whose average profit
-- (selling_price - mmr) is above the overall average.

select seller, avg(sellingprice - mmr) as avg_profit_loss
from car_prices
group by seller 
having avg(sellingprice - mmr) > (
select avg(sellingprice - mmr) as profit
from car_prices) 
order by avg_profit_loss desc 

--Identify price outliers
--can see ford has a vehile for 230,000 compared to the average ford vehile sold at 14,000, indicating an outlier
--mercedes benz has a max vehile sold at 173,000, while the average is around 27,907

select make, model, max(sellingprice) as max_price, avg(sellingprice) as avg_price
from car_prices
group by make, model
order by max_price desc

--For each make, calculate year-over-year price growth.

with cte as (
select year, make, sum(mmr) as current_year_sales
from car_prices
where make is not null
group by year, make ),

cte2 as (

select *,
lead(current_year_sales) over (partition by make order by year) as next_year_sales
from cte)

select *, 
(next_year_sales - current_year_sales) as price_growth
from cte2


--For each model, calculate year-over-year sales growth.

with cte as (
select year, make, model, sum(sellingprice) as current_year_sales
from car_prices
where make is not null
group by year, make,model),

cte2 as (

select *,
lead(current_year_sales) over (partition by make, model order by year) as next_year_sales
from cte)

select *, 
(next_year_sales - current_year_sales) as sales_growth
from cte2

--Find the top 3 states by revenue for each year.

with cte as(
select year, state, sum(sellingprice) as total_sales
from car_prices
group by year, state ),

cte2 as (

select *,
DENSE_RANK() over (partition by year order by total_sales desc) as ranking
from cte
 )

select year, state, total_sales
from cte2
where ranking <= 3

--For each seller, rank their best and worst sales by profit.

with cte as (
select seller, (sellingprice - mmr) as profit
from car_prices ),

cte2 as (
select *,
DENSE_RANK() over (partition by seller order by profit desc) as rankings
from cte )

select seller, min(profit) as worst_sales, max(profit) as best_sales
 from cte2
 where profit is not null
group by seller
order by best_sales desc
 
--Identify seasonal trends in car sales volume.
--Winter season seems to have more than triple the sales of Spring and Summer, respectively. 

with cte as (
select distinct substring(saledate, 5, 3) as month, sum(sellingprice) as total_sales
from car_prices
where substring(saledate, 5, 3) is not null and substring(saledate, 5, 3) <> '0'
group by substring(saledate, 5, 3) ),

cte2 as (

select *, 
CASE WHEN month in ('Dec', 'Jan', 'Feb') THEN 'Winter' 
	 WHEN month in ('Mar', 'Apr', 'May') THEN 'Spring'
	 WHEN month in ('Jun', 'Jul') THEN 'Summer'
	 END as seasonal 
from cte )

select seasonal, sum(total_sales) as seasonal_sales 
from cte2
where seasonal is not null
group by seasonal
order by seasonal_sales desc

--Find cars that sold far above expected price
-- selling_price > mmr + 20%.

select *
from car_prices
where sellingprice > (mmr * 1.20)

--For each make + year, calculate market premium
-- avg(selling_price) − avg(mmr).

select year, make, avg(sellingprice) - avg(mmr) as market_premium 
from car_prices
where make is not null and year is not null
group by year, make
order by year, make