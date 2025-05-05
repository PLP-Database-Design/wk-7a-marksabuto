-- Question 1
-- Original table (violating 1NF)
CREATE TABLE ProductDetail (
    OrderID INT,
    CustomerName VARCHAR(100),
    Products VARCHAR(255)
);

-- Solution: Transform into 1NF by splitting multi-valued Products
SELECT 
    OrderID,
    CustomerName,
    TRIM(value) AS Product
FROM 
    ProductDetail
CROSS APPLY 
    STRING_SPLIT(Products, ',');

-- Alternative if STRING_SPLIT isn't available (SQL standard approach)
SELECT 101 AS OrderID, 'John Doe' AS CustomerName, 'Laptop' AS Product UNION ALL
SELECT 101, 'John Doe', 'Mouse' UNION ALL
SELECT 102, 'Jane Smith', 'Tablet' UNION ALL
SELECT 102, 'Jane Smith', 'Keyboard' UNION ALL
SELECT 102, 'Jane Smith', 'Mouse' UNION ALL
SELECT 103, 'Emily Clark', 'Phone';


-- Question 2
-- Original table (violating 2NF)
CREATE TABLE OrderDetails (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(50),
    Quantity INT,
    PRIMARY KEY (OrderID, Product)
);

-- Solution: Split into two tables to remove partial dependency

-- Table 1: Orders (contains order and customer information)
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Table 2: OrderItems (contains product details per order)
CREATE TABLE OrderItems (
    OrderID INT,
    Product VARCHAR(50),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Insert data into normalized tables
INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName FROM OrderDetails;

INSERT INTO OrderItems (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity FROM OrderDetails;
