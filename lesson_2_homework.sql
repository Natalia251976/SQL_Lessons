
--����� ��: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing
 

--������� 1: ������� name, class �� ��������, ���������� ����� 1920

select name, class from ships s
where launched > 1920

--������� 2: ������� name, class �� ��������, ���������� ����� 1920, �� �� ������� 1942
select name, class from ships s
where launched between 1920 and 1942 

--������� 3: ����� ���������� �������� � ������ ������. ������� ���������� � class

select count(name),class  from ships
group by class  
--
--������� 4: ��� ������� ��������, ������ ������ ������� �� ����� 16, ������� ����� � ������. (������� classes)

select class, country from classes 
where bore >= 16

--������� 5: ������� �������, ����������� � ��������� � �������� ��������� (������� Outcomes, North Atlantic). �����: ship.
select ship from Outcomes
where battle = 'North Atlantic' and result = 'sunk' 

--������� 6: ������� �������� (ship) ���������� ������������ �������

select ship
 from Outcomes  
 join battles 
 on Outcomes.battle = battles.name
 where date =  (select max(date) from battles where result = 'sunk') and result = 'sunk'
 
--������� 7: ������� �������� ������� (ship) � ����� (class) ���������� ������������ �������
 select ship,class 
 from
 ((select ship 
 from Outcomes 
 join battles 
 on Outcomes.battle = battles.name
 where date =  (select max(date) from battles where result = 'sunk') and result = 'sunk')sh1
 join ships 
 on ships.name = sh1.ship)

--������� 8: ������� ��� ����������� �������, � ������� ������ ������ �� ����� 16, � ������� ���������. �����: ship, class
select *
from ships 
join classes
on ships.class = classes.class 
where bore > 16 

select *
from Outcomes
join ships
on Outcomes.ship = ships.name 
where result = 'sunk' 



--������� 9: ������� ��� ������ ��������, ���������� ��� (������� classes, country = 'USA'). �����: class
select class from classes
where country = 'USA'

--������� 10: ������� ��� �������, ���������� ��� (������� classes & ships, country = 'USA'). �����: name, class

select name, cl1.class
from 
((select * 
from classes
where country = 'USA')cl1
join ships
on ships.class = cl1.class )

