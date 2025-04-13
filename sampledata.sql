-- Testing the Database with Sample Data

USE bookstore_db;

-- Populate all lookup tables
-- 1. Insert book languages
INSERT INTO book_language (language_code, language_name) VALUES
('en', 'English'),
('fr', 'French'),
('es', 'Spanish'),
('de', 'German'),
('sw', 'Swahili');

-- 2. Insert address statuses
INSERT INTO address_status (status_name) VALUES
('Current'),
('Previous'),
('Temporary');

-- 3. Insert order statuses
INSERT INTO order_status (status_name) VALUES
('Pending'),
('Payment Confirmed'),
('Shipped'),
('Delivered'),
('Cancelled');

-- 4. Insert shipping methods
INSERT INTO shipping_method (method_name, cost) VALUES
('Standard', 4.99),
('Express', 9.99),
('International', 14.99),
('Local Pickup', 0.00);

-- 5. Countries 
INSERT INTO country (country_name) VALUES 
('United States'),
('Canada'),
('United Kingdom'),
('Australia'),
('Germany'),
('Kenya');

-- 6. Publishers 
INSERT INTO publisher (publisher_name) VALUES
('Penguin Random House'),
('HarperCollins'),
('Simon & Schuster'),
('Macmillan Publishers'),
('Oxford University Press'),
('Kwani Trust');

-- 7. Authors 
INSERT INTO author (author_name) VALUES
('J.K. Rowling'),
('Stephen King'),
('Jane Austen'),
('George Orwell'),
('Agatha Christie'),
('Mark Twain'),
('Ngũgĩ wa Thiong\'o');

-- 8. Addresses depending on country
INSERT INTO address (street_number, street_name, city, state, postal_code, country_id) VALUES
('123', 'Main St', 'New York', 'NY', '10001', 1),
('456', 'Maple Ave', 'Toronto', 'ON', 'M5V 2H1', 2),
('789', 'Oxford St', 'London', '', 'W1D 1BS', 3),
('101', 'Collins St', 'Melbourne', 'VIC', '3000', 4),
('202', 'Friedrichstraße', 'Berlin', '', '10117', 5),
('85', 'Kenyatta Avenue', 'Nairobi', '', '00100', 6);

-- 9. Customers 
INSERT INTO customer (first_name, last_name, email, phone) VALUES
('John', 'Smith', 'john.smith@example.com', '212-555-1234'),
('Emma', 'Johnson', 'emma.j@example.com', '416-555-5678'),
('David', 'Brown', 'daveb@example.com', '020-7946-0958'),
('Sophia', 'Williams', 'sophia.w@example.com', '03-9555-7890'),
('Michael', 'Miller', 'michael.m@example.com', '030-2275-9034'),
('Amani', 'Odhiambo', 'amani.o@example.com', '254-722-123456');

-- 10. Books depending on publisher and language
INSERT INTO book (title, isbn13, isbn10, publication_date, publisher_id, language_id, price, pages, stock_quantity) VALUES
('Harry Potter and the Philosopher\'s Stone', '9780747532743', '0747532745', '1997-06-26', 1, 1, 19.99, 223, 150),
('The Shining', '9780307743657', '0307743659', '1977-01-28', 2, 1, 15.99, 447, 80),
('Pride and Prejudice', '9780141439518', '0141439513', '1813-01-28', 3, 1, 9.99, 432, 120),
('1984', '9780451524935', '0451524934', '1949-06-08', 4, 1, 12.99, 328, 200),
('Murder on the Orient Express', '9780062693662', '0062693662', '1934-01-01', 2, 1, 14.99, 256, 75),
('Wizard of the Crow', '9780099428276', '0099428276', '2006-08-04', 6, 1, 16.99, 768, 45),
('Weep Not, Child', '9780143026242', '0143026240', '1964-01-01', 6, 5, 14.99, 136, 35);

-- 11. Book-Author associations (junction table)
SELECT id, title FROM book;

-- 11. Book-Author associations (junction table)
INSERT INTO book_author (book_id, author_id) VALUES
((SELECT id FROM book WHERE title = 'Harry Potter and the Philosopher''s Stone'), 1),
((SELECT id FROM book WHERE title = 'The Shining'), 2),
((SELECT id FROM book WHERE title = 'Pride and Prejudice'), 3),
((SELECT id FROM book WHERE title = '1984'), 4),
((SELECT id FROM book WHERE title = 'Murder on the Orient Express'), 5),
((SELECT id FROM book WHERE title = 'Wizard of the Crow'), 7),
((SELECT id FROM book WHERE title = 'Weep Not, Child'), 7);


-- 12. Customer Address associations depending on customer, address, and address_status
INSERT INTO customer_address (customer_id, address_id, status_id, date_from) VALUES
(1, 1, 1, '2020-01-15'), -- John Smith - current
(2, 2, 1, '2019-03-20'), -- Emma Johnson - current
(3, 3, 1, '2021-05-10'), -- David Brown - current
(4, 4, 1, '2018-11-05'), -- Sophia Williams - current
(5, 5, 1, '2022-02-28'), -- Michael Miller - current
(6, 6, 1, '2021-08-12'); -- Amani Odhiambo - current

-- 13. Orders depending on customer, address, and shipping_method
INSERT INTO cust_order (order_date, customer_id, shipping_address_id, shipping_method_id, order_total) VALUES
('2023-03-15 10:30:00', 1, 1, 1, 19.99),   -- John ordered Harry Potter
('2023-03-16 14:45:00', 2, 2, 2, 30.98),   -- Emma ordered The Shining and Pride and Prejudice
('2023-03-17 09:15:00', 3, 3, 3, 12.99),   -- David ordered 1984
('2023-03-18 16:20:00', 4, 4, 1, 14.99),   -- Sophia ordered Murder on the Orient Express
('2023-03-19 11:05:00', 5, 5, 2, 19.99),   -- Michael ordered Harry Potter
('2023-03-20 13:25:00', 6, 6, 3, 16.99),   -- Amani ordered Wizard of the Crow
('2023-03-22 09:45:00', 6, 6, 3, 14.99);   -- Amani ordered Weep Not, Child

-- 14. Order Lines depending on order and book
SELECT id, title FROM book;

INSERT INTO order_line (order_id, book_id, quantity, price) VALUES
(1, 13, 1, 19.99),  -- John - Harry Potter
(2, 14, 1, 15.99),  -- Emma - The Shining
(2, 15, 1, 14.99),  -- Emma - Pride and Prejudice
(3, 16, 1, 12.99),  -- David - 1984
(4, 17, 1, 14.99),  -- Sophia - Murder on the Orient Express
(5, 13, 1, 19.99),  -- Michael - Harry Potter
(6, 18, 1, 16.99),  -- Amani - Wizard of the Crow
(7, 19, 1, 14.99);  -- Amani - Weep Not, Child


-- 15. Order History depending on order and order_status
INSERT INTO order_history (order_id, status_id, status_date, notes) VALUES
(1, 1, '2023-03-15 10:30:00', 'Order placed online'),
(1, 2, '2023-03-15 14:20:00', 'Payment confirmed'),
(1, 3, '2023-03-16 11:00:00', 'Package shipped via USPS'),
(1, 4, '2023-03-18 09:15:00', 'Package delivered'),
(2, 1, '2023-03-16 14:45:00', 'Order placed by phone'),
(2, 2, '2023-03-16 15:30:00', 'Payment confirmed'),
(2, 3, '2023-03-17 10:15:00', 'Package shipped via FedEx'),
(2, 4, '2023-03-19 11:20:00', 'Package delivered'),
(3, 1, '2023-03-17 09:15:00', 'Order placed online'),
(3, 2, '2023-03-17 10:00:00', 'Payment confirmed'),
(3, 3, '2023-03-18 14:30:00', 'Package shipped via Royal Mail'),
(3, 4, '2023-03-22 13:45:00', 'Package delivered'),
(4, 1, '2023-03-18 16:20:00', 'Order placed online'),
(4, 2, '2023-03-19 09:00:00', 'Payment confirmed'),
(4, 3, '2023-03-20 10:30:00', 'Package shipped via Australia Post'),
(4, 4, '2023-03-24 15:10:00', 'Package delivered'),
(5, 1, '2023-03-19 11:05:00', 'Order placed in store'),
(5, 2, '2023-03-19 11:05:00', 'Payment confirmed at register'),
(5, 4, '2023-03-19 11:10:00', 'Customer took purchase home'),
(6, 1, '2023-03-20 13:25:00', 'Order placed online'),
(6, 2, '2023-03-20 14:10:00', 'Payment confirmed'),
(6, 3, '2023-03-21 08:45:00', 'Package shipped via Kenya Post'),
(6, 4, '2023-03-28 16:20:00', 'Package delivered'),
(7, 1, '2023-03-22 09:45:00', 'Order placed online'),
(7, 2, '2023-03-22 10:15:00', 'Payment confirmed'),
(7, 3, '2023-03-23 08:30:00', 'Package shipped via Kenya Post'),
(7, 4, '2023-03-29 14:20:00', 'Package delivered');

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
    
    

