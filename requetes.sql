-- SQL Bootcamp : base dvdrental (PostgreSQL)

-- Question : les 5 films PG les plus longs, dont le tarif de location est entre 2 et 3 $
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

-- Question : films jamais loués
SELECT film.film_id, film.title
FROM film
LEFT JOIN inventory ON film.film_id = inventory.film_id
LEFT JOIN rental ON inventory.inventory_id = rental.inventory_id
WHERE rental.rental_id IS NULL;

-- Question : toutes les langues avec leur nombre de films
SELECT language.name, COUNT(film.film_id)
FROM language
LEFT JOIN film
ON language.language_id = film.language_id
GROUP BY language.language_id;

-- Question : tous les films avec leur nombre d'exemplaires en stock, y compris ceux sans exemplaire
SELECT film.film_id, film.title, COUNT(inventory.inventory_id)
FROM film
LEFT JOIN inventory
ON film.film_id = inventory.film_id
GROUP BY film.film_id;

-- Question : tous les films avec leur nombre de locations, y compris ceux jamais loués
SELECT film.film_id, film.title, COUNT(rental.rental_id)
FROM film
LEFT JOIN inventory
ON film.film_id = inventory.film_id
LEFT JOIN rental
ON inventory.inventory_id = rental.inventory_id
GROUP BY film.film_id;

-- Question : catégories avec leur nombre de films, y compris sans film
SELECT category.category_id, category.name, COUNT(film.film_id)
FROM category
LEFT JOIN film_category
ON category.category_id = film_category.category_id
LEFT JOIN film
ON film_category.film_id = film.film_id
GROUP BY category.category_id;
