CREATE VIEW CustomerSalesAnalysis1 AS
SELECT 
    c.CustomerID,
    c.FirstName || ' ' || c.LastName AS CustomerName,
    o.OrderID,
    o.OrderDate,
    od.ProductID,
    p.ProductName,
    od.Quantity,
    od.UnitPrice,
    (od.Quantity * od.UnitPrice) AS TotalPrice,
    s.SalesRepID,
    sr.FirstName || ' ' || sr.LastName AS SalesRepName,
    r.RegionName,
    pay.PaymentStatus
FROM 
    Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
JOIN Sales s ON o.OrderID = s.OrderID
JOIN SalesRep sr ON s.SalesRepID = sr.SalesRepID
JOIN Regions r ON c.RegionID = r.RegionID
JOIN Payments pay ON o.OrderID = pay.OrderID
WHERE 
    YEAR(o.OrderDate) = 2019;
