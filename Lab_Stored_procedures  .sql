Lab | Stored procedures


select first_name, last_name, email
    from customer
    join rental on customer.customer_id = rental.customer_id
    join inventory on rental.inventory_id = inventory.inventory_id
    join film on film.film_id = inventory.film_id
    join film_category on film_category.film_id = film.film_id
    join category on category.category_id = film_category.category_id
    where category.name = "Action"
    group by first_name, last_name, email;
    
    DELIMITER //
create procedure fetching_name_email_by_genre(out param1 varchar(24) ,out param2 varchar(24), out param3 varchar(24) )
begin
	select first_name, last_name, email
    from customer
    join rental on customer.customer_id = rental.customer_id
    join inventory on rental.inventory_id = inventory.inventory_id
    join film on film.film_id = inventory.film_id
    join film_category on film_category.film_id = film.film_id
    join category on category.category_id = film_category.category_id
    where category.name = "Action"
    group by first_name, last_name, email;
end //
DELIMITER ;
call fetching_name_email_by_genre(@a, @b, @c);


  DELIMITER //
create procedure fetching_name_email_by_genreX(in param4 varchar(24), out param1 varchar(24) ,out param2 varchar(24), out param3 varchar(24) )
begin
	select first_name, last_name, email
    from customer
    join rental on customer.customer_id = rental.customer_id
    join inventory on rental.inventory_id = inventory.inventory_id
    join film on film.film_id = inventory.film_id
    join film_category on film_category.film_id = film.film_id
    join category on category.category_id = film_category.category_id
    where category.name = param4
    group by first_name, last_name, email;
end //
DELIMITER ;
call fetching_name_email_by_genreX('Children',@d, @e, @f);

#Write a query to check the number of movies released in each movie category. 
#Convert the query in to a stored procedure to filter only those categories that have movies released 
#greater than a certain number. Pass that number as an argument in the stored procedure.

select distinct(name) from sakila.category;

select count(film_id) from sakila.film_category
	join sakila.category using(category_id) 
    where category.name = 'Action'
    group by name;

# the next stored procedure, just for practice:
# the next aftewards is the solution 
  DELIMITER //
create procedure Count_Release_On_Genre(in param5 varchar(24))
begin
	select count(film_id) from sakila.film_category
	join sakila.category using(category_id) 
    where category.name = param5
    group by name;
end //
DELIMITER ;
call Count_Release_On_Genre('Action');



 DELIMITER //
create procedure Limt_Genre_On_Release(in param7 int)
begin
	select count(film_id), name from sakila.film_category
	join sakila.category using(category_id) 
    group by name
    having count(film_id) > param7;
end //
DELIMITER ;
call Limt_Genre_On_Release(60);
