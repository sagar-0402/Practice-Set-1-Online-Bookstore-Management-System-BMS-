# Practice-Set-1-Online-Bookstore-Management-System-BMS-
Expected to write MySQL DDL (Data Definition Language) queries to design, manage,  and alter the schema and create the backend database for an online bookstore. The system must  handle books, authors, customers, orders, payments, categories, and delivery agents.
# 📚 Online Bookstore Management System (BMS)
### Practice Set 1 — MySQL DDL Assignment

![MySQL](https://img.shields.io/badge/MySQL-8.0-blue?logo=mysql&logoColor=white)
![DDL](https://img.shields.io/badge/SQL-DDL-orange)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen)

---

## 📌 Project Overview

The **Online Bookstore Management System (BMS)** is a relational database backend designed using **MySQL DDL (Data Definition Language)**. This system models a real-world online bookstore that handles books, authors, customers, orders, payments, categories, and delivery agents — all through a well-structured, normalized relational schema.

This project demonstrates the ability to:
- Design and create a normalized database schema from scratch
- Define tables with appropriate data types and constraints
- Establish relationships using primary and foreign keys
- Alter and manage the schema using DDL commands

---

## 🎯 Learning Objectives

- Write `CREATE DATABASE` and `CREATE TABLE` statements
- Apply constraints: `PRIMARY KEY`, `FOREIGN KEY`, `NOT NULL`, `UNIQUE`, `DEFAULT`, `CHECK`
- Use `ALTER TABLE` to add, modify, and drop columns and constraints
- Understand **entity relationships** and design an **Entity-Relationship (ER) model**
- Normalize the schema to at least **3rd Normal Form (3NF)**

---

## 🗃️ Database Schema

### Tables Overview

| Table Name        | Description                                              |
|-------------------|----------------------------------------------------------|
| `categories`      | Book genres/categories (e.g., Fiction, Science)          |
| `authors`         | Author details                                           |
| `books`           | Book catalog with pricing and stock info                 |
| `book_authors`    | Junction table — Many-to-Many between books and authors  |
| `customers`       | Registered customer information                          |
| `orders`          | Customer orders                                          |
| `order_items`     | Line items for each order (books in an order)            |
| `payments`        | Payment records linked to orders                         |
| `delivery_agents` | Delivery agent details                                   |
| `deliveries`      | Delivery tracking per order                              |

---

## 🏗️ Entity-Relationship Summary

```
CATEGORIES ──< BOOKS >── BOOK_AUTHORS >── AUTHORS
                │
                ▼
           ORDER_ITEMS
                │
           ORDERS ──── PAYMENTS
                │
           DELIVERIES ──── DELIVERY_AGENTS
                │
           CUSTOMERS
```

---

## 📂 Project Structure

```
Practice-Set-1-BMS/
│
├── README.md                  # Project documentation (this file)
├── schema/
│   ├── 01_create_database.sql # Database creation
│   ├── 02_create_tables.sql   # All CREATE TABLE statements
│   ├── 03_alter_tables.sql    # ALTER TABLE modifications
│   └── 04_drop_cleanup.sql    # DROP statements for cleanup
├── erd/
│   └── bms_erd_diagram.png    # ER Diagram image
└── sample_data/
    └── insert_sample_data.sql # Optional DML sample inserts
```

---

## 🛠️ DDL Queries

### 1. Create Database

```sql
CREATE DATABASE IF NOT EXISTS OnlineBookstoreDB;
USE OnlineBookstoreDB;
```

---

### 2. Categories Table

```sql
CREATE TABLE categories (
    category_id   INT           AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100)  NOT NULL UNIQUE,
    description   TEXT
);
```

---

### 3. Authors Table

```sql
CREATE TABLE authors (
    author_id   INT          AUTO_INCREMENT PRIMARY KEY,
    first_name  VARCHAR(100) NOT NULL,
    last_name   VARCHAR(100) NOT NULL,
    email       VARCHAR(150) UNIQUE,
    bio         TEXT,
    created_at  TIMESTAMP    DEFAULT CURRENT_TIMESTAMP
);
```

---

### 4. Books Table

```sql
CREATE TABLE books (
    book_id       INT             AUTO_INCREMENT PRIMARY KEY,
    title         VARCHAR(255)    NOT NULL,
    isbn          VARCHAR(20)     NOT NULL UNIQUE,
    category_id   INT,
    price         DECIMAL(10, 2)  NOT NULL CHECK (price >= 0),
    stock_qty     INT             NOT NULL DEFAULT 0 CHECK (stock_qty >= 0),
    published_date DATE,
    publisher     VARCHAR(150),
    created_at    TIMESTAMP       DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_book_category
        FOREIGN KEY (category_id) REFERENCES categories(category_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);
```

---

### 5. Book–Authors Junction Table (Many-to-Many)

```sql
CREATE TABLE book_authors (
    book_id   INT NOT NULL,
    author_id INT NOT NULL,

    PRIMARY KEY (book_id, author_id),

    CONSTRAINT fk_ba_book
        FOREIGN KEY (book_id) REFERENCES books(book_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_ba_author
        FOREIGN KEY (author_id) REFERENCES authors(author_id)
        ON DELETE CASCADE
);
```

---

### 6. Customers Table

```sql
CREATE TABLE customers (
    customer_id   INT          AUTO_INCREMENT PRIMARY KEY,
    first_name    VARCHAR(100) NOT NULL,
    last_name     VARCHAR(100) NOT NULL,
    email         VARCHAR(150) NOT NULL UNIQUE,
    phone         VARCHAR(20),
    address       TEXT,
    city          VARCHAR(100),
    country       VARCHAR(100) DEFAULT 'India',
    registered_at TIMESTAMP    DEFAULT CURRENT_TIMESTAMP
);
```

---

### 7. Orders Table

```sql
CREATE TABLE orders (
    order_id     INT            AUTO_INCREMENT PRIMARY KEY,
    customer_id  INT            NOT NULL,
    order_date   TIMESTAMP      DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10, 2) NOT NULL CHECK (total_amount >= 0),
    status       ENUM('Pending', 'Confirmed', 'Shipped', 'Delivered', 'Cancelled')
                               DEFAULT 'Pending',

    CONSTRAINT fk_order_customer
        FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);
```

---

### 8. Order Items Table

```sql
CREATE TABLE order_items (
    order_item_id INT            AUTO_INCREMENT PRIMARY KEY,
    order_id      INT            NOT NULL,
    book_id       INT            NOT NULL,
    quantity      INT            NOT NULL CHECK (quantity > 0),
    unit_price    DECIMAL(10, 2) NOT NULL CHECK (unit_price >= 0),

    CONSTRAINT fk_oi_order
        FOREIGN KEY (order_id) REFERENCES orders(order_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_oi_book
        FOREIGN KEY (book_id) REFERENCES books(book_id)
        ON DELETE RESTRICT
);
```

---

### 9. Payments Table

```sql
CREATE TABLE payments (
    payment_id     INT            AUTO_INCREMENT PRIMARY KEY,
    order_id       INT            NOT NULL UNIQUE,
    payment_date   TIMESTAMP      DEFAULT CURRENT_TIMESTAMP,
    amount         DECIMAL(10, 2) NOT NULL CHECK (amount >= 0),
    payment_method ENUM('Credit Card', 'Debit Card', 'UPI', 'Net Banking', 'COD')
                                  NOT NULL,
    payment_status ENUM('Pending', 'Completed', 'Failed', 'Refunded')
                                  DEFAULT 'Pending',

    CONSTRAINT fk_payment_order
        FOREIGN KEY (order_id) REFERENCES orders(order_id)
        ON DELETE CASCADE
);
```

---

### 10. Delivery Agents Table

```sql
CREATE TABLE delivery_agents (
    agent_id   INT          AUTO_INCREMENT PRIMARY KEY,
    full_name  VARCHAR(150) NOT NULL,
    phone      VARCHAR(20)  NOT NULL UNIQUE,
    vehicle_no VARCHAR(20),
    is_active  BOOLEAN      DEFAULT TRUE
);
```

---

### 11. Deliveries Table

```sql
CREATE TABLE deliveries (
    delivery_id       INT  AUTO_INCREMENT PRIMARY KEY,
    order_id          INT  NOT NULL UNIQUE,
    agent_id          INT,
    assigned_date     DATE,
    estimated_date    DATE,
    delivered_date    DATE,
    delivery_status   ENUM('Not Assigned', 'Assigned', 'In Transit', 'Delivered', 'Failed')
                           DEFAULT 'Not Assigned',
    tracking_number   VARCHAR(100) UNIQUE,

    CONSTRAINT fk_delivery_order
        FOREIGN KEY (order_id) REFERENCES orders(order_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_delivery_agent
        FOREIGN KEY (agent_id) REFERENCES delivery_agents(agent_id)
        ON DELETE SET NULL
);
```

---

## 🔧 ALTER TABLE Examples

```sql
-- Add a discount column to books
ALTER TABLE books
    ADD COLUMN discount DECIMAL(5, 2) DEFAULT 0.00 AFTER price;

-- Add a loyalty points column to customers
ALTER TABLE customers
    ADD COLUMN loyalty_points INT DEFAULT 0;

-- Modify the phone column length in customers
ALTER TABLE customers
    MODIFY COLUMN phone VARCHAR(15);

-- Add an index on order date for faster querying
ALTER TABLE orders
    ADD INDEX idx_order_date (order_date);

-- Add a column for agent rating
ALTER TABLE delivery_agents
    ADD COLUMN rating DECIMAL(3, 2) CHECK (rating BETWEEN 0 AND 5);

-- Rename a column (MySQL 8.0+)
ALTER TABLE books
    RENAME COLUMN stock_qty TO stock_quantity;

-- Drop a column
ALTER TABLE books
    DROP COLUMN discount;

-- Add a composite unique constraint
ALTER TABLE order_items
    ADD CONSTRAINT uq_order_book UNIQUE (order_id, book_id);
```

---

## 🗑️ DROP Statements (Cleanup)

```sql
-- Drop tables in correct order (child before parent)
DROP TABLE IF EXISTS deliveries;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS book_authors;
DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS delivery_agents;
DROP TABLE IF EXISTS authors;
DROP TABLE IF EXISTS categories;

-- Drop the database
DROP DATABASE IF EXISTS OnlineBookstoreDB;
```

---

## ✅ Constraints Summary

| Constraint      | Usage in This Project                                              |
|-----------------|--------------------------------------------------------------------|
| `PRIMARY KEY`   | Every table has a unique identifier                                |
| `FOREIGN KEY`   | Enforces referential integrity between related tables              |
| `NOT NULL`      | Critical fields like names, emails, prices cannot be empty         |
| `UNIQUE`        | ISBN, email, phone, tracking number must be distinct               |
| `DEFAULT`       | Sensible defaults for status, timestamps, stock, country           |
| `CHECK`         | Price ≥ 0, quantity > 0, rating between 0–5                       |
| `AUTO_INCREMENT`| Automatic ID generation for primary keys                           |
| `ON DELETE`     | CASCADE, SET NULL, RESTRICT — appropriate per relationship type    |
| `ON UPDATE`     | CASCADE to keep FK values in sync                                  |

---

## 📐 Normalization

This schema follows **3rd Normal Form (3NF)**:

- **1NF**: All columns are atomic; no repeating groups
- **2NF**: No partial dependencies — all non-key attributes depend on the full primary key
- **3NF**: No transitive dependencies — non-key attributes depend only on the primary key

The `book_authors` junction table resolves the **Many-to-Many** relationship between `books` and `authors`.

---

## 🚀 How to Run

1. Open **MySQL Workbench**, **DBeaver**, or your terminal with MySQL CLI.
2. Run the scripts in order:
   ```bash
   mysql -u root -p < schema/01_create_database.sql
   mysql -u root -p OnlineBookstoreDB < schema/02_create_tables.sql
   mysql -u root -p OnlineBookstoreDB < schema/03_alter_tables.sql
   ```
3. Optionally load sample data:
   ```bash
   mysql -u root -p OnlineBookstoreDB < sample_data/insert_sample_data.sql
   ```

---

## 🧠 Key Concepts Demonstrated

- Database design from requirements to schema
- Proper use of `ENUM` for status fields
- Junction/associative tables for M:N relationships
- Referential integrity with cascading rules
- Index creation for query optimization
- Schema evolution using `ALTER TABLE`

---

## 👤 Author

**[Your Name]**  
Course: Database Management Systems  
Assignment: Practice Set 1 — DDL  
Submission Date: _____________

---

## 📜 License

This project is for academic/educational purposes only.
