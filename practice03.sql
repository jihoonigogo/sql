--문제1
SELECT
employee_id 사번,
first_name 이름,
last_name 성,
department_name
FROM employees e, departments d
WHERE e.department_id=d.department_id
ORDER BY department_name , employee_id DESC;
--FROM employees NATURAL JOIB departments;


--문제2
SELECT
e.employee_id 사번,
e.first_name 이름,
e.salary 급여,
d.department_name 부서명,
j.job_title 현재업무
FROM employees e, jobs j, departments d
WHERE e.job_id =j.job_id and e.department_id = d.department_id;

SELECT
e.employee_id 사번,
e.first_name 이름,
e.salary 급여,
d.department_name 부서명,
j.job_title 현재업무
FROM employees e ,departments d , jobs j
WHERE e.department_id = d.department_id (+) AND
e.job_id =j.job_id; --이거 이해해보기
--왼쪽모두 출력에 참여하나 오른쪽은 참여를 안할수도 있다.

--문제2-1 (몰라)
SELECT
employee_id 사번,
first_name 이름,
salary 급여,
nvl(department_name,' ') 부서명,
job_title 현재업무
FROM employees, jobs, departments
WHERE employees.job_id =jobs.job_id and employees.department_id = departments.department_id(+);
--and employees.department_id is null;


--ANSI SQL
SELECT
employee_id 사번,
first_name 이름,
salary 급여,
nvl(department_name,' ') 부서명,
job_title 현재업무
FROM employees e LEFT OUTER JOIN departments d ON e.department_id = d.department_id, jobs j 
WHERE e.job_id =j.job_id;


--문제3 (GROUP BY문제)
SELECT
dep.location_id 도시아이디,
city 도시명,
department_name 부서명,
department_id 부서아이디
FROM locations lc, departments dep 
WHERE  dep.location_id = lc.location_id
--GROUP BY dep.location_id ,
--city ,department_name ,department_id
ORDER BY dep.location_id;

--문제3-1
--부서값이 null인 도시는 locations 속해있다.
--WHERE DEPARTMENTS LEFT OUTER JOIN LOCATIONS
SELECT
lc.location_id 도시아이디,
city 도시명,
department_name 부서명,
department_id 부서아이디
FROM locations lc, departments dep 
WHERE  dep.location_id (+)= lc.location_id 
--GROUP BY lc.location_id ,
--city ,department_name ,department_id
ORDER BY lc.location_id;
 --ANSI SQL
SELECT
lc.location_id 도시아이디,
city 도시명,
department_name 부서명,
department_id 부서아이디
FROM locations lc LEFT OUTER JOIN  departments dep ON  dep.location_id (+)= lc.location_id 
ORDER BY lc.location_id;

--문제4
SELECT 
region_name,
country_name
FROM regions r, countries c
WHERE r.region_id = c.region_id 
ORDER BY region_name , country_name DESC;

SELECT 
region_name,
country_name
FROM regions r RIGHT OUTER JOIN countries c ON r.region_id = c.region_id 
ORDER BY region_name , country_name DESC;

--문제5 (SELF JOIN)
SELECT
emp.employee_id 사번,
emp.first_name 이름,
emp.hire_date 채용일,
mng.first_name 매니저이름,
mng.hire_date 매니저입사일
FROM  employees emp , employees mng
WHERE emp.manager_id = mng.employee_id and  emp.hire_date < mng.hire_date;

SELECT
emp.employee_id 사번,
emp.first_name 이름,
emp.hire_date 채용일,
mng.first_name 매니저이름,
mng.hire_date 매니저입사일
FROM  employees emp LEFT OUTER JOIN employees mng ON emp.manager_id = mng.employee_id 
WHERE  emp.hire_date < mng.hire_date;


--문제 6
SELECT 
country_name 나라명,
c.country_id 나라아이디,
city 도시명,
l.location_id 도시아이디,
department_name 부서명,
department_id 부서아이디
FROM locations l, countries c,departments d
WHERE c.country_id = l.country_id and d.location_id = l.location_id
ORDER BY country_name;

--문제7★★★★★★★★★★★★★★★★★★★★★★★★★★★★★ㅍ
SELECT
e.employee_id 사번,
e.first_name||' '|| e.last_name 이름,
e.job_id 업무아이디,
h.start_date 시작일,
h.end_date 종료일
FROM employees e, JOB_HISTORY h
WHERE e.employee_id = h.employee_id and h.job_id ='AC_ACCOUNT';

SELECT *FROM JOB_HISTORY h;

--문제8 (다시풀기)★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
SELECT
d.department_id 부서번호,
d.department_name 부서이름,
man.first_name 매니저이름,
l.city 위치한도시,
country_name 나라이름,
region_name 지역구분이름
FROM regions r,countries c, locations l, departments d, employees man
WHERE 
r.region_id = c.region_id and 
c.country_id = l.country_id and 
l.location_id = d.location_id and
d.department_id = man.department_id and
man.employee_id = d.manager_id; -- 매니저인 사람 


--문제9 킴벌리찾기★★★★★★★★★★★★★★★★★★★★
SELECT
e.employee_id 사번,
e.first_name 이름,
department_name 부서명 ,
e1.first_name 매니저이름
FROM employees e, departments d,employees e1
WHERE e.manager_id = e1.employee_id and e.department_id = d.department_id(+);

--ANSI SQL 
SELECT
e.employee_id 사번,
e.first_name 이름,
department_name 부서명 ,
e1.first_name 매니저이름
FROM employees e1 ,employees e RIGHT OUTER JOIN departments d ON e.department_id = d.department_id(+)
WHERE e.manager_id = e1.employee_id;-- and e.department_id = d.department_id(+);