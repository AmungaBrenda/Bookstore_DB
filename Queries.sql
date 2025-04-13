-- Test our database with various queries

-- QUERY 1: Get all books with their authors and publishers
SELECT 
    b.title, 
    a.author_name, 
    p.publisher_name,
    bl.language_name,
    b.price,
    b.stock_quantity
FROM 
    book b
JOIN 
    book_author ba ON b.id = ba.book_id
JOIN 
    author a ON ba.author_id = a.id
JOIN 
    publisher p ON b.publisher_id = p.id
JOIN
    book_language bl ON b.language_id = bl.id
ORDER BY 
    b.title;

-- QUERY 2: Get customer order history with status updates
SELECT 
    c.first_name,
    c.last_name,
    co.id AS order_id,
    os.status_name,
    oh.status_date,
    oh.notes
FROM 
    customer c
JOIN 
    cust_order co ON c.id = co.customer_id
JOIN 
    order_history oh ON co.id = oh.order_id
JOIN 
    order_status os ON oh.status_id = os.id
ORDER BY 
    c.id, oh.status_date;
    


-- QUERY 3: Total sales by book (quantity sold and total revenue)
    SELECT 
    b.title,
    SUM(ol.quantity) AS total_copies_sold,
    SUM(ol.price * ol.quantity) AS total_revenue
FROM 
    order_line ol
JOIN 
    book b ON ol.book_id = b.id
GROUP BY 
    b.title
ORDER BY 
    total_revenue DESC;
    
--  QUERY 4: Active shipping methods used in orders and their frequencies
SELECT 
    sm.method_name,
    COUNT(co.id) AS total_orders,
    SUM(co.order_total) AS total_sales
FROM 
    cust_order co
JOIN 
    shipping_method sm ON co.shipping_method_id = sm.id
GROUP BY 
    sm.method_name
ORDER BY 
    total_orders DESC;
    
-- QUERY 5: Customers and the number of orders they have placed
SELECT 
    c.first_name,
    c.last_name,
    COUNT(co.id) AS number_of_orders,
    SUM(co.order_total) AS total_spent
FROM 
    customer c
LEFT JOIN 
    cust_order co ON c.id = co.customer_id
GROUP BY 
    c.id
ORDER BY 
    total_spent DESC;
    
    

