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

### 2. Categories Table

### 3. Authors Table

### 4. Books Table
  
### 5. Book–Authors Junction Table (Many-to-Many)
  
### 6. Customers Table

### 7. Orders Table

### 8. Order Items Table

### 9. Payments Table

### 10. Delivery Agents Table

### 11. Deliveries Table

## 🔧 ALTER TABLE Examples

## 🗑️ DROP Statements (Cleanup)

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

## 🧠 Key Concepts Demonstrated

- Database design from requirements to schema
- Proper use of `ENUM` for status fields
- Junction/associative tables for M:N relationships
- Referential integrity with cascading rules
- Index creation for query optimization
- Schema evolution using `ALTER TABLE`

---

