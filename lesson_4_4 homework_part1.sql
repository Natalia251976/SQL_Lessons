����� ��: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing


������ 1 �����  �� �4

--task10 (lesson4)
-- ������������ �����: �� ���� products_price_categories_with_makers
-- �� ������� �� ������� ������������� ������ (X: category_price, Y: count)

select category_price, count_1 from products_price_categories_with_makers_2 where maker = 'A'

select category_price, count_1 from products_price_categories_with_makers_2 where maker = 'B'

select category_price, count_1 from products_price_categories_with_makers_2 where maker = 'C'

select category_price, count_1 from products_price_categories_with_makers_2 where maker = 'D'

select category_price, count_1 from products_price_categories_with_makers_2 where maker = 'E'

--task11 (lesson4)
-- ������������ �����: �� ���� products_price_categories_with_makers 
--�� ������� �� A & D ������ (X: category_price, Y: count)

select category_price, maker, count_1 from products_price_categories_with_makers_2 where maker = 'A'
union 
select category_price, maker, count_1 from products_price_categories_with_makers_2 where maker = 'D'

--task12 (lesson4)
-- �������: ������� ����� ������� ships, �� � �������� ������� �� ������ ���������� � ����� N (ships_without_n)
create table ships_without_n_1 as
select * from ships WHERE name not LIKE 'N%' ;

select * from ships_without_n_1
--task13 (lesson3)
--������������ �����: ������� ������ ���� ��������� � ������������� �
-- ��������� ���� �������� (pc, printer, laptop). �������: model, maker, type

select product.model, product.maker, product.type 
from product join laptop on product.model = laptop.model 
union 
select product.model, product.maker, product.type 
from product join pc on product.model = pc.model 
union 
select product.model, product.maker, product.type
from product join printer on product.model = printer.model

--task14 (lesson3)
--������������ �����: ��� ������ ���� �������� �� ������� printer ������������� ������� ��� ���, 
--� ���� ���� ����� ������� PC - "1", � ��������� - "0"
select *, 
case 
	when price > (select avg(price) from pc)
	then 1 
	else 0
end flag 
from printer

--task15 (lesson3)
--�������: ������� ������ ��������, � ������� class ����������� (IS NULL)
select * 
from ships 
where class is null  

--task16 (lesson3)
--�������: ������� ��������, ������� ��������� � ����,
-- �� ����������� �� � ����� �� ����� ������ �������� �� ����. 
--��� ������� ������ ���������, �.�. ������ � ����� �� ��������

--task17 (lesson3)
--�������: ������� ��������, � ������� ����������� ������� ������ Kongo �� ������� Ships.

select battle
from 
((select *
from battles 
join outcomes on outcomes.battle=battles.name) b1
join ships on b1.ship = ships.name)
where ships.class='Kongo'

--task1  (lesson4)
-- ������������ �����: ������� view (�������� all_products_flag_300) ��� ���� ������� 
-- (pc, printer, laptop) � ������, ���� ��������� ������ > 300. �� view ��� �������: model, price, flag


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
-- ������������ �����: ������� view (�������� all_products_flag_avg_price) 
--��� ���� ������� (pc, printer, laptop) � ������, ���� ��������� ������ c������ .
-- �� view ��� �������: model, price, flag
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
-- ������������ �����: ������� ��� �������� ������������� = 'A' 
--�� ���������� ���� ������� �� ��������� ������������� = 'D' � 'C'. ������� model

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

����� 1 ����� ��4
