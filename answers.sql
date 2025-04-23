-- Question 1
-- Create a new table in 1NF
CREATE TABLE OrderProducts_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(50)
);

-- Insert data in 1NF format
INSERT INTO OrderProducts_1NF (OrderID, CustomerName, Product)
VALUES 
    (101, 'Marks Abuto', 'Laptop'),
    (101, 'Marks Abuto', 'Mouse'),
    (102, 'Ceccy J', 'Tablet'),
    (102, 'Ceccy J', 'Keyboard'),
    (102, 'Ceccy J', 'Mouse'),
    (103, 'Tiffany Bella', 'Phone');


-- Question 2
-- Orders table (removing partial dependency)
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- OrderItems table for products
CREATE TABLE OrderItems (
    OrderID INT,
    Product VARCHAR(50),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Data into Orders table
INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName FROM OrderDetails;

-- Data into OrderItems table
INSERT INTO OrderItems (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity FROM OrderDetails;
