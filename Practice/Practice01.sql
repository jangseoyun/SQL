--★Practice01 기본 SQL 문제
--#문제01.
select first_name 이름,
        salary 월급,
        phone_number 전화번호,
        hire_date 입사일
from employees
order by hire_date asc;

--#문제02.
select job_title,
        max_salary
from jobs
order by max_salary desc, job_title desc;

--#문제03.
select first_name,
        manager_id,
        commission_pct,
        salary
from employees
where manager_id 
is not null and commission_pct 
is null and salary > 3000;

--#문제04.
select job_title,
        max_salary
from jobs
where max_salary>=10000
order by max_salary desc;

--#문제05.
select first_name,
        salary,
        nvl(commission_pct, 0)
from employees
where salary < 14000 
and salary >= 10000
order by salary desc;

--#문제06.
select first_name,
        salary,
        to_char(hire_date, 'yyyy-mm-dd'),
        department_id
from employees
where department_id in (10, 90, 100);

--#문제07.
select first_name,
        salary
from employees
where first_name like '%S%' or first_name like '%s%';

select first_name,
        salary
from employees
where regexp_like(first_name, 'S|s');

--#문제08.
select *
from departments
order by length(department_name)desc;

--#문제09.
select upper(country_name)
from countries
order by country_name asc;

--#문제10.
select first_name,
        salary,
        replace(phone_number, '.', '-')
from employees
where '03/12/31'>hire_date;
