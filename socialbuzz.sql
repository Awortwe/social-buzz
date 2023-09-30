CREATE DATABASE IF NOT EXISTS socialbuzz;
USE socialbuzz;

CREATE TABLE IF NOT EXISTS content
(
content_id VARCHAR(100) PRIMARY KEY NOT NULL,
user_id VARCHAR(100) NOT NULL,
type VARCHAR(30) NOT NULL,
category VARCHAR(30) NOT NULL,
url VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS reaction
(
reaction_id INT PRIMARY KEY NOT NULL,
content_id VARCHAR(100) NOT NULL,
user_id VARCHAR(100) NOT NULL,
type VARCHAR(30) NOT NULL,
date_time DATETIME NOT NULL
);

CREATE TABLE IF NOT EXISTS reactiontype
(
type VARCHAR(30) PRIMARY KEY NOT NULL,
sentiment VARCHAR(30) NOT NULL,
score INT NOT NULL
);

SELECT count(DISTINCT category) FROM content;
UPDATE content 
SET category = REPLACE(category, '"', '')
WHERE category LIKE '%"%';

SELECT * FROM content;
SELECT * FROM reaction;
SELECT * FROM reactiontype;

-- cleaned dataset
SELECT c.content_id ContentId, c.type ContentType,
c.category ContentCategory, r.type ReactionType, r.date_time Date_Time,
rt.sentiment Sentiment, rt.score Score
from content c inner join reaction r
on c.content_id = r.content_id
inner join reactiontype rt
on rt.type = r.type;

-- top 5 categories
select c.category ContentCategory,
sum(rt.score)Score
from content c inner join reaction r
on c.content_id = r.content_id
inner join reactiontype rt
on rt.type = r.type
group by c.category
order by Score DESC
LIMIT 5;

select count(rt.type) from reactiontype rt
inner join reaction r on rt.type = r.type
inner join content c on c.content_id = r.content_id
group by c.category
having c.category = 'Animals';
