--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task1 (lesson5)
-- Компьютерная фирма: Сделать view (pages_all_products), в которой будет постраничная разбивка всех продуктов 
--(не более двух продуктов на одной странице). Вывод: все данные из laptop, номер страницы, список всех страниц

create view pages_all_products as
select code, 
rank () over (order by model) as rnk, 
dense_rank ()  over (order by model) as dense_rnk
from laptop

select * from pages_all_products

--task2 (lesson5)
-- Компьютерная фирма: Сделать view (distribution_by_type), в рамках которого будет процентное соотношение всех 
--товаров по типу устройства. Вывод: производитель,

create view temp_svod_2 as
select p.type, maker, p.model from product p join laptop l on p.model = l.model 
		union all 
		select p.type, maker, p.model from product p join pc l on p.model = l.model 
		union all 
		select p.type, maker, p.model from product p join printer l on p.model = l.model


create view distribution_by_type as
SELECT
    maker,
    round(cast(count(type) OVER (PARTITION BY model order by maker) AS numeric(3, 2))/(count(type) OVER (PARTITION BY maker)), 2) as count_type
FROM temp_svod_2

select * from distribution_by_type

--task3 (lesson5)
-- Компьютерная фирма: Сделать на базе предыдущенр view график - круговую диаграмму

--task4 (lesson5)
-- Корабли: Сделать копию таблицы ships (ships_two_words), но у название корабля должно состоять из двух слов

create table ships_two_words as
SELECT 
  split_part(name, ' ', 1) as first_name, 
  split_part(name, ' ', 2) as middle_name  
FROM ships 

--task5 (lesson5)
-- Корабли: Вывести список кораблей, у которых class отсутствует (IS NULL) и название начинается с буквы "S"

select *
from ships 
where class is null and name like 'S%'

--task6 (lesson5)
-- Компьютерная фирма: Вывести все принтеры производителя = 'A' со стоимостью выше средней по 
--принтерам производителя = 'C' и три самых дорогих (через оконные функции). Вывести model

-select * from
(
	select *, AVG(price) over (partition by maker='C' order by price desc) as rn 
	from (
		select price, maker, l.model from product p join printer l on p.model = l.model 
	) a 
) b 
where maker='A' limit 3


	
