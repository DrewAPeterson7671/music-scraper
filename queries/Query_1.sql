select * from albums limit 10;
select * from artists limit 10;

select * from albums where mp3_only = true and album_queue = 'MP3Album' and listen = 'Now';
select * from albums where mp3_only = true and album_queue = 'MP3Album' and listen = 'Later';
update albums set listen = 'Now' where mp3_only = true and album_queue = 'MP3Album' and listen = 'Later';

select * from albums where album_queue = 'MP3Album' and listen = 'Done';
update albums set listen = 'Now' where id = 124;

update albums set listen = 'Done' where id in ();
update albums set listen = 'Bonus Only MP3' where id in ();
update albums set album_type = 'Demo' where id in ();

SELECT artists.name, albums.*
FROM albums
JOIN artists ON albums.artist_id = artists.id
WHERE albums.mp3_only = true
  AND albums.album_queue = 'MP3Album'
  AND albums.listen = 'Now'
  order by artists.name;

Delete from albums where id = 316;
update albums set listen = 'In Apple Music' where id in ();

SELECT artists.name, albums.*
FROM albums
JOIN artists ON albums.artist_id = artists.id
WHERE albums.mp3_only = true
  AND albums.album_queue = 'MP3Album'
  AND albums.listen = 'In Apple Music'
  order by artists.name;

update albums set artist_id = 5872 where id = 432;

select * from annual_ranks limit 10;

Select * from annual_ranks where year = 1983 and source not in ('Billboard','KROQ-1', 'KROQ') order by rank;
select * from annual_ranks where year = 1983 and source = 'KROQ' order by rank;

select distinct source from annual_ranks;

UPDATE annual_ranks
SET type = 'CollectionRank'
WHERE source IN (
  'Y100 collection','WLIR collection','Q101-Collection Party Songs','Test','KROQ-Collection','KROQ-Collection 90s','Live105-Collection 90s','91X-Collection','WOXY collection','FRED XM 44 collection Top 2000','WFNX collection','Q101-Collection','WJFS collection 90s','WLIR collection 80s','WFNX collection 80s','KNDD The End Seattle collection','Live105-Collection','KNDD The End Seattle collection Top 1077','CD101 collection Top 2000'
);

select count(*) from annual_ranks where type = 'CollectionRank';
select count(*) from annual_ranks;
select count(*) from annual_ranks where type is null;



