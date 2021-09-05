--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task1  (lesson7)
-- sqlite3: Сделать тестовый проект с БД (sqlite3, project name: task1_7).
-- В таблицу table1 записать 1000 строк с случайными значениями (3 колонки, тип int) от 0 до 1000.
-- Далее построить гистаграмму распределения этих трех колонко

--task2  (lesson7)
-- oracle: https://leetcode.com/problems/duplicate-emails/

SELECT Email FROM Person GROUP BY Email HAVING (COUNT(Email)>1)

--task3  (lesson7)
-- oracle: https://leetcode.com/problems/employees-earning-more-than-their-managers/

SELECT a.NAME AS Employee
FROM Employee a JOIN Employee b
ON a.ManagerId = b.Id
AND a.Salary > b.Salary

--task4  (lesson7)
-- oracle: https://leetcode.com/problems/rank-scores/

SELECT Score,
(SELECT COUNT(*) FROM (SELECT DISTINCT Score s FROM Scores) t WHERE s >= Score) Rank
FROM Scores ORDER BY Score DESC;


--task5  (lesson7)
-- oracle: https://leetcode.com/problems/combine-two-tables/

select p.FirstName, p.LastName, a.City, a.State
from Person p 
left join Address a on p.PersonId =a.PersonId 
