--문제1
SELECT first_name||' '|| last_name 이름,
salary 월급 ,
phone_number 전화번호,
hire_date 입사일
FROM employees ORDER BY hire_date ;

--문제 2 jobs 테이블에 
SELECT 
job_title,max_salary 
FROM jobs ORDER By max_salary DESC ;

--문제3
--SELECT * FROM EMPLOYEES;
SELECT 
manager_id,
nvl(commission_pct,0),
salary
FROM employees 
WHERE salary >3000 and 
manager_id is not null and 
commission_pct is null 
ORDER BY salary DESC;


--문제4
SELECT 
job_title, max_salary 
FROM jobs WHERE max_salary>=10000 ORDER BY max_salary DESC ;

--문제5
SELECT 
first_name,
salary,
nvl(commission_pct,0)
FROM employees
WHERE 
--salary between 14000 and 17000 --하지만 btw은 이상,이하임
salary >=10000 AND salary <14000 
ORDER BY salary DESC;

--문제6
SELECT first_name,salary,
TO_CHAR(hire_date, 'YYYY-MM'),
department_id
FROM employees 
WHERE 
department_id in(10,90,100);
--10 or 90 or 100 같이 조건이 나열되는 경우 
--IN (A,B,C)로 묶을 수 잇다

--문제7
SELECT 
LOWER(first_name),
salary
FROM employees 
WHERE 
first_name LIKE '%s%' ;

SELECT first_name,
salary
FROM employees
WHERE 
first_name LIKE '';


--문제8
SELECT department_name FROM departments ORDER BY length(department_name) desc; 

--문제9
SELECT 
upper(country_name) 나라이름

FROM  countries ;


    
--문제10
SELECT 
first_name,
salary,
REPLACE(phone_number,'.','-') 폰번호,
--TO_CHAR(phone_number,'999-999-9999'),
hire_date
FROM employees
where HIRE_DATE <= '03/12/31';
