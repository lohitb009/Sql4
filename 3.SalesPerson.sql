# Write your MySQL query statement below

# Inner Join Sales and Company Table
WITH CTE AS (

    SELECT Orders.sales_id, Company.name
    FROM Orders INNER JOIN Company 
    WHERE Orders.com_id =  Company.com_id
    
)

Select SalesPerson.name as 'name'
FROM SalesPerson
WHERE SalesPerson.sales_id NOT IN (SELECT CTE.sales_id 
                                FROM CTE 
                                WHERE CTE.name='RED')
