-- From the Chinook Database, I want to get / display 3 columns 
--Namely the Album Name, Artist Name, and Song / Track Title
--With the provision of
--• BAND Aerosmith
--• BAND AC / DC
--• Where for BAND AC / DC Display Album Name is Let There Be Rock.
WITH
m1 as
(
	Select *
	from artists 
	WHERE name = "AC/DC" OR name = "Aerosmith"
),
m2 as
(
	SELECT AlbumId, name as tracks 
	from tracks
)
SELECT 
	a.Title as Title,
	m1.name,
	m2.tracks
from albums a
JOIN m1 on a.ArtistId = m1.ArtistId
JOIN m2 on a.AlbumId = m2.AlbumId
WHERE Title = "Let There Be Rock" OR name = "Aerosmith"
LIMIT 15;

-- tim sales want to know how is performance daily our sales track at all oulets 
-- daily
SELECT date(i.InvoiceDate) as Invoice_Date, count(it.Quantity) as total_trx, sum(i.total) as total_sales
from invoices i
join invoice_items it 
on i.InvoiceId = it.InvoiceId
group by i.InvoiceId 
order by 1;

--The team also wants find out how interest in the genre on each city track purchases.

select BillingCity,Genre 
from
(
	SELECT
		i.BillingCity,
		g.Name as genre,
		sum(it.Quantity) as total_quantity,
		sum(it.Quantity*it.UnitPrice) as total_value,
		rank() OVER(PARTITION by BillingCity ORDER BY sum(it.Quantity*it.UnitPrice) DESC) ranking
	FROM invoices i
	JOIN invoice_items it on i.InvoiceId = it.InvoiceId
	JOIN tracks t on it.TrackId = t.TrackId
	JOIN genres g on t.GenreId = g.GenreId
	GROUP BY 1,2
	ORDER BY 1 ASC, 4 DESC
) sq
WHERE ranking = 1;
