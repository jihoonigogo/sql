--현재 계정 내에 어떤 테이블이 있는가
SELECT*FROM tab; -- 테이블 목록확인 
--테이블 : 실제 데이터가 담겨있는 공간 
-- 뷰 : 데이터를 담고 있지 않음. 테이블 내의 데이터의 표시형식만 정의함.

--테이블 구조 확인 DESC
DESC employees;

--테이블 ,필드는 소문자로 쓰는게 관례
--VARCHAR 문자열 , NUM(8,2)8자리에 소수점 2자리 포함.

--SELECT 모든 컬럼확인
--테이블에 정의된 컬럼의 순서대로
SELECT * FROM employees;

DESC departments;

SELECT * FROM departments;

-- 이름 , 번호 ,입사일,급여
SELECT first_name,phone_number,hire_date,salary FROM employees;

--이름,성,급여,번호,입사일

SELECT first_name,
last_name,
phone_number,
hire_date
salary
FROM employees;

--dual 은 가상테이블임.

--산술연산 
SELECT 3.14159 * 3 *3 FROM employees; -- 해당 테이블의 모든 레코드에 산술연산을 수행하고 출력.
SELECT 3.14159*3*3 FROM dual; --하나의 값 출력

SELECT first_name,salary,salary*12 FROM employees;
--


--산술연산 오류 예제
SELECT job_id*12 FROM employees; 
--에러가 나는 이유 ?  문자열은 산술연산X 수치자료형에만 가능.
DESC employees;

--사원의 이름, salary , commission_pct 출력
SELECT first_name,salary,commission_pct
FROM employees;

--계산식에 null포함시 결과는 항상 null
SELECT first_name,
salary,
salary +(salary * commission_pct)
FROM employees;

--nvl 함수 : null값을 다른 기본값으로 치환할 수 있음 .
--null을 처리할떄는 유의하도록 하자.
SELECT first_name,
salary,
salary +(salary * nvl(commission_pct,0)) -- pct가 null이면 0으로 치환.
FROM employees;

--컬럼 출력제목 변경 --select ename name from emp, as ,""

--문자열의 연결 
--문자열은 '' , +대신 || 
--별칭 ( Alisa) , as는 없어도 된다, 공백 및 특수무나 포함되어 있으면 별칭""로묶는다.
SELECT first_name ||' ' || last_name as "FULL NAME" 
FROM employees;

SELECT first_name||' '||last_name "이름",
hire_date 입사일,
phone_number 전화번호,
salary 급여,
salary*12 연봉
FROM employees;

-------------------------------------------------------

--WHERE 조건 비교 

--조건맞춰보기
SELECT first_name|| '' || last_name 이름,salary*12 연봉 FROM employees WHERE salary > 15000;

--조건맞춰보기2
SELECT first_name|| '' || last_name 이름,
hire_date 입사일
FROM employees WHERE hire_date >='07/01/01';

--조건3
SELECT first_name, 
salary*12 연봉,
hire_date 입사일,
department_id 부서id
FROM employees
WHERE first_name = 'Lex';

--조건4
SELECT * FROM employees WHERE department_id = '10';


--LIKE 연산 
-- %임의의 길이(0도 가능) , - 하나의 임의의 문자.

--이름에 am을 포함한 모든 사원들 %검색
SELECT first_name, salary FROM employees WHERE first_name LIKE '%am%';

--이름의 2번째 글자가 a인 사원
SELECT first_name FROM employees WHERE first_name LIKE '_a%';

-- 이중 조건 BTW
SELECT first_name , salary FROM employees 
WHERE salary <=14000 OR salary >=17000;

SELECT first_name , salary
,department_id FROM employees WHERE department_id >=90 and salary >=20000;

SELECT first_name,salary FROM employees WHERE salary between 14000 and 17000;

SELECT *FROM employees WHERE hire_date between '07/01/01' and '07/12/31';


--IN연습 
--왜 유용한가 ? 
--조건이 많아질수록 더욱 간결한 입력이 가능함.

SELECT * FROM employees WHERE department_id = 10 or department_id =20 or department_id =40;
SELECT * FROM employees WHERE department_id IN(10,20,40);

SELECT * FROM employees WHERE manager_id in (100,120,147);


--NULL TEST
-- =null은 하지마셈 
-- is null 
SELECT  first_name, commission_pct FROM employees WHERE commission_pct is null;
SELECT first_name, commission_pct FROM employees WHERE COMMISSION_PCT IS NOT NULL;


--ORDER BY =(SORT) 정렬
-- ASC 오름차순이 디폴트 , DESC 내림차순 

--예문1
SELECT first_name,salary FROM employees ORDER BY salary ;
SELECT first_name,salary FROM employees ORDER BY salary DESC ;
SELECT first_name,salary FROM employees WHERE salary >10000 ORDER BY salary DESC ;

--연습

--부서번호 오름차순
SELECT department_id,salary,first_name FROM employees ORDER BY  department_id ;

--급여 1만이상  , 급여 내림차순
SELECT first_name ,salary FROM employees WHERE salary >=10000 ORDER BY salary DESC;

--부서번호 오름차순, 급여 내림차순
SELECT department_id,salary,first_name FROM employees ORDER BY department_id ,salary desc ;



-------------
--단일행함수
-- 개별 레코드에 적용되는 함수
-------------

-- 문자열 단일행 함수  (이해해보기)
SELECT first_name,last_name,
CONCAT(first_name,CONCAT(' ',last_name)) name,
INITCAP(first_name || ' ' || last_name) name2, --각 단어 첫글자를 대문자
LOWER(first_name), --소문자
UPPER(first_name), --대문자
LPAD(first_name,10,'*'), --10글자 크기를 잡은 후 좌측 빈자리 별표로 채움 
RPAD(first_name,10,'*')
FROM employees;


--first name에 am 포함 검색
SELECT first_name FROM employees
where first_name like '%am%';

SELECT first_name FROM employees;

--대소문자 구분없이 검색 (따라해보기)
SELECT first_name FROM employees
WHERE lower(first_name) LIKE '%am%';

--정제 
SELECT  ' Oracle ' , '*****database*****' from dual;

SELECT  LTRIM(' Oracle '), --좌측 빈공간 삭제
RTRIM(' ORACLE  '), --우측 빈공간삭제
TRIM('*' FROM '*****database*****'),
SUBSTR('ORACLE DATABASE',8,8),
SUBSTR('ORACLE DATABASE',-8,8) FROM DUAL;

--수치형 단일행 함수 
SELECT ABS(-3.14), -- 절대값
CEIL(3.14), -- 소수점 올림
FLOOR(3.14), -- 소수점 내림 
FLOOR(7/3), --몫
MOD(7,3), --나눗셈의 나머지
POWER(2,4), --2의 4제곱 
ROUND(3.5), -- 소수점 첫째자리 반올림
ROUND(3.5678, 2), --소수점 둘째자리까지만 표시하므로 3번자리에서 반올림함
TRUNC(3.5), -- 소수점버림 
TRUNC(3.5678,2), -- 반올림하면 3.57이지만 버림이므로 3이나온다
SIGN(-10) -- 부호함수 (음수 -1 ,0 1 )
FROM DUAL;

SELECT first_name , (salary + (salary*commission_pct)*12) from employees;

--날짜형 단일행
SELECT sysdate FROM dual; --시스템 가상테이블 1개
SELECT sysdate FROM employees; -- 특정 테이블 내 레코드 갯수만큼 출력 

SELECT sysdate, --시스템날Wk    
    ADD_MONTHS(sysdate,2), --오늘부터 2개웛 ㅜ
    MONTHS_BETWEEN(TO_DATE('1999-12-31','YYYY-MM-DD'),sysdate), --개월 차이
    NEXT_DAY(sysdate,7), --오늘이후 첫번째 일요일 
    ROUND(sysdate,'MONTH'), --날짜 반올림 
    TRUNC(sysdate,'MONTH')
    FROM dual;
    
    
    
--employees 입사후 얼마나 지났는지

SELECT first_name , hire_date ,
ROUND(MONTHS_BETWEEN(sysdate,hire_date),0) as months
FROM employees;


--변환 연습 
SELECT sysdate,
TO_CHAR(sysdate,'YYYY-MM-DD HH24:MI":SS')
FROM dual;

-----------
--변환 함수 
-----------

/* 
TO_CHAR(o,fmt) : num or data - > varchar 
TO_NUMBER(s,fmt) : varchar -> num
to_date(s,fmt) varchar -> date
*/

--TO_CHAR
SELECT first_name , TO_CHAR(hire_date,'YYYY-MM-DD HH24:MI:SS')
FROM employees;

--현재시간을 년월일로 나타내보자 
SELECT sysdate, TO_CHAR(sysdate,'YYYY-MM-DD PM:MI:SS')
FROM dual;

--NUM TO CHAR
SELECT first_name , TO_CHAR(salary*12, '$999,9999,99') 연봉 
FROM employees;

--CHAR TO NUM
SELECT to_number('$1,500,500,90','$999,999,999,99') from dual;

--날짜 형태를 지닌 문자열 - > DATE
SELECT 
'2021-03-16 15:07',TO_DATE('2021-03-16 15:07','YYYY-MM-DD HH24:MI:SS')
FROM dual;

/* 날짜 연산 
date +(-) number : 날짜에 일수를 더하거나 뺀다 - > date 타입 
date - date : 두 날짜 사이의 일수를 확인 할 수 있다 . 
date + num /24 : 날짜에 시간을 더하거나 뺄 때는 number/24를 가감한다.
*/

SELECT TO_CHAR(sysdate,'YYYY-MM-DD HH24:MI'), -- G현재 오류발생
TO_CHAR(sysdate - 8,'YYYY-MM-DD HH24:MI'), --8일전
TO_CHAR(sysdate + 8,'YYYY-MM-DD HH24:MI'), --8일후
sysdate - TO_DATE('1999-12-31','YYYY-MM-DD'), -- 1999년 12월 31일 이후로 며칠이 지낫나
TO_CHAR(sysdate + 12/24,'YYYY-MM-DD HH24:MI') -- 현재시간으로부터 12시간 이후
FROM dual;

--NULL관련 
--null이 산술계산에 포함되면 null이다.
SELECT first_name,salary,nvl(salary*commission_pct,0)
FROM employees;

--nvl2 ( 2번째가 not null일 경우, 3번째가 null으 경우)
SELECT first_name,
salary,
nvl2(commission_pct,salary*commission_pct,0) commission
FROM employees;

--case function 
--보너스 지급 , AD 직원 20% , SA 10% , IT 5%

--SELECT first_name, job_id SUBSTR(job_id,1,2) FROM employees;
SELECT first_name,job_id,SUBSTR(job_id,1,2) 직종, salary,
CASE SUBSTR(job_id,1,2) 
WHEN 'AD' THEN salary*0.2
when 'SA' THEN salary*0.1
WHEN 'IT' THEN salary*0.08
ELSE salary * 1.03
end bonus
FROM employees;

--DECODE
SELECT first_name,job_id,SUBSTR(job_id,1,2) 직종, salary,
DECODE(SUBSTR(job_id,1,2), -- 비교할 값 
'AD' , salary*0.2,
'SA' , salary*0.1,
'IT' , salary*0.08,
salary*0.03) 보너스
FROM employees;

--연습문제 
SELECT first_name,department_id,

CASE 
WHEN department_id <= 30 then 'A GROUP'
WHEN department_id <= 60 then 'B GROUP'
WHEN department_id <= 1000 then 'C GROUP'

--WHEN department_id IN(10,30) THEN 'A-GROUP'
--WHEN department_id IN(40,50) THEN 'B-GROUP'
--WHEN department_id IN(60,100) THEN 'C-GROUP'
ELSE 'REMAINER'
END team
FROM employees ORDER BY department_id ;

-- 2021년 3월 16일 
-- PRACTICE 1 

--문제1
SELECT first_name||' '|| last_name 이름,
salary 월급 ,
phone_number 전화번호,
hire_date 입사일
FROM employees ORDER BY hire_date ;

--문제 2 jobs 테이블에 
SELECT 
job_title,max_salary 
FROM jobs,employees ORDER By salary DESC ;

--문제3
--SELECT * FROM EMPLOYEES;
SELECT 
manager_id,
nvl(commission_pct,0),
salary
FROM employees 
WHERE salary >=3000 and 
manager_id is not null and 
commission_pct is null ;


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
WHERE salary >=10000 AND
salary <14000 ORDER BY salary DESC;

--문제6
SELECT first_name,salary,
TO_CHAR(hire_date, 'YYYY-MM'),
department_id
FROM employees 
WHERE 
department_id in(10,90,100);

--문제7
SELECT 
LOWER(first_name),
salary
FROM employees 
WHERE 
first_name LIKE '%s%' ;

--문제8
SELECT * FROM departments ORDER BY length(department_name) desc; 

--문제9
SELECT 
upper(country_name)

FROM
    countries ;
    
--문제10
SELECT 
first_name,
salary,
phone_number,
length(phone_number), -- 길이 12
--to_number(phone_number), 묵시적 형변환 안됨
--to_number((cast( phone_number as char(50))),'9999999999'),
hire_date
FROM employees
where substr(phone_number, 1, 2) = to_char(12);




