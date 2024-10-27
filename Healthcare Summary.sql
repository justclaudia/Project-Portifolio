-- Monthly Visit and Payment Summary
SELECT 
    YEAR(VisitDate) AS Year,
    MONTH(VisitDate) AS Month,
    COUNT(V.VisitID) AS Total_Visits,
    SUM(P.AmountPaid) AS Total_Payments
FROM 
    Visits V
JOIN 
    Payments P ON V.VisitID = P.VisitID
GROUP BY 
    YEAR(VisitDate), MONTH(VisitDate)
ORDER BY 
    Year, Month;
-- Total Treatment Costs per Patient
SELECT 
    p.FirstName,
    p.LastName,
    SUM(t.Cost) AS TotalTreatmentCost
FROM 
    Patients p
JOIN 
    Visits v ON p.PatientID = v.PatientID
JOIN 
    Treatments t ON v.VisitID = t.VisitID
GROUP BY 
    p.PatientID, p.FirstName, p.LastName
ORDER BY 
    TotalTreatmentCost DESC;

-- Monthly Payment Summary
SELECT 
    DATE_FORMAT(p.PaymentDate, '%Y-%m') AS Month,
    SUM(p.AmountPaid) AS TotalPayments
FROM 
    Payments p
GROUP BY 
    Month
ORDER BY 
    Month;
