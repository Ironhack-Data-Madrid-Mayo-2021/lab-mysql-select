USE publications;

SELECT authors.au_id, au_fname, au_lname, title_id
FROM authors
RIGHT JOIN titleauthor
ON authors.au_id = titleauthor.au_id;

SELECT title, title_id, publishers.pub_id
FROM titles
LEFT JOIN publishers
ON titles.pub_id = publishers.pub_id;

# Resolución primer challenge
SELECT authors.au_id AS "AUTHOR ID", au_fname AS "FIRST NAME", au_lname AS "LAST NAME", title AS TITLE, pub_name AS "PUBLISHER"
FROM titleauthor
LEFT JOIN authors
ON titleauthor.au_id = authors.au_id
LEFT JOIN titles
ON titleauthor.title_id = titles.title_id
LEFT JOIN publishers
ON titles.pub_id = publishers.pub_id;


# Verificación 1er challenge
SELECT COUNT(au_id)
FROM titleauthor;

# 2do challenge
SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

SELECT authors.au_id AS "AUTHOR ID", au_fname AS "FIRST NAME", au_lname AS "LAST NAME", pub_name AS "PUBLISHER", COUNT(title) AS "TITLE COUNT"
FROM titleauthor
LEFT JOIN authors
ON titleauthor.au_id = authors.au_id
LEFT JOIN titles
ON titleauthor.title_id = titles.title_id
LEFT JOIN publishers
ON titles.pub_id = publishers.pub_id
GROUP BY authors.au_id, publisher
ORDER BY authors.au_id DESC;

# 3er challenge

SELECT *
FROM sales;

SELECT authors.au_id AS "AUTHOR ID", au_fname AS "FIRST NAME", au_lname AS "LAST NAME", SUM(qty) AS "TOTAL"
FROM titleauthor
LEFT JOIN authors
ON titleauthor.au_id = authors.au_id
LEFT JOIN sales
ON titleauthor.title_id = sales.title_id
GROUP BY authors.au_id
ORDER BY SUM(qty) DESC
LIMIT 3;

# 4to challenge

SELECT authors.au_id AS "AUTHOR ID", au_fname AS "FIRST NAME", au_lname AS "LAST NAME",  IFNULL(SUM(qty), 0) AS "TOTAL"
FROM titleauthor
RIGHT JOIN authors
ON titleauthor.au_id = authors.au_id
LEFT JOIN sales
ON titleauthor.title_id = sales.title_id
GROUP BY authors.au_id
ORDER BY SUM(qty) DESC;

# Bonus
SELECT authors.au_id AS "AUTHOR ID", au_lname "LAST NAME", au_fname AS "FIRST NAME",SUM(advance * (royaltyper/100) + qty * price * (royaltyper/100) * (royalty/100)) AS PROFIT
FROM authors
LEFT JOIN titleauthor
ON authors.au_id = titleauthor.au_id
LEFT JOIN titles
ON titleauthor.title_id = titles.title_id
LEFT JOIN sales
ON titles.title_id = sales.title_id
GROUP BY authors.au_id
ORDER BY PROFIT DESC
LIMIT 3;
 