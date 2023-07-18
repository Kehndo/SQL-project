# STAFFTABLE ONLY

/*
1.) How many staff do we have in the company? 
*/
SELECT COUNT(*)
FROM stafftable;

/*
2.) How many staff are younger than 30 years?
*/

SELECT COUNT(age) AS greater_than_30
FROM stafftable
WHERE age > 30;

/*
3.) How many staff are between 30 and 25 years?
*/

SELECT COUNT(*) age_25_to_30
FROM stafftable
WHERE age BETWEEN 25 AND 30;

/*
4.) Select all the female staff and sort their age in descending order (from the oldest to the youngest)
*/

SELECT *
FROM stafftable
WHERE StaffSex = 'Female'
ORDER BY Age DESC;

/*
5.) What is the Average age of Peter and Nina?
*/

SELECT AVG(Age) avg_age
FROM stafftable
WHERE StaffName IN  ('Peter', 'Nina');

# CUSTOMERTABLE ONLY

/*
1.) How many customers do we have?
*/



/*
2.) How many customers are from Cameroon?
*/
SELECT COUNT(*) cust_cmr
FROM customertable
WHERE CustomerCountry = 'Cameroon';

/*
3.) How many customers are from Cameroon and are Males?
*/
SELECT COUNT(*)
FROM customertable
WHERE CustomerCountry = 'Cameroon' AND CustomerSex = 'Male';

/*
4.) What are the First names and Last names of customers who come from Togo and USA?
*/
SELECT customerfirstname firstname, customerlastname lastname
FROM customertable
WHERE CustomerCountry IN ('Togo', 'USA');

/*
5.) Show the first 5 oldest customers and arrange the list in decreasing order of Age (Oldest to youngest)
*/
SELECT *
FROM customertable
ORDER BY age
LIMIT 5;

/*
6.) What is the average age of customers per country?
*/

SELECT customercountry country, AVG(age) avg_age_ctry
FROM customertable
GROUP BY CustomerCountry;

# JOINING TABLES

/*
1.) What is the total profit we made?
*/

SELECT SUM(profit) total_profit
FROM salestable;

/*
2.) What is the total cost we incurred for these 03 countries "Cameroon","USA","Togo"?
*/
SELECT c.customercountry country, SUM(s.profit) total_profit
FROM customertable c
JOIN salestable s
ON c.CustomerCode = s.CustomerCode
WHERE CustomerCountry IN ('Cameroon', 'USA', 'Togo')
GROUP BY CustomerCountry;

/*
3.) What is the total profit we made per country?
*/
SELECT c.customercountry country, SUM(s.profit) total_profit
FROM customertable c
JOIN salestable s
ON c.CustomerCode = s.CustomerCode
GROUP BY CustomerCountry;

/*
4.) What is the average profit we made per country?
*/
SELECT c.customercountry country, AVG(s.profit) AVG_profit
FROM customertable c
JOIN salestable s
ON c.CustomerCode = s.CustomerCode
GROUP BY 1;

/*
5.) What is the total revenue per Staff?
*/
SELECT st.StaffName, SUM(s.Revenue) total_rev
FROM stafftable st
JOIN salestable s
ON st.MatriculeNo = s.StaffCode
GROUP BY 1;

/*
6.) Which countries made more than 100 sales transactions? Sort them in decreasing order (from biggest to smallest)
*/
SELECT c.customercountry country, SUM(s.unitssold) qty_sold
FROM customertable c
JOIN salestable s
ON c.CustomerCode = s.CustomerCode
GROUP BY country
HAVING qty_sold > 100
ORDER BY qty_sold DESC;

/*
7.) What is the total profit made per country by the following staff "Emelda","Anita","Cynthia"?
*/


SELECT  c.customercountry country, SUM(Profit) total_profit
FROM customertable c
JOIN salestable s
ON c.CustomerCode = s.CustomerCode
JOIN stafftable st
ON st.matriculeno = s.staffcode
WHERE StaffName IN ('Anita', 'Emelda', 'Cynthia')
GROUP BY 1;
