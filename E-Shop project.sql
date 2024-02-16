CREATE DATABASE OnlineShop;
USE OnlineShop;
-- Create the Customer table
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    PhoneNumber VARCHAR(20),
    Email VARCHAR(100),
    HouseNumber VARCHAR(10),
    StreetAddress VARCHAR(100),
    City VARCHAR(50),
    Postcode VARCHAR(20),
    Country VARCHAR(50)
);

-- Create the CreditCard table
CREATE TABLE CreditCard (
    CreditCardNumber VARCHAR(16) PRIMARY KEY,
    ExpiryDate DATE,
    CVC INT
);

-- Create the Department table
CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

-- Create the Product table
CREATE TABLE Product (
    ProductID INT PRIMARY KEY,
    Title VARCHAR(100),
    Description TEXT,
    UnitPrice DECIMAL(10, 2),
    ReleaseDate DATE,
    Language VARCHAR(50),
    Genre VARCHAR(50),
    ProductType VARCHAR(50)
);

-- Create the Employee table
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);

-- Create the Order table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    OrderDate DATE,
    CustomerID INT,
    CreditCardNumber VARCHAR(16),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (CreditCardNumber) REFERENCES CreditCard(CreditCardNumber)
);

-- Create the OrderProduct table for M:N relationship between Order and Product
CREATE TABLE OrderProduct (
    OrderID INT,
    ProductID INT,
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);


-- Insert data into the Customer table
INSERT INTO Customer (CustomerID, FirstName, LastName, PhoneNumber, Email, HouseNumber, StreetAddress, City, Postcode, Country)
VALUES
(1, 'Wale', 'Adelanwa', '1234567890', 'wale.adelanwa@example.com', '123', 'Main St', 'Lagos', '12345', 'Nigeria'),
(2, 'Victoria', 'Smith', '9876543210', 'victoria.smith@example.com', '456', 'Maple Ave', 'Manschester', '67890', 'United Kingdom'),
(3, 'Femi', 'Johnson', '5555555555', 'femi.j@example.com', '789', 'Oak St', 'Lagos', '54321', 'Nigeria'),
(4, 'Segun', 'Miller', '9998887777', 'bob.m@example.com', '321', 'Cedar Dr', 'Birmingham', '11223', 'United Kingdom'),
(5, 'Anna', 'Williams', '7771113333', 'anna.w@example.com', '654', 'Elm St', 'Silicon Valey', '99999', 'United States');

-- Insert data into the CreditCard table
INSERT INTO CreditCard (CreditCardNumber, ExpiryDate, CVC)
VALUES
('1111222233334444', '2023-12-31', 123),
('4444333322221111', '2024-06-30', 456),
('5555666677778888', '2022-09-30', 789),
('9999888877776666', '2023-04-30', 321),
('1234123412345678', '2024-02-28', 654);

-- Insert data into the Department table
INSERT INTO Department (DepartmentID, DepartmentName)
VALUES
(1, 'Deliveries'),
(2, 'Accounting'),
(3, 'Human Resources');

-- Insert data into the Product table
INSERT INTO Product (ProductID, Title, Description, UnitPrice, ReleaseDate, Language, Genre, ProductType)
VALUES
(1, 'Yellow', 'Great music album', 15.99, '2021-01-15', 'English', 'Rock', 'Music'),
(2, 'Tomorrow Never Dies', 'The exciting action movie', 9.99, '2020-05-20', 'English', 'Action', 'Movie'),
(3, 'Things Fall Apart', 'Best-selling novel', 12.99, '2019-08-10', 'English', 'Fiction', 'Book'),
(4, 'Originality', 'Classic jazz tunes', 18.99, '2022-03-05', 'English', 'Jazz', 'Music'),
(5, 'A tribe called Judah', 'Heartwarming drama', 14.99, '2023-11-12', 'English', 'Drama', 'Movie');

-- Insert data into the Employee table
INSERT INTO Employee (EmployeeID, FirstName, LastName, DepartmentID)
VALUES
(1, 'Mark', 'Johnson', 1),
(2, 'Emmanuel', 'Davis', 2),
(3, 'Solomon', 'Bayo', 3),
(4, 'Adesoji', 'Feyisayo', 1),
(5, 'Daniel', 'Olojo', 2);

-- Insert data into the Order table
INSERT INTO Orders (OrderID, OrderDate, CustomerID, CreditCardNumber)
VALUES
(1, '2023-01-05', 1, '1111222233334444'),
(2, '2023-03-15', 2, '4444333322221111'),
(3, '2023-05-20', 3, '5555666677778888'),
(4, '2023-07-10', 4, '9999888877776666'),
(5, '2023-10-02', 5, '1234123412345678');

-- Insert data into the OrderProduct table
INSERT INTO OrderProduct (OrderID, ProductID)
VALUES
(1, 1),
(1, 3),
(2, 2),
(3, 4),
(4, 5),
(5, 1),
(5, 2),
(5, 3);

-- Update the descriptions of products in the Product table
UPDATE Product SET Description = 'The latest music album with hits from various artists' WHERE ProductID = 1;
UPDATE Product SET Description = 'Intense sci-fi action movie with stunning visual effects' WHERE ProductID = 2;
UPDATE Product SET Description = 'The captivating mystery novel with unexpected twists' WHERE ProductID = 3;
UPDATE Product SET Description = 'Timeless collection of jazz classics performed by renowned artists' WHERE ProductID = 4;
UPDATE Product SET Description = 'Emotional drama film with powerful performances' WHERE ProductID = 5;

SELECT * FROM Customer WHERE City = 'Lagos';

SELECT * FROM Product WHERE Genre = 'Rock';

SELECT COUNT(*) AS CustomerCount FROM Customer WHERE City = 'Lagos';

SELECT AVG(UnitPrice) AS AverageUnitPrice FROM Product;

SELECT * FROM Orders WHERE OrderDate <= CURDATE();

SELECT O.* 
FROM Orders O
JOIN OrderProduct OP ON O.OrderID = OP.OrderID
JOIN Product P ON OP.ProductID = P.ProductID
WHERE P.ProductType = 'Book' AND P.Description LIKE '%the%';

SELECT O.*, CC.*
FROM Orders O
JOIN CreditCard CC ON O.CreditCardNumber = CC.CreditCardNumber
JOIN OrderProduct OP ON O.OrderID = OP.OrderID
JOIN Product P ON OP.ProductID = P.ProductID
WHERE P.ProductType = 'Music';

SELECT COUNT(DISTINCT E.EmployeeID) AS EmployeeCount
FROM Employee E
JOIN Department D ON E.DepartmentID = D.DepartmentID
JOIN Product P ON D.DepartmentName = 'Deliveries' AND P.Genre = 'Music';

SELECT COUNT(*) AS EmployeeCount
FROM Employee
WHERE FirstName LIKE 'S%';

SELECT COUNT(*) AS OrderCount FROM Orders;


