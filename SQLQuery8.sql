-- ### Query su singola tabella

-- 1
SELECT * 
FROM software_houses
WHERE country = 'United States';

-- 2
SELECT * 
FROM players
WHERE city = 'Rogahnland';

-- 3 
SELECT * 
FROM players
WHERE name LIKE '%a';

-- 4 
SELECT *
FROM reviews 
WHERE player_id = 800;

-- 5 
SELECT *
FROM tournaments
WHERE year = 2015;

-- 6
SELECT *
FROM awards
WHERE description LIKE '%facere%';

-- 7 
SELECT DISTINCT videogame_id
FROM category_videogame
WHERE category_id = 2
OR  category_id = 6;

-- 8 
SELECT *
FROM reviews
WHERE rating >= 2
AND rating <= 4;

-- 9
SELECT *
FROM videogames
WHERE DATEPART(YEAR, release_date) = 2020;

-- 10
SELECT DISTINCT videogame_id
FROM reviews
WHERE rating = 5;

-- *********** BONUS ***********

-- 11
SELECT COUNT(id) as review_number, AVG(rating) as avg_rating
FROM reviews
WHERE videogame_id = 412;

-- 12
SELECT COUNT(id) as videogames_count
FROM videogames
WHERE software_house_id = 1
AND DATEPART(YEAR, release_date) = 2018;


-- ### Query con group by

-- 1
SELECT country, COUNT(id) as number_software_house
FROM software_houses
GROUP BY country;

-- 2 
SELECT videogame_id, COUNT(videogame_id) as number_reviews
FROM reviews
GROUP BY videogame_id;

-- 3 
SELECT pegi_label_id, COUNT(DISTINCT videogame_id) as number_games
FROM pegi_label_videogame
GROUP BY pegi_label_id;

-- 4
SELECT YEAR(release_date) as year, COUNT(id) as number_videogames
FROM videogames
GROUP BY YEAR(release_date);

-- 5 
SELECT device_id, COUNT(videogame_id) as number_videogames
FROM device_videogame
GROUP BY device_id;

-- 6 
SELECT videogame_id, AVG(rating) as avg_rating
FROM reviews
GROUP BY videogame_id
ORDER BY avg_rating;

-- ### Query con join

-- 1
SELECT DISTINCT player_id, players.name, players.nickname, players.city
FROM reviews
INNER JOIN players 
ON players.id = reviews.player_id;

-- 2
--SELECT tournament_videogame.videogame_id
--FROM tournaments
--INNER JOIN tournament_videogame
--ON tournament_videogame.tournament_id = tournaments.id
--WHERE tournaments.year = 2016
--GROUP BY tournament_videogame.videogame_id;
SELECT DISTINCT tournament_videogame.videogame_id
FROM tournaments
INNER JOIN tournament_videogame
ON tournament_videogame.tournament_id = tournaments.id
WHERE tournaments.year = 2016;

-- 3
SELECT videogame_id, category_id, categories.name, categories.description
FROM category_videogame
INNER JOIN categories
ON categories.id = category_videogame.category_id
ORDER BY videogame_id, categories.id;

-- 4
SELECT DISTINCT software_houses.*
FROM software_houses
INNER JOIN videogames 
ON software_houses.id = videogames.software_house_id
WHERE YEAR(videogames.release_date) > 2020;

-- 5
SELECT software_houses.id, software_houses.name as software_house_name, 
videogames.id as videogame_id, videogames.name as videogames_name,
awards.name as award_name
FROM software_houses
INNER JOIN videogames 
ON software_houses.id = videogames.software_house_id
INNER JOIN award_videogame
ON award_videogame.videogame_id = videogames.id
INNER JOIN awards 
ON awards.id = award_videogame.award_id
ORDER BY software_houses.id, videogames.id;

-- 6
SELECT DISTINCT categories.id, categories.name, pegi_labels.id, pegi_labels.name
FROM videogames 
JOIN reviews 
ON reviews.videogame_id = videogames.id
JOIN category_videogame 
ON category_videogame.videogame_id = videogames.id
JOIN categories
ON categories.id = category_videogame.category_id
JOIN pegi_label_videogame 
ON pegi_label_videogame.videogame_id = videogames.id
JOIN pegi_labels
ON pegi_labels.id = pegi_label_videogame.pegi_label_id
WHERE reviews.rating IN (4, 5);

-- 7
SELECT DISTINCT videogames.id, videogames.name
FROM tournaments
JOIN player_tournament 
ON player_tournament.tournament_id = tournaments.id
JOIN players 
ON player_tournament .player_id = players.id
JOIN tournament_videogame 
ON  tournament_videogame.tournament_id = tournaments.id
JOIN videogames 
ON videogames.id = tournament_videogame.videogame_id
WHERE players.name LIKE 'S%';

-- 8
SELECT DISTINCT tournaments.city
FROM tournaments
JOIN tournament_videogame
ON tournament_videogame.tournament_id = tournaments.id
JOIN videogames 
ON videogames.id = tournament_videogame.videogame_id
WHERE YEAR(release_date) = 2018;

