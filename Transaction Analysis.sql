SELECT u.UserID, u.FirstName, u.LastName, SUM(a.Balance) AS TotalBalance
FROM Users u
JOIN Accounts a ON u.UserID = a.UserID
GROUP BY u.UserID, u.FirstName, u.LastName;

SELECT 
    AccountID,
    YEAR(TransactionDate) AS Year,
    MONTH(TransactionDate) AS Month,
    SUM(CASE WHEN TransactionType = 'Credit' THEN Amount ELSE 0 END) AS Total_Credits,
    SUM(CASE WHEN TransactionType = 'Debit' THEN -Amount ELSE 0 END) AS Total_Debits,
    SUM(CASE WHEN TransactionType = 'Credit' THEN Amount ELSE 0 END) +
    SUM(CASE WHEN TransactionType = 'Debit' THEN Amount ELSE 0 END) AS Net_Amount
FROM 
    Transactions
GROUP BY 
    AccountID, 
    YEAR(TransactionDate), 
    MONTH(TransactionDate)
ORDER BY 
    AccountID, 
    Year, 
    Month;

SELECT TransactionType, AVG(Amount) AS AverageAmount
FROM Transactions
GROUP BY TransactionType;

SELECT u.UserID, u.FirstName, u.LastName, SUM(t.Amount) AS TotalTransactionVolume
FROM Users u
JOIN Accounts a ON u.UserID = a.UserID
JOIN Transactions t ON a.AccountID = t.AccountID
GROUP BY u.UserID, u.FirstName, u.LastName
ORDER BY TotalTransactionVolume DESC
LIMIT 10;
