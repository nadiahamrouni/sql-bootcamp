-- SQL Bootcamp : base dvdrental (PostgreSQL)

-- Question : les 5 films PG les plus longs, loués entre 2 et 3 $
SELECT title, length, rental_rate
FROM film
WHERE rating = 'PG' AND rental_rate BETWEEN 2 AND 3
ORDER BY length DESC
LIMIT 5;

-- Question : clients ayant dépensé au moins 100 $
SELECT customer_id, SUM(amount) AS total
FROM payment
GROUP BY customer_id
HAVING SUM(amount) >= 100
ORDER BY total DESC;

-- Question : clients avec leur nombre de locations, y compris sans location
SELECT customer.customer_id, customer.first_name, customer.last_name,
       COUNT(rental.rental_id) AS nb_locations
FROM customer
LEFT JOIN rental ON customer.customer_id = rental.customer_id
GROUP BY customer.customer_id
ORDER BY nb_locations DESC;

-- Question : catégories avec leur nombre de films, y compris sans film
SELECT category.category_id, category.name,
       COUNT(film_category.film_id) AS nb_films
FROM category
LEFT JOIN film_category ON category.category_id = film_category.category_id
GROUP BY category.category_id;

-- Question : films jamais loués
SELECT film.film_id, film.title
FROM film
LEFT JOIN inventory ON film.film_id = inventory.film_id
LEFT JOIN rental ON inventory.inventory_id = rental.inventory_id
WHERE rental.rental_id IS NULL;
