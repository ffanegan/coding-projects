--RESTAURANT DATA ANALYSIS

--Source: https://mavenanalytics.io/data-playground/restaurant-orders?pageSize=10

-- Tableau Visualization on Profile: https://public.tableau.com/views/RestaurantDataAnalysis_17579719166500/Dashboard1?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link


-- Get an overview of the data
SELECT * FROM order_details LIMIT 10;

SELECT * FROM menu_items LIMIT 10;


--Questions about the *Menu Items* table:

--1) How many separate items are on the menu?:

SELECT COUNT(*)
FROM menu_items

--32

--2)  What are the distinct items on the menu?

SELECT DISTINCT  menu_items.item_name 
FROM menu_items
GROUP BY menu_items.item_name

/*
Menu Items
----
California Roll
Cheese Lasagna
Cheese Quesadillas
Cheeseburger
Chicken Burrito
Chicken Parmesan
Chicken Tacos
Chicken Torta
Chips & Guacamole
Chips & Salsa
Edamame
Eggplant Parmesan
Fettuccine Alfredo
French Fries
Hamburger
Hot Dog
Korean Beef Bowl
Mac & Cheese
Meat Lasagna
Mushroom Ravioli
Orange Chicken
Pork Ramen
Potstickers
Salmon Roll
Shrimp Scampi
Spaghetti
Spaghetti & Meatballs
Steak Burrito
Steak Tacos
Steak Torta
Tofu Pad Thai
Veggie Burger
*/

--3) What are the least and most expensive items on the menu?

--Most expensive: 
SELECT item_name, MAX(price)
FROM menu_items
--Shrimp Scampi

--Least expensive:
SELECT item_name, MIN(price)
FROM menu_items
--Edamame

--4) How many menu items are in each cuisine category?
SELECT  category, COUNT(category) AS ITEM_COUNT
FROM menu_items
GROUP BY category

/*
American 6
Asian	8
Italian	9
Mexican	9
*/

--5) What are the least and most expensive items on the each menu category

--Italian category
--Most Expensive
SELECT *, MAX(price)
FROM menu_items
WHERE category="Italian"
--Shrimp Scampi

--Least Expensive
SELECT *, MIN(price)
FROM menu_items
WHERE category="Italian"
--Spaghetti

--Asian category
--Most Expensive
SELECT *, MAX(price)
FROM menu_items
WHERE category="Asian"
--Korean Beef Bowl

--Least Expensive
SELECT *, MIN(price)
FROM menu_items
WHERE category="Asian"
--Edamame

--American category
--Most Expensive
SELECT *, MAX(price)
FROM menu_items
WHERE category="American"
--Cheeseburger

--Least Expensive
SELECT *, MIN(price)
FROM menu_items
WHERE category="American"
--Mac & Cheese

--Mexican category
--Most Expensive
SELECT *, MAX(price)
FROM menu_items
WHERE category="Mexican"
--Steak Burrito

--Least Expensive
SELECT *, MIN(price)
FROM menu_items
WHERE category="Mexican"
--Chips & Salsa

--6) What is the average dish price within each category?

SELECT AVG(price) AS AVG_price, category
FROM menu_items
GROUP BY category

/*
AVG_price category
10.0666666666667	American
13.475	Asian
16.75	Italian
11.8	Mexican
*/



--Questions about our data in the *Order Details* table:

--1) What is the date range of the table?
SELECT MIN(order_date), MAX(order_date)
FROM order_details

--From 1/1/23 through 3/9/23 inclusive

--2) How many orders and items were made within this date range?
SELECT COUNT( DISTINCT order_id)
FROM order_details

--5370

SELECT COUNT( DISTINCT order_details_id)
FROM order_details

--12234

--3) How many items were ordered by each order? Which orders had the most number of items?
SELECT COUNT( DISTINCT item_id) AS item_num, order_id
FROM order_details
GROUP BY order_id

--4) How many orders had more than 12 items?
SELECT COUNT( DISTINCT item_id) AS item_num, order_id
FROM order_details
GROUP BY order_id
HAVING item_num>12

/*  4 parties ordered more than 12 items from the menu.
13	2725
13	3473
13	4305
13	4836
*/

--5) Which items were ordered the most and the least?

SELECT COUNT(item_id) AS order_freq, menu_items.item_name, item_id
FROM order_details
JOIN menu_items ON order_details.item_id=menu_items.menu_item_id
GROUP BY item_id 
ORDER BY COUNT(item_id) DESC;

/*
--MOST
order_freq item_name item_id
622	Hamburger	101	American
620	Edamame	113	Asian
588	Korean Beef Bowl	109	Asian
583	Cheeseburger	102	American
571	French Fries	106	American
*/

SELECT COUNT(item_id) AS order_freq, menu_items.item_name, item_id
FROM order_details
JOIN menu_items ON order_details.item_id=menu_items.menu_item_id
GROUP BY item_id 
ORDER BY COUNT(item_id) ASC;

/*
--LEAST
order_freq item_name item_id
123	Chicken Tacos	115	Mexican
205	Potstickers	114	Asian
207	Cheese Lasagna	128	Italian
214	Steak Tacos	116	Mexican
233	Cheese Quesadillas	121	Mexican
*/

--6) Which date had the most sales? Which date had the least sales?

--MOST SALES
SELECT order_date,  SUM(price)
FROM order_details AS OD
JOIN menu_items AS MI ON OD.item_id=MI.menu_item_id
GROUP BY order_date
ORDER BY SUM(price) DESC;

--2/1/23:	2396.35

--LEAST SALES
SELECT order_date,  SUM(price)
FROM order_details AS OD
JOIN menu_items AS MI ON OD.item_id=MI.menu_item_id
GROUP BY order_date
ORDER BY SUM(price) ASC;

--3/22/23:	1016.9

--7) What were the orders that spent the most money?
SELECT  SUM(price),order_id
FROM order_details AS OD
JOIN menu_items AS MI ON OD.item_id=MI.menu_item_id
GROUP BY order_id
ORDER BY SUM(price) DESC;

/*
Total Price Menu, order_id 
192.15	440
191.05	2075
190.1	1957
189.7	330
185.1	2675
*/



--8) What insights can we gather from the order that spent the most?

SELECT  *,  SUM(price), COUNT( item_name)
FROM order_details AS OD
JOIN menu_items AS MI ON OD.item_id=MI.menu_item_id
WHERE order_id="440"
GROUP BY category
/*
Date: 1/8/23
All at one time: 12:16:34 PM
Total price: $192.15
Total of 14 items
Ordered 2 items from the Asain, American and Mexican categories and 8 items from the Italian category
Ordered 2 Fettuccine Alfredo and 2 Spaghetti & Meatballs
*/

--9) What insights can we gather from the top 5 orders that spent the most?
SELECT  category,  SUM(price), COUNT( item_name)
FROM order_details AS OD
JOIN menu_items AS MI ON OD.item_id=MI.menu_item_id
WHERE order_id IN (440, 2075, 1957, 330, 2675)
GROUP BY category

/*

American	9.0	    99.35	10
Asian	    16.5	228.65	17
Italian	    14.5	430.65	26
Mexican	    14.95	189.45	16

They ordered Italian food the most and American food the least. 
*/

SELECT  order_id, order_time
FROM order_details AS OD
JOIN menu_items AS MI ON OD.item_id=MI.menu_item_id
WHERE order_id IN (440, 2075, 1957, 330, 2675)
GROUP BY order_time

/*
order_id order_time
440	    12:16:34 PM
330	    1:27:11 PM
2075	2:03:04 PM
2675	2:41:49 PM
1957	2:50:01 PM

Their orders took place from noon to around 3 PM, around the lunch hour.
*/


-- 10) Were there certain times that had more or fewer orders?

--It seems that 11:00AM to about 2:00 PM was the busiest, and the least amount of orders fall after 10:00 PM.
SELECT  order_time,  COUNT(order_id) As num_orders
FROM order_details AS OD
JOIN menu_items AS MI ON OD.item_id=MI.menu_item_id
GROUP BY order_time
ORDER BY COUNT(order_id) DESC;

/*
order_time, num_orders
1:13:33 PM	16
12:24:36 PM	16
12:07:16 PM	16
11:49:01 AM	16
1:58:44 PM	15
2:50:01 PM	14
2:41:49 PM	14
2:00:05 PM	14
1:41:43 PM	14
1:27:11 PM	14
*/
SELECT  order_time,  COUNT(order_id) As num_orders
FROM order_details AS OD
JOIN menu_items AS MI ON OD.item_id=MI.menu_item_id
GROUP BY order_time
ORDER BY COUNT(order_id) ASC;

/*
order_time num_orders
10:02:08 PM	1
10:02:38 PM	1
10:03:03 PM	1
10:03:40 PM	1
10:04:05 PM	1
10:04:12 PM	1
10:05:37 PM	1
10:06:08 PM	1
10:06:53 PM	1
10:07:03 PM	1
*/


