/*Top artists by album count:*/
SELECT Artist.Name, COUNT(Album.AlbumId) AS AlbumCount
FROM Artist
JOIN Album ON Artist.ArtistId = Album.ArtistId
GROUP BY Artist.ArtistId
ORDER BY AlbumCount DESC
LIMIT 10;

/*Top-selling tracks by revenue:*/
SELECT Track.Name AS TrackName, Artist.Name AS ArtistName,
       SUM(InvoiceLine.UnitPrice * InvoiceLine.Quantity) AS Revenue
FROM InvoiceLine
JOIN Track ON InvoiceLine.TrackId = Track.TrackId
JOIN Album ON Track.AlbumId = Album.AlbumId
JOIN Artist ON Album.ArtistId = Artist.ArtistId
GROUP BY Track.TrackId
ORDER BY Revenue DESC
LIMIT 10;

/*Top customers by spend:*/
SELECT Customer.CustomerId,
       Customer.FirstName || ' ' || Customer.LastName AS CustomerName,
       Customer.Country,
       SUM(Invoice.Total) AS TotalSpent
FROM Customer
JOIN Invoice ON Customer.CustomerId = Invoice.CustomerId
GROUP BY Customer.CustomerId
ORDER BY TotalSpent DESC
LIMIT 10;

/*Average invoice total per country:*/
SELECT BillingCountry AS Country,
       ROUND(AVG(Total), 2) AS AvgInvoiceTotal,
       COUNT(*) AS InvoiceCount
FROM Invoice
GROUP BY BillingCountry
ORDER BY AvgInvoiceTotal DESC;

/*Most popular genres by quantity sold:*/
SELECT Genre.Name AS GenreName,
       SUM(InvoiceLine.Quantity) AS QuantitySold,
       SUM(InvoiceLine.UnitPrice * InvoiceLine.Quantity) AS Revenue
FROM InvoiceLine
JOIN Track ON InvoiceLine.TrackId = Track.TrackId
JOIN Genre ON Track.GenreId = Genre.GenreId
GROUP BY Genre.GenreId
ORDER BY QuantitySold DESC;