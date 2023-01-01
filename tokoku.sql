use tokoku;

-- DROP TABLE
DROP TABLE items;
DROP TABLE transactions;
DROP TABLE products;
DROP TABLE customers;
DROP TABLE users;

-- CREATE TABLE
CREATE TABLE users(
	id INT PRIMARY KEY AUTO_INCREMENT,
	username VARCHAR(50) NOT NULL,
	password varchar(50) NOT NULL,
	role VARCHAR(10) NOT NULL,
	is_active BOOLEAN DEFAULT TRUE NOT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE customers(
	id INT PRIMARY KEY AUTO_INCREMENT,
	staff_id INT NOT NULL,
	name varchar(50) NOT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	is_active BOOLEAN DEFAULT TRUE NOT NULL,
	CONSTRAINT fk_customers_users FOREIGN KEY(staff_id) REFERENCES users(id)
);

CREATE TABLE products(
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(50) NOT NULL,
	staff_id INT NOT NULL,
	stock INT,
	is_active BOOLEAN DEFAULT TRUE NOT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT fk_products_users FOREIGN KEY(staff_id) REFERENCES users(id)
);

CREATE TABLE transactions(
	id INT PRIMARY KEY AUTO_INCREMENT,
	staff_id INT NOT NULL,
	customer_id INT NOT NULL,
	is_active BOOLEAN DEFAULT TRUE NOT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT fk_transactions_users FOREIGN KEY(staff_id) REFERENCES users(id),
	CONSTRAINT fk_transactions_customers FOREIGN KEY(customer_id) REFERENCES customers(id)
);

CREATE TABLE items(
	transaction_id INT NOT NULL,
	product_id INT NOT NULL,
	quantity INT NOT NULL,
	is_active BOOLEAN DEFAULT TRUE NOT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT fk_items_transactions FOREIGN KEY(transaction_id) REFERENCES transactions(id),
	CONSTRAINT fk_items_product FOREIGN KEY(product_id) REFERENCES products(id),
	PRIMARY KEY(transaction_id, product_id)
);


-- DELETE RECORD
DELETE FROM users;


-- INSERT RECORD
INSERT INTO users(username, password, role) 
VALUES("admin", "admin", "admin"), ("helmi", "123", "staff"), ("muzakir", "123", "staff");

INSERT INTO customers(staff_id, name) 
VALUES(2, "nita"), (3, "john");

INSERT INTO products(staff_id, name, stock)
VALUES(2, "Keyboard", 20), (3, "Mouse", 10);

INSERT INTO transactions(staff_id, customer_id)
VALUES(2, 1), (3, 2);

INSERT INTO items(transaction_id, product_id, quantity)
VALUES(1, 1, 3), (1, 2, 2), (2, 2, 3); 

-- UPDATE RECORD

-- SELECT RECORD
SELECT * FROM users; 

SELECT c.id, u.username AS "staff name", c.name, c.created_at, c.is_active  
FROM customers c
JOIN users u ON u.id = c.staff_id;

SELECT p.id, u.username AS "staff name", p.name, p.stock , p.is_active, p.created_at 
FROM products p
JOIN users u ON u.id = p.staff_id;

SELECT t.id, u.username AS "staff_name", c.name AS "customer_name", t.is_active, t.created_at
FROM transactions t 
JOIN users u ON u.id = t.staff_id
JOIN customers c ON c.id = t.customer_id;

SELECT t.id AS "transaction_id", p.name AS "product_name", i.quantity, i.is_active, i.created_at 
FROM items i 
JOIN transactions t ON t.id = i.transaction_id
JOIN products p ON p.id = i.product_id 
