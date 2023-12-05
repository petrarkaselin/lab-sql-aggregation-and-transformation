use sakila;

-- Challenge 1
-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
select min(length) as min_duration, max(length) as max_duration
from film;

-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals. 
select concat(floor(avg(length) / 60), ' hours ',
       round(avg(length) % 60), ' minutes')
       as average_duration
from film;

-- 2.1. Calculate the number of days that the company has been operating.
select datediff(max(rental_date), min(rental_date)) as operating_dates from rental;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
select * from rental;
select rental_id, monthname(rental_date) as month, dayname(rental_date) as weekday from rental;

-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
select rental_id,
case
when dayname(rental_date) in ('SATURDAY', 'SUNDAY') then 'weekend'
else 'workday'
end as 'DAY_TYPE'
from rental;

-- 3. Retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
select title, ifnull(length, 'Not Available') as duration
from film
order by title;

-- Bonus. retrieve the concatenated first and last names of customers, along with the first 3 characters of their email address, 
-- so that you can address them by their first name and use their email address to send personalized recommendations. 
-- The results should be ordered by last name in ascending order to make it easier to use the data. 

select concat(last_name, ', ',first_name, ' ',  left(email, 3)) 
from customer
order by last_name;

-- Challenge 2

-- 1.1 The total number of films that have been released.
select count(*) from film;

-- 1.2 The number of films for each rating.
select rating, count(film_id) as number_of_films from film
group by rating;

-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films. 
select rating, count(film_id) as number_of_films from film
group by rating
order by count(film_id) desc;

-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. 
	-- Round off the average lengths to two decimal places.
select rating, round(avg(length), 2) as average_duration
from film
group by rating
order by average_duration desc;

-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
select rating, avg(length) as average_duration
from film
group by rating
having average_duration >= 120;

-- Bonus: determine which last names are not repeated in the table actor.
select last_name from actor
group by last_name
having count(last_name) = 1;


