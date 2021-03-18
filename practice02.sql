--문제1
SELECT 
COUNT(manager_id) haveMngCnt
FROM employees;

--문제2
SELECT
MAX(salary) 최고임금,
MIN(salary) 최저임금,
MAX(salary)-MIN(salary)  "최고임금-최저임금"
FROM employees;

--문제3
SELECT
--REPLACE(MAX(hire_date),'/','-')
TO_CHAR(MAX(hire_date), 'YYYY "년" MM"월" DD"일"')
FROM employees;

--문제4
SELECT 
department_id,
AVG(salary) 평균임금,
MAX(salary) 최고임금,
MIN(salary) 최저임금
FROM employees
GROUP BY department_id
ORDER BY department_id DESC;

--문제5
SELECT
job_id,
ROUND(AVG(salary),0) 평균임금,
MAX(salary) 최고임금,
MIN(salary) 최저임금
FROM employees
GROUP BY job_id
ORDER BY MIN(salary) DESC ,ROUND(AVG(salary),0);

--문제6
SELECT 
TO_CHAR(MIN(hire_date),'YYYY-MM-DD day')
FROM employees;

--문재7

SELECT 
department_id,
AVG(salary) 평균임금,
MIN(salary) 최저임금,
AVG(salary) -MIN(salary) "평균임금-최저임금"
FROM employees
GROUP BY department_id
HAVING AVG(salary) -MIN(salary) <2000
ORDER BY AVG(salary) -MIN(salary) DESC;

--문제8
SELECT
job_id,
MAX(salary)-MIN(salary)
FROM employees
GROUP BY job_id
ORDER BY MAX(salary)-MIN(salary) desc;

--문제9
SELECT
ROUND(AVG(salary),1),
MIN(salary),
MAX(salary)
FROM employees
WHERE hire_date >'2005/01/01'
GROUP BY manager_id
HAVING AVG(salary) >= 5000
ORDER BY AVG(salary) DESC;

--문제10
SELECT
first_name,
CASE 
WHEN hire_date < '02/12/31' THEN '창립멤버'
WHEN hire_date < '03/12/31' THEN '03년입사'
WHEN hire_date < '04/12/31' THEN '04년입사'
ELSE '상장이후입사'
END optDate
FROM employees;