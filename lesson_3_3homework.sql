

-����� ��: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--task1
--������������ �����: ������� ������� ���� ���� ���������, �������������� �� ��������������. 
--�����: ����, �������������

select maker, avg(price)
from
(
		select maker, price 
		from PC 
		join product
		on pc.model = product.model 
	union all
		select maker, price 
		from printer 
		join product
		on printer.model = product.model 
	union all
		select maker, price 
		from laptop 
		join product
		on laptop.model = product.model
)  a
group by maker


-task2
--�������: ������� ������ ��������, � ������� class ����������� (IS NULL).

select flag_price_500, count(*) from 
(

select *,
case 
	when price > 500
	then 1 
	else 0 
end flag_price_500
from product 
join pc 
on product.model = pc.model 
) t1
group by flag_price_500


-task3
--������������ �����: ����� �����������/�������������� �����������, ������� ������� ��� � 
--������� (�� ���� ������ ���� ����������� ����������� � ������� PC)

select distinct maker 
from product 
where maker not in 
(
	select maker 
	from product 
	where type = 'PC' 
	and model not in (
		select model 
		from pc
	)
)

-task4
--������������ �����: ����� ������ � ���� ����������� �����������,                                                                                                                              
--  ��������� ������� ��������� ��������� ������ ��

select model, price
from laptop 
where price > all(select price from pc)


---task5 +++
--������������ �����: ������� ����� ������ �������� (��, ��-�������� ��� ��������),
-- �������� ����� ������� ����. �������: model
 
select model
from 
(
	select model, price from pc 
	union all
	select model, price from printer 
	union all
	select model, price from laptop 
) a 
order by price desc
limit 1

select 1 + 2 as variable 

-task6
--������������ �����: ��� ������ ���� �������� �� ������� printer 
--������������� ������� ��� ���, � ���� ���� ������ 300 - "1", � ��������� - "0"


select *,
case 
	when price > 300 then 1
	else 0
end flag
from printer

--task7
--������������ �����: ��� ������ ���� �������� �� �������
-- printer ������������� ������� ��� ���, � ���� ���� ����� ������� - "1", � ��������� - "0"

select *,
case 
	when price > (select AVG(price) from printer)
	then 1
	else 0
end flag
from printer

---task9
--������������ �����: ������� ������ ���� ���������� PC � �������������
-- � ����� ��� ���� �� ������ ��������. �����: model, maker
select * 
from pc
join product 
on pc.model = product.model
where price > any (select price from printer)


select * 
from pc
join product 
on pc.model = product.model
where price > (select min(price) from printer)

--task10
--������������ �����: ������� ������ ���� ���������� ��������� � 
--������������� � ������ ��. ������� model, maker

select distinct * from (
select product.model, product.maker 
from product join laptop on product.model = laptop.model 
union 
select product.model, product.maker 
from product join pc on product.model = pc.model 
union 
select product.model, product.maker 
from product join printer on product.model = printer.model 
) a 

-task11
--�������: ������� ������ ���� �������� � �����. ��� ��� � ���� ��� ������ - 
--������� 0, ��� ��������� - class

select  name, launched, 
case 
	when class is null
	then '0' 
	else class
end "class"
from ships



--task12
--�������: ��� ������� ������ ���������� ���, 
--����� ��� ������ �� ���� ������ ������� ����� ������. �������: �����, ���


select ships.class, min(launched)
from ships 
group by ships.class



-task13
--������������ �����: ������� ������ ���� ���������
-- � �������������� � ��������� ���� �������� (pc, printer, laptpo). �������: model, maker, type

select product.model, product.maker, product.type 
from product join laptop on product.model = laptop.model 
union 
select product.model, product.maker, product.type 
from product join pc on product.model = pc.model 
union 
select product.model, product.maker, product.type
from product join printer on product.model = printer.model

-task14
--������������ �����: ��� ������ ���� �������� �� ������� printer ������������� ������� ��� ���
-- � ���� ���� ����� ������� PC - "1", � ��������� - "0"

select *, 
case 
	when price > (select avg(price) from pc)
	then 1 
	else 0
end flag 
from printer


-task15
--�������: ������� ������ ��������, � ������� class ����������� (IS NULL)�

select * 
from ships 
where class is null  

--task16
--�������: ������� ��������, ������� ��������� � ����, �� ����������� �� � ����� �� ����� ������ �������� �� ����. (����� with)
--  ��������� �� ��������� �����

 �������� �������

--task17
--�������: ������� ��������, � ������� ����������� ������� ������ Kongo �� ������� Ships.
select battle
from 
((select *
from battles 
join outcomes on outcomes.battle=battles.name) b1
join ships on b1.ship = ships.name)
where ships.class='Kongo'


---task1
--�������: ��� ������� ������ ���������� ����� �������� ����� ������, 
--  ����������� � ���������. �������: ����� � ����� ����������� ��������.
  select class,count(ships.name)
  from outcomes 
  join ships on outcomes.ship = ships.name
  where result ='sunk' 
  group by class  

--task2
--�������: ��� ������� ������ ���������� ���, 
--����� ��� ������ �� ���� ������ ������� ����� ������. 
--���� ��� ������ �� ���� ��������� ������� ����������, ���������� ����������� ��� ������
-- �� ���� �������� ����� ������. �������: �����, ���.

select class,min(launched), 
case 
	when launched is null
	then 0 
	else min(launched) 
end flag 
from ships  group  by ships.name

--task3
--�������: ��� �������, ������� ������ � ���� ����������� �������� 
--� �� ����� 3 �������� � ���� ������, ������� ��� ������ � ����� ����������� ��������.

select class, count(ships.name) 
from ships 
join outcomes on outcomes.ship=ships.name
where result='sunk'
group by ships.class 


--task4
--�������: ������� �������� ��������, ������� ���������� �����
-- ������ ����� ���� �������� ������ �� ������������� (������ ������� �� ������� Outcomes).
select name,max(numguns) 
from 
((select *
from classes 
join ships on classes.class = ships.name)t1
join Outcomes on Outcomes.ship = t1.name)
where displacement = any (select distinct displacement from classes) 
group by t1.name

--task5
--������������ �����: ������� �������������� ���������, ������� ���������� 
--�� � ���������� ������� RAM � � ����� ������� ����������� ����� ���� ��, 
--������� ���������� ����� RAM. �������: Maker

select maker from 
(select maker, min(ram), max(speed) from pc
join product 
on pc.model = product.model
where maker in 
(select maker from 
printer join product on 
printer.model = product.model)
group by maker)t1




