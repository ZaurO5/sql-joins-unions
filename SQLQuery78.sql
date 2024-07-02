CREATE TABLE Sellers (
    Id INT PRIMARY KEY,
    Name VARCHAR(50),
    Surname VARCHAR(50),
    City VARCHAR(50)
);

CREATE TABLE Customers (
    Id INT PRIMARY KEY,
    Name VARCHAR(50),
    Surname VARCHAR(50),
    City VARCHAR(50)
);

CREATE TABLE Orders (
    Id INT PRIMARY KEY,
    OrderDate DATE,
    Amount DECIMAL(10, 2),
    State VARCHAR(50),
    SellerId INT,
    CustomerId INT,
    FOREIGN KEY (SellerId) REFERENCES Sellers(Id),
    FOREIGN KEY (CustomerId) REFERENCES Customers(Id)
);

SELECT Customers.Id, Customers.Name, Customers.Surname, SUM(Orders.Amount) AS TotalAmount
FROM Customers
JOIN Orders ON Customers.Id = Orders.CustomerId
GROUP BY Customers.Id, Customers.Name, Customers.Surname
HAVING SUM(Orders.Amount) > 1000;

SELECT DISTINCT Customers.Name AS CustomerName, Customers.Surname AS CustomerSurname, Sellers.Name AS SellerName, Sellers.Surname AS SellerSurname, Customers.City
FROM Customers
JOIN Sellers ON Customers.City = Sellers.City;

SELECT * FROM Orders
WHERE OrderDate >= '2024-01-04' AND State = 'Tamamlanib';

SELECT Sellers.Id, Sellers.Name, Sellers.Surname, COUNT(Orders.Id) AS CompletedOrders
FROM Sellers
JOIN Orders ON Sellers.Id = Orders.SellerId
WHERE Orders.State = 'Tamamlanib'
GROUP BY Sellers.Id, Sellers.Name, Sellers.Surname
HAVING COUNT(Orders.Id) > 10;

SELECT Customers.Id, Customers.Name, Customers.Surname, COUNT(Orders.Id) AS OrderCount
FROM Customers
JOIN Orders ON Customers.Id = Orders.CustomerId
GROUP BY Customers.Id, Customers.Name, Customers.Surname
ORDER BY OrderCount DESC;

SELECT Orders.OrderDate, Orders.Id, Sellers.Name, Sellers.Surname, Sellers.City
FROM Orders
JOIN Sellers ON Orders.SellerId = Sellers.Id
WHERE Orders.State != 'Tamamlanib'
ORDER BY Orders.OrderDate ASC;

