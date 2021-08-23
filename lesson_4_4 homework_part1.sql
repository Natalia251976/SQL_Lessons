схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing


Начало 1 части  ДЗ №4

--task10 (lesson4)
-- Компьютерная фирма: На базе products_price_categories_with_makers
-- по строить по каждому производителю график (X: category_price, Y: count)

select category_price, count_1 from products_price_categories_with_makers_2 where maker = 'A'

select category_price, count_1 from products_price_categories_with_makers_2 where maker = 'B'

select category_price, count_1 from products_price_categories_with_makers_2 where maker = 'C'

select category_price, count_1 from products_price_categories_with_makers_2 where maker = 'D'

select category_price, count_1 from products_price_categories_with_makers_2 where maker = 'E'

--task11 (lesson4)
-- Компьютерная фирма: На базе products_price_categories_with_makers 
--по строить по A & D график (X: category_price, Y: count)

select category_price, maker, count_1 from products_price_categories_with_makers_2 where maker = 'A'
union 
select category_price, maker, count_1 from products_price_categories_with_makers_2 where maker = 'D'

--task12 (lesson4)
-- Корабли: Сделать копию таблицы ships, но у название корабля не должно начинаться с буквы N (ships_without_n)
create table ships_without_n_1 as
select * from ships WHERE name not LIKE 'N%' ;

select * from ships_without_n_1
--task13 (lesson3)
--Компьютерная фирма: Вывести список всех продуктов и производителя с
-- указанием типа продукта (pc, printer, laptop). Вывести: model, maker, type

select product.model, product.maker, product.type 
from product join laptop on product.model = laptop.model 
union 
select product.model, product.maker, product.type 
from product join pc on product.model = pc.model 
union 
select product.model, product.maker, product.type
from product join printer on product.model = printer.model

--task14 (lesson3)
--Компьютерная фирма: При выводе всех значений из таблицы printer дополнительно вывести для тех, 
--у кого цена вышей средней PC - "1", у остальных - "0"
select *, 
case 
	when price > (select avg(price) from pc)
	then 1 
	else 0
end flag 
from printer

--task15 (lesson3)
--Корабли: Вывести список кораблей, у которых class отсутствует (IS NULL)
select * 
from ships 
where class is null  

--task16 (lesson3)
--Корабли: Укажите сражения, которые произошли в годы,
-- не совпадающие ни с одним из годов спуска кораблей на воду. 
--эту домашку должны разобрать, т.к. работа с датой не давалась

--task17 (lesson3)
--Корабли: Найдите сражения, в которых участвовали корабли класса Kongo из таблицы Ships.

select battle
from 
((select *
from battles 
join outcomes on outcomes.battle=battles.name) b1
join ships on b1.ship = ships.name)
where ships.class='Kongo'

--task1  (lesson4)
-- Компьютерная фирма: Сделать view (название all_products_flag_300) для всех товаров 
-- (pc, printer, laptop) с флагом, если стоимость больше > 300. Во view три колонки: model, price, flag


create view all_product_flag_300_1 as 
select *,
case 
	when price > 300 then 1
	else 0 
end flag
from all_product

select*
from all_product_flag_300_1

--task2  (lesson4)
-- Компьютерная фирма: Сделать view (название all_products_flag_avg_price) 
--для всех товаров (pc, printer, laptop) с флагом, если стоимость больше cредней .
-- Во view три колонки: model, price, flag
select avg(price) from all_product 


create view all_product_flag_avg_price_2 as 
select *,
case 
	when price > (select avg(price) from all_product) then 1
	else 0 
end flag
from all_product 

select *
from all_product_flag_avg_price_2

--task3  (lesson4)
-- Компьютерная фирма: Вывести все принтеры производителя = 'A' 
--со стоимостью выше средней по принтерам производителя = 'D' и 'C'. Вывести model

select *
from printer 
join product 
on product.model = printer.model 
where maker = 'A'
and 
price > 
(
	select avg(price) 
	from printer 
	join product 
	on product.model = printer.model 
	where maker not LIKE 'A%'
)

конец 1 части дз№4
