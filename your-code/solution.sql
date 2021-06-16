SELECT au_id, au_lname, au_fname 
FROM authors
SELECT au_fname, (select count(*) from authors), [au_id], [contract]
FROM authors