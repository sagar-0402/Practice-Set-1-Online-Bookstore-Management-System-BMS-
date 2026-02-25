-- Online Bookstore Management System(BMS)

CREATE DATABASE BMS;
USE BMS;

-- SECTION A: Table Creation and Basic Constraints

CREATE DATABASE OnlineBookstore;
USE OnlineBookstore;


-- Q1. Create a table Authors with the following attributes:
-- • AuthorID (Primary Key)
-- • Name (Required)
-- • Country
-- • Date of Birth (DOB)

CREATE TABLE Authors (
    AuthorID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Country VARCHAR(50),
    DOB DATE
);


-- Q2. Create a table Categories with:
-- • CategoryID (Primary Key)
-- • CategoryName (must be unique)

CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(100) UNIQUE
);


-- Q3. Create a table Books with these attributes:
-- • BookID (Primary Key)
-- • Title (must be unique)
-- • AuthorID (Foreign Key)
-- • CategoryID (Foreign Key)
-- • Price (must be > 0)
-- • Stock (must be >= 0)
-- • PublishedYear (Default to current year)

CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(200) UNIQUE,
    AuthorID INT,
    CategoryID INT,
    Price DECIMAL(10,2) CHECK (Price > 0),
    Stock INT CHECK (Stock >= 0),
    PublishedYear YEAR DEFAULT (YEAR(CURDATE())),
    CONSTRAINT fk_books_author FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID),
    CONSTRAINT fk_books_category FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);


-- Add appropriate foreign key constraints in Books referencing Authors and Categories.
-- Q5. Create a table Customers with:
-- • CustomerID (Primary Key)
-- • Name (Required)
-- • Email (must be unique)
-- • Phone
-- • Address

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(15),
    Address VARCHAR(255)
);


-- Q6. Add a CHECK constraint on the Phone column in Customers to ensure phone numbers start with 7, 8, or 9.

ALTER TABLE Customers
ADD CONSTRAINT chk_customer_phone
CHECK (Phone REGEXP '^[789]');


-- Q7. Modify the Phone column in Customers to make it NOT NULL.

ALTER TABLE Customers
MODIFY Phone VARCHAR(15) NOT NULL;


-- Q8. Add a new column DateOfBirth to Customers.

ALTER TABLE Customers
ADD DateOfBirth DATE;


-- Q9. Create a table Orders with:
-- • OrderID (Primary Key)
-- • CustomerID (Foreign Key)
-- • OrderDate
-- • Status (Default value: 'Pending')

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    Status VARCHAR(20) DEFAULT 'Pending',
    CONSTRAINT fk_orders_customer FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);


-- Q10. Create a table OrderDetails with:
-- • OrderID (Foreign Key)
-- • BookID (Foreign Key)
-- • Quantity (must be > 0)
-- • Price (must be > 0.01)
-- • Primary key should be a combination of OrderID and BookID

CREATE TABLE OrderDetails (
    OrderID INT,
    BookID INT,
    Quantity INT CHECK (Quantity > 0),
    Price DECIMAL(10,2) CHECK (Price > 0.01),
    PRIMARY KEY (OrderID, BookID),
    CONSTRAINT fk_od_order FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    CONSTRAINT fk_od_book FOREIGN KEY (BookID) REFERENCES Books(BookID)
);


-- Q11. Create a table Payments with:
-- • PaymentID (Primary Key)
-- • OrderID (Foreign Key)
-- • Amount
-- • PaymentDate
-- • Method (Default to 'Cash')
-- Q12. Create all necessary foreign key relationships in the tables above.

CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY,
    OrderID INT,
    Amount DECIMAL(10,2),
    PaymentDate DATE,
    Method VARCHAR(20) DEFAULT 'Cash',
    CONSTRAINT fk_payments_order FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);



-- SECTION B: Altering Tables and Adding Constraints

-- Q13. Add a CHECK constraint on the Price column of Books so it cannot exceed 10,000.

ALTER TABLE Books
ADD CONSTRAINT chk_books_price_max
CHECK (Price <= 10000);


-- Q14. Add a UNIQUE constraint to ISBN column in the Books table.

ALTER TABLE Books
ADD ISBN VARCHAR(20);


-- Q15. Add a new column ISBN to the Books table.

ALTER TABLE Books
ADD CONSTRAINT uq_books_isbn UNIQUE (ISBN);


-- Q16. Modify the Stock column in Books to be of type TINYINT.

ALTER TABLE Books
MODIFY Stock TINYINT;


-- Q17. Rename the column PublishedYear in Books to YearPublished.

ALTER TABLE Books
RENAME COLUMN PublishedYear TO YearPublished;


-- Q18. Drop the column DateOfBirth from the Customers table.

ALTER TABLE Customers
DROP COLUMN DateOfBirth;


-- Q19. Add a new column DeliveryAgentID in Orders referencing DeliveryAgents.

ALTER TABLE Orders
ADD AgentID INT,
ADD CONSTRAINT fk_orders_delivery
FOREIGN KEY (AgentID) REFERENCES DeliveryAgents(AgentID);


-- Q20. Drop the foreign key constraint from Orders referencing Customers.

ALTER TABLE Orders
DROP FOREIGN KEY fk_orders_customer;


-- Q21. Add a column Discount to OrderDetails with default value 0.

ALTER TABLE OrderDetails
ADD Discount DECIMAL(5,2) DEFAULT 0;


-- Q22. Drop the default value from the Discount column in OrderDetails.

ALTER TABLE OrderDetails
ALTER Discount DROP DEFAULT;


-- Q23. Drop the ISBN constraint from the Books table.

ALTER TABLE Books
DROP INDEX uq_books_isbn;


-- Q24. Drop the CHECK constraint on Price in the Books table.

ALTER TABLE Books
DROP CHECK chk_books_price_max;



-- SECTION C: Delivery Agents Table

-- Q33. Create a table DeliveryAgents with:
-- • AgentID (Primary Key)
-- • Name
-- • Phone (Unique)
-- • Region (must be one of: 'North', 'South', 'East', 'West')
-- • Default region should be 'North'

CREATE TABLE DeliveryAgents (
    AgentID INT PRIMARY KEY,
    Name VARCHAR(100),
    Phone VARCHAR(15) UNIQUE,
    Region VARCHAR(10) DEFAULT 'North',
    CHECK (Region IN ('North', 'South', 'East', 'West'))
);


-- Q34. Add an Email column (unique) to DeliveryAgents.

ALTER TABLE DeliveryAgents
ADD Email VARCHAR(100) UNIQUE;


-- Q35. Modify the Phone column in DeliveryAgents to type VARCHAR(10).

ALTER TABLE DeliveryAgents
MODIFY Phone VARCHAR(10);


-- Q36. Drop the Email column from DeliveryAgents.

ALTER TABLE DeliveryAgents
DROP COLUMN Email;


-- Q37. Rename the table DeliveryAgents to DeliveryTeam.

RENAME TABLE DeliveryAgents TO DeliveryTeam;


-- Q38. Rename the column Region to AssignedRegion in DeliveryTeam.

ALTER TABLE DeliveryTeam
RENAME COLUMN Region TO AssignedRegion;


-- Q39. Truncate the DeliveryTeam table (delete all rows).

TRUNCATE TABLE DeliveryTeam;


-- Q40. Drop the entire DeliveryTeam table.

DROP TABLE DeliveryTeam;


-- Q41. Truncate the Payments table.

TRUNCATE TABLE Payments;


-- Q42. Truncate the OrderDetails table.

TRUNCATE TABLE OrderDetails;


-- SECTION D: Dropping and Renaming

-- Q43. Drop the Payments table entirely.

DROP TABLE Payments;


-- Q44. Drop the DeliveryTeam table entirely.

DROP TABLE DeliveryTeam;


-- Q45. Rename the Books table to BookInventory.

RENAME TABLE Books TO BookInventory;


-- Q46. Rename the Customers table to Clients.

RENAME TABLE Customers TO Clients;


-- Q47. Rename the column Name in Clients to FullName.

ALTER TABLE Clients
RENAME COLUMN Name TO FullName;


-- Q48. Rename the column Title in BookInventory to BookTitle.

ALTER TABLE BookInventory
RENAME COLUMN Title TO BookTitle;


-- Q49. Rename the table BookInventory back to Books.

RENAME TABLE BookInventory TO Books;


-- Q50. Drop all foreign keys from OrderDetails referencing Orders and Books.

ALTER TABLE OrderDetails
DROP FOREIGN KEY fk_od_order;

ALTER TABLE OrderDetails
DROP FOREIGN KEY fk_od_book;


-- SECTION E: Views and Advanced Constraints

-- Q51. Create a VIEW called TopSellingBooks that shows:
-- • BookID
-- • Title
-- • Total quantity sold (from OrderDetails)

CREATE VIEW TopSellingBooks AS
SELECT 
    b.BookID,
    b.Title,
    SUM(od.Quantity) AS TotalQuantitySold
FROM Books b
JOIN OrderDetails od 
ON b.BookID = od.BookID
GROUP BY b.BookID, b.Title;


-- Q52. Add a DEFAULT constraint on Payments.Method to be 'Card'.

ALTER TABLE Payments
ALTER Method SET DEFAULT 'Card';


-- Q53. Create a table OrderNotes with a Note column having NOT NULL constraint.

CREATE TABLE OrderNotes (
    NoteID INT PRIMARY KEY,
    OrderID INT,
    Note TEXT NOT NULL,
    CONSTRAINT fk_ordernotes_order
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);


-- Q54. Drop the UNIQUE constraint on Books.ISBN.

ALTER TABLE Books
DROP INDEX uq_books_isbn;


-- Q55. Drop the CHECK constraint from Books.Price.

ALTER TABLE Books
DROP CHECK chk_books_price_max;



-- SECTION F: Real-World Scenarios

-- Q61. Create a table ReturnRequests with:
-- • ReturnID (Primary Key)
-- • OrderID (FK)
-- • Reason (VARCHAR)
-- • Status (default: 'Pending')

CREATE TABLE ReturnRequests (
    ReturnID INT PRIMARY KEY,
    OrderID INT,
    Reason VARCHAR(255),
    Status VARCHAR(20) DEFAULT 'Pending',
    CONSTRAINT fk_return_order
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);


-- Q62. Add ReturnDate to ReturnRequests.

ALTER TABLE ReturnRequests
ADD ReturnDate DATE;


-- Q63. Drop the ReturnDate column.

ALTER TABLE ReturnRequests
DROP COLUMN ReturnDate;


-- Q64. Add a FK from ReturnRequests to Orders.

ALTER TABLE ReturnRequests
ADD CONSTRAINT fk_return_order
FOREIGN KEY (OrderID) REFERENCES Orders(OrderID);


-- Q65. Drop the FK from ReturnRequests.

ALTER TABLE ReturnRequests
DROP FOREIGN KEY fk_return_order;


-- Q66. Create a table Wishlists with composite PK (CustomerID, BookID).

CREATE TABLE Wishlists (
    CustomerID INT,
    BookID INT,
    PRIMARY KEY (CustomerID, BookID),
    CONSTRAINT fk_wishlist_customer
    FOREIGN KEY (CustomerID) REFERENCES Clients(CustomerID),
    CONSTRAINT fk_wishlist_book
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);


-- Q67. Add DateAdded column to Wishlists.

ALTER TABLE Wishlists
ADD DateAdded DATE;


-- Q68. Drop the DateAdded column.

ALTER TABLE Wishlists
DROP COLUMN DateAdded;


-- Q69. Rename Wishlists to CustomerWishlists.

RENAME TABLE Wishlists TO CustomerWishlists;


-- Q70. Rename CustomerWishlists back to Wishlists.

RENAME TABLE CustomerWishlists TO Wishlists;


-- Q71–Q75. Perform any 5 meaningful renaming tasks using RENAME on tables or columns in your database.

RENAME TABLE Orders TO CustomerOrders;
RENAME TABLE CustomerOrders TO Orders;
ALTER TABLE Books
RENAME COLUMN Price TO BookPrice;
ALTER TABLE Books
RENAME COLUMN BookPrice TO Price;
ALTER TABLE Clients
RENAME COLUMN Email TO CustomerEmail;


-- SECTION G: Final Challenges

-- Q76. Drop the Books table completely.

DROP TABLE Books;


-- Q77. Recreate Books with same original schema.

CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(200) UNIQUE,
    AuthorID INT,
    CategoryID INT,
    Price DECIMAL(10,2) CHECK (Price > 0),
    Stock INT CHECK (Stock >= 0),
    PublishedYear YEAR DEFAULT (YEAR(CURDATE())),
    CONSTRAINT fk_books_author FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID),
    CONSTRAINT fk_books_category FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);


-- Q78. Add an Edition column to Books (default to 'First').

ALTER TABLE Books
ADD Edition VARCHAR(20) DEFAULT 'First';


-- Q79. Modify the Edition column to VARCHAR(50).

ALTER TABLE Books
MODIFY Edition VARCHAR(50) DEFAULT 'First';


-- Q80. Drop the Edition column.

ALTER TABLE Books
DROP COLUMN Edition;


-- Q81. Create a table DeliveryLogs with:
-- • LogID (PK)
-- • DeliveryAgentID (FK)
-- • Date
-- • Status

CREATE TABLE DeliveryLogs (
    LogID INT PRIMARY KEY,
    DeliveryAgentID INT,
    Date DATE,
    Status VARCHAR(20),
    CONSTRAINT fk_deliverylogs_agent
    FOREIGN KEY (DeliveryAgentID) REFERENCES DeliveryAgents(AgentID)
);


-- Q82. Add a Comments column to DeliveryLogs.

ALTER TABLE DeliveryLogs
ADD Comments TEXT;


-- Q83. Drop the Comments column.

ALTER TABLE DeliveryLogs
DROP COLUMN Comments;


-- Q84. Add a CHECK constraint on Status to accept only 'Delivered', 'Pending', 'Failed'.

ALTER TABLE DeliveryLogs
ADD CONSTRAINT chk_deliverylogs_status
CHECK (Status IN ('Delivered', 'Pending', 'Failed'));


-- Q85. Drop the CHECK constraint from DeliveryLogs.

ALTER TABLE DeliveryLogs
DROP CHECK chk_deliverylogs_status;


-- Q86. Add a column Rating to Books with a CHECK (1–5).

ALTER TABLE Books
ADD Rating INT,
ADD CONSTRAINT chk_books_rating
CHECK (Rating BETWEEN 1 AND 5);


-- Q87. Modify the Rating column to allow decimals.

ALTER TABLE Books
MODIFY Rating DECIMAL(2,1);

ALTER TABLE Books
ADD CONSTRAINT chk_books_rating_decimal
CHECK (Rating BETWEEN 1 AND 5);


-- Q88. Drop the Rating column.

ALTER TABLE Books
DROP COLUMN Rating;


-- Q89. Create a table BookReviews with ReviewID (PK), BookID (FK), CustomerID (FK), ReviewText.

CREATE TABLE BookReviews (
    ReviewID INT PRIMARY KEY,
    BookID INT,
    CustomerID INT,
    ReviewText TEXT,
    CONSTRAINT fk_review_book
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    CONSTRAINT fk_review_customer
    FOREIGN KEY (CustomerID) REFERENCES Clients(CustomerID)
);


-- Q90. Add a column Stars (1–5) with a CHECK constraint.

ALTER TABLE BookReviews
ADD Stars INT NOT NULL,
ADD CONSTRAINT chk_review_stars
CHECK (Stars BETWEEN 1 AND 5);


-- Q91. Modify Stars to be optional (remove NOT NULL).

ALTER TABLE BookReviews
MODIFY Stars INT NULL;


-- Q92. Drop the BookReviews table.

DROP TABLE BookReviews;


-- Q93. Recreate BookReviews with all columns and constraints again.

CREATE TABLE BookReviews (
    ReviewID INT PRIMARY KEY,
    BookID INT,
    CustomerID INT,
    ReviewText TEXT,
    Stars INT,
    CONSTRAINT fk_review_book
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    CONSTRAINT fk_review_customer
    FOREIGN KEY (CustomerID) REFERENCES Clients(CustomerID),
    CONSTRAINT chk_review_stars
    CHECK (Stars BETWEEN 1 AND 5)
);


-- Q94. Add FK from BookReviews to Customers and Books.

ALTER TABLE BookReviews
ADD CONSTRAINT fk_review_book
FOREIGN KEY (BookID) REFERENCES Books(BookID);

ALTER TABLE BookReviews
ADD CONSTRAINT fk_review_customer
FOREIGN KEY (CustomerID) REFERENCES Clients(CustomerID);


-- Q95. Drop FK from BookReviews.

ALTER TABLE BookReviews
DROP FOREIGN KEY fk_review_book;

ALTER TABLE BookReviews
DROP FOREIGN KEY fk_review_customer;


-- Q96. Drop BookReviews entirely.

DROP TABLE BookReviews;


-- Q97. Create a table Coupons with CouponID, Code (Unique), Discount (%), ExpiryDate.

CREATE TABLE Coupons (
    CouponID INT PRIMARY KEY,
    Code VARCHAR(50) UNIQUE,
    Discount DECIMAL(5,2),
    ExpiryDate DATE
);


-- Q98. Add Status column (default 'Active').

ALTER TABLE Coupons
ADD Status VARCHAR(20) DEFAULT 'Active';


-- Q99. Add a CHECK to ensure Discount is between 1 and 50.

ALTER TABLE Coupons
ADD CONSTRAINT chk_coupon_discount
CHECK (Discount BETWEEN 1 AND 50);


-- Q100. Drop all constraints from Coupons table.

ALTER TABLE Coupons
DROP INDEX Code;
ALTER TABLE Coupons
DROP CHECK chk_coupon_discount;