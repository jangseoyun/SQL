--★practice04
--#문제01
/*평균 급여보다 적은 급여을 받는 직원은 몇명인지 구하시요.(56건)*/

--1) 평균 급여
select avg(salary)
from employees;

--2) 1) 보다 적은 급여
select count(*)
from employees
where salary < (select avg(salary)
                from employees);
                
--#문제02.
/*평균급여 이상, 최대급여 이하의 월급을 받는 사원의
직원번호(employee_id), 이름(first_name), 급여(salary), 평균급여, 최대급여를 급여의 오름차
순으로 정렬하여 출력하세요
(51건)*/
--두개의 조건 만족 평균급여 이상, 최대 급여 이하

--1) 평균급여, 최대급여
select avg(salary),
        max(salary)
from employees;

--2) 1)의 평균급여 이상, 최대급여 이하의 급여
select  employee_id as "직원번호",
        first_name as "이름",
        salary as "급여"
from employees
where salary >=all (select avg(salary)
                    from employees)
and salary <=all (select max(salary)
                    from employees)
order by salary asc;

--#문제03.
/*직원중 Steven(first_name) king(last_name)이 소속된 부서(departments)가 있는 곳의 주소
를 알아보려고 한다.
도시아이디(location_id), 거리명(street_address), 우편번호(postal_code), 도시명(city), 주
(state_province), 나라아이디(country_id) 를 출력하세요
(1건)*/
-- 직원테이블, locations, 
--직원 Steven(first_name) king(last_name)
select lo.location_id as "도시아이디",
        lo.street_address as "거리명",
        lo.postal_code as "우편번호",
        lo.city as "도시명",
        lo.state_province as "주",
        lo.country_id as "나라아이디"
from employees em,departments de, locations lo
where em.department_id = de.department_id
and de.location_id = lo.location_id
and first_name ='Steven'
and last_name = 'King';

--#문제04.
/*job_id 가 'ST_MAN' 인 직원의 급여보다 작은 직원의 사번,이름,급여를 급여의 내림차순으로
출력하세요 -ANY연산자 사용(or)
(74건)*/

--1. job_id 가 'ST_MAN' 인 직원의 급여
select job_id,
        salary
from employees
where job_id = 'ST_MAN';

--2. any를 사용
select employee_id,
        first_name,
        salary
from employees
where salary <any (select salary
                    from employees
                    where job_id = 'ST_MAN')
order by salary desc;
                    
--#문제05.
/*각 부서별로 최고의 급여를 받는 사원의 직원번호(employee_id), 이름(first_name)과 급여
(salary) 부서번호(department_id)를 조회하세요
단 조회결과는 급여의 내림차순으로 정렬되어 나타나야 합니다.
조건절비교, 테이블조인 2가지 방법으로 작성하세요
(11건)*/
-- 부서 그룹, max(salary), 
select max(salary)
from employees
group by department_id;

--조건절 비교
select employee_id as "직원번호",
        first_name as "이름",
        salary as "급여",
        department_id as "부서번호"
from employees
where (salary,department_id) in (select max(salary),
                                        department_id
                                 from employees
                                 group by department_id)
order by salary desc;

--테이블 조인
select  em.employee_id as "직원번호",
        em.first_name as "이름",
        em.salary as "급여",
        em.department_id as "부서번호"
from employees em, (select max(salary) salary,
                            department_id
                    from employees
                    group by department_id) ms
where em.department_id = ms.department_id
and em.salary = ms.salary
order by em.salary desc;

--#문제06.★
/*각 업무(job) 별로 연봉(salary)의 총합을 구하고자 합니다.
연봉 총합이 가장 높은 업무부터 업무명(job_title)과 연봉 총합을 조회하시오
(19건)*/
--업무 그룹, sum(salary)
--1. 업무별 그룹 급여 총합
select job_id,
        sum(salary)
from employees
group by job_id
order by sum(salary) desc;

--2. 업무명, 연봉 총합 조회
select jo.job_id,
        jo.job_title,
        em.salary
from employees em, jobs jo
where em.job_id in (select job_id,
                            sum(salary)
                    from employees
                    group by job_id
                    order by sum(salary) desc);

--#문제07.
/*자신의 부서 평균 급여보다 연봉(salary)이 많은 직원의 직원번호(employee_id), 이름
(first_name)과 급여(salary)을 조회하세요
(38건)*/

-- 각 개인 부서 평균급여 > 연봉

select department_id,
        avg(salary)
from employees
group by department_id;

select  employee_id,
        first_name,
        salary
from employees
where salary >any (select avg(salary)
                   from employees
                   group by department_id)
and department_id in (select department_id
                   from employees
                   group by department_id);

                   
--#문제08.
/*직원 입사일이 11번째에서 15번째의 직원의 사번, 이름, 급여, 입사일을 입사일 순서로 출력
하세요*/

