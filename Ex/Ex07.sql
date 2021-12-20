--★subquery (쿼리문이 이중으로 되어있는 것)
/*하나씩 찾아서 쿼리문을 짠경우 (비효율)
--1)Den의 급여가 얼마인지
select first_name,
        salary
from employees
where first_name = 'Den';

--2)조건
select salary
from employees
where salary >= 11000;
*/

--subquery (들여쓰기 잘할것)
select first_name,
        salary,
        phone_number
from employees
where salary >= (select salary
                 from employees
                 where first_name = 'Den');
                 
--예제1) 급여를 가장 적게 받는 사람의 이름, 급여, 사원번호는?
--subquery문
select first_name,
        salary,
        employee_id
from employees
where salary = (select min(salary)
                from employees);        

--1) 최저 급여를 받는 사람
select min(salary)
from employees;

--2) 최저 급여를 받는 사람이 누구인가?
select first_name,
        salary,
        employee_id
from employees;

--예제)
--평균 급여보다 적게 받는 사람의 이름, 급여를 출력하세요?
--1. 평균급여?
select avg(salary)
from employees;

--2. 6461.83 보다 적게 받은 사람의 이름, 급여
select  first_name,
        salary
from employees
where salary < 6461.83;

--3. 식 조합
select  first_name,
        salary
from employees
where salary < (select avg(salary)
                from employees);