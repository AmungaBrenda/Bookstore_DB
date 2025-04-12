CREATE database bookstore_db;

USE bookstore_db;

-- Create the country table
CREATE TABLE country (
    id INT AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(200) NOT NULL,
    CONSTRAINT unique_country_name UNIQUE (country_name)
);

-- Create the address table
CREATE TABLE address (
    id INT AUTO_INCREMENT PRIMARY KEY,
    street_number VARCHAR(10),
    street_name VARCHAR(200),
    city VARCHAR(100),
    state VARCHAR(100),
    postal_code VARCHAR(20),
    country_id INT NOT NULL,
    FOREIGN KEY (country_id) REFERENCES country(id)
);

-- Create the address_status table
CREATE TABLE address_status(
       id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(30) NOT NULL,
    CONSTRAINT unique_status_name UNIQUE (status_name)
);

-- Create the publisher table
CREATE TABLE publisher(
    id INT AUTO_INCREMENT PRIMARY KEY,
    publisher_name VARCHAR(400) NOT NULL,
    CONSTRAINT unique_publisher_name UNIQUE (publisher_name)
);  

-- Create the book_language table
CREATE TABLE book_language (
    id INT AUTO_INCREMENT PRIMARY KEY,
    language_code VARCHAR(8) NOT NULL,
    language_name VARCHAR(50) NOT NULL,
    CONSTRAINT unique_language_code UNIQUE (language_code)
);

-- Create the author table
CREATE TABLE author (
    id INT AUTO_INCREMENT PRIMARY KEY,
    author_name VARCHAR(400) NOT NULL,
    CONSTRAINT unique_author_name UNIQUE (author_name)
);

-- Create the shipping_method table
CREATE TABLE shipping_method (
    id INT AUTO_INCREMENT PRIMARY KEY,
    method_name VARCHAR(100) NOT NULL,
    cost DECIMAL(6,2) NOT NULL,
    CONSTRAINT unique_method_name UNIQUE (method_name)
);

-- Create the order_status table
CREATE TABLE order_status (
    id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL,
    CONSTRAINT unique_order_status_name UNIQUE (status_name)
);

-- Create the customer table
CREATE TABLE customer (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(200),
    last_name VARCHAR(200) NOT NULL,
    email VARCHAR(350) NOT NULL,
    phone VARCHAR(20),
    date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT unique_customer_email UNIQUE (email)
);

-- Create the book table
CREATE TABLE book (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(400) NOT NULL,
    isbn13 VARCHAR(13),
    isbn10 VARCHAR(10),
    publication_date DATE,
    publisher_id INT,
    language_id INT,
    price DECIMAL(10,2) NOT NULL,
    pages INT,
    stock_quantity INT NOT NULL DEFAULT 0,
    FOREIGN KEY (publisher_id) REFERENCES publisher(id),
    FOREIGN KEY (language_id) REFERENCES book_language(id),
    CONSTRAINT unique_isbn13 UNIQUE (isbn13),
    CONSTRAINT unique_isbn10 UNIQUE (isbn10)
);

-- Create the customer_address junction table
CREATE TABLE customer_address (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    address_id INT NOT NULL,
    status_id INT NOT NULL,
    date_from DATE NOT NULL,
    date_to DATE,
    FOREIGN KEY (customer_id) REFERENCES customer(id),
    FOREIGN KEY (address_id) REFERENCES address(id),
    FOREIGN KEY (status_id) REFERENCES address_status(id),
    CONSTRAINT unique_customer_address UNIQUE (customer_id, address_id, date_from)
);

-- Create the book_author junction table
CREATE TABLE book_author (
    book_id INT NOT NULL,
    author_id INT NOT NULL,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(id),
    FOREIGN KEY (author_id) REFERENCES author(id)
);

-- Create the cust_order table
CREATE TABLE cust_order (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    customer_id INT NOT NULL,
    shipping_address_id INT NOT NULL,
    shipping_method_id INT NOT NULL,
    order_total DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customer(id),
    FOREIGN KEY (shipping_address_id) REFERENCES address(id),
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(id)
);

-- Create the order_line table
CREATE TABLE order_line (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    book_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES cust_order(id),
    FOREIGN KEY (book_id) REFERENCES book(id),
    CONSTRAINT unique_order_book UNIQUE (order_id, book_id)
);

-- Create the order_history table
CREATE TABLE order_history (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    status_id INT NOT NULL,
    status_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    notes TEXT,
    FOREIGN KEY (order_id) REFERENCES cust_order(id),
    FOREIGN KEY (status_id) REFERENCES order_status(id)
);
   

