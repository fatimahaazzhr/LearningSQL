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