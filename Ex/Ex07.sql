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
                
--#문제08.★
/*각 부서(department)에 대해서 부서번호(department_id), 부서이름(department_name),
매니저(manager)의 이름(first_name), 위치(locations)한 도시(city), 나라(countries)의 이름
(countries_name) 그리고 지역구분(regions)의 이름(resion_name)까지 전부 출력해 보세요.
(11건)*/

select de.department_id,
        de.department_name,
        ma.first_name,
        lo.city,
        co.country_name,
        re.region_name
from departments de, employees ma,
     locations lo, countries co,
     regions re
where de.manager_id = ma.employee_id
and  de.location_id = lo.location_id
and lo.country_id = co.country_id
and co.region_id = re.region_id;

-------------------------------------------

--★다중행 subquery
--예제) 부서번호가 110인 지원의 급여와 같은 모든 직원의 사번,이름,급여 출력

--1) 부서번호가 110인 직원
--sehlley(12008), william(8300) 급여와 같은 사람 모두 출력 -> 급여가 12008,8300인 사람 모두 출력 
select employee_id,
        first_name,
        salary,
        department_id
from employees
where department_id = 110;

--2) 급여를 12008 받는 직원 리스트 (nancy, shelley)
select employee_id,
        first_name,
        salary
from employees
where salary = 12008;

--2) 급여를 8300 받는 직원 리스트 (william)
select employee_id,
        first_name,
        salary
from employees
where salary = 8300;

/*row가 복수로 나올 때는 단일행 사용불가, 다중행을 사용해야한다.
--기존의 in연산자 사용
select employee_id,
        first_name,
        salary
from employees
where salary in (12008, 8300);
*/

--★subquery 다중행 in
--다중행 subquery
select employee_id,
        first_name,
        salary
from employees
where salary in (select salary
                 from employees
                 where department_id = 110);

--예제1) 각 부서별로 최고급여를 받는 직원을 구하라
-- in (같으면서 or인 경우 : 조건에 맞는것을 모두 비교)
-- 1) 각 부서별 최고 급여를 구한다. (사람 first_name은 표현할 수 없다.)
select max(salary),
        department_id
from employees
group by department_id;

-- 2) 각 부서별(group by) 최고 급여를 받는 직원
-- 사원테이블에서 그룹(부서)번호와 급여가 같은 지원을 구한다.
-- 여러개의 조건을 비교해야할 때
--null은 포함안됨
select department_id,
        first_name,
        phone_number,
        salary
from employees
where (department_id, salary) in (select department_id,
                                         max(salary)
                                 from employees
                                 group by department_id) ;

--응용(null값 포함)        
select department_id,
        first_name,
        salary
from employees
where (nvl(department_id, 0), salary) in (select nvl(department_id, 0),
                                        max(salary)
                                 from employees
                                 group by department_id) ;

--★subquery 다중행 any = or 의미 
--예제) 부서번호가 110인 직원의 급여보다 큰 모든 직원의 사번, 이름, 급여 출력
--1) 부서번호가 110인 직원의 급여 (12008, 8300)
select salary
from employees
where department_id = 110;

select employee_id,
        first_name,
        salary
from employees
where salary > 12008
or salary > 8300;

--2) 110인 직원의 급여보다 큰 모든 직원
select employee_id,
        first_name,
        salary
from employees
where salary >any (select salary
                from employees
                where department_id = 110);
--> 결국 8300보다 큰 급여 출력됨
                
------------------------------------------------
--★subquery 다중행 all = and 의미 (조건을 모두 만족해야한다.)
-- >all (교집합만!)

--예제) 부서번호가 110인 직원의 급여보다 큰 모든 직원의 사번, 이름, 급여 출력
--1) 부서번호가 110인 직원의 급여 (12008, 8300)
select salary
from employees
where department_id = 110;

select employee_id,
        first_name,
        salary
from employees
where salary > 12008
and salary > 8300;
--> 결국 12008보다 큰 급여 출력됨

--2) 110인 직원의 급여보다 큰 모든 직원
select employee_id,
        first_name,
        salary
from employees
where salary >all (select salary
                    from employees
                    where department_id = 110);

----------------------------------------------
--★조건절에서 비교 vs 테이블에서 조인

-- 각 부서별로 최고급여를 받는 사원을 출력하세요
-- ★ where절 서브쿼리 이용
-- 방법1)조인에 이용할 테이블로 사용예정
-- 1) 부서 그룹 만들기, 최고급여max(salary) 사용
select max(salary),
        department_id
from employees
group by department_id;

--2) 직원 리스트에서 부서별 최고 급여를 받는 사람을 구한다.
--null값 제외 포함할 경우 nvl 사용
select  first_name,
        department_id,
        salary
from employees
where (salary, department_id) in (select max(salary),
                                         department_id
                                  from employees
                                  group by department_id);

--★테이블 조인이용
--방법2) from절에 테이블 만들어줌 (카디전 -> 모든 경우의 수 나옴)
-- 원하는 데이터만 뽑아냄
-- ms라는 테이블이 생성 -> max(salary),department_id 컬럼 생성됨
-- max(salary) -> 컬럼명 salary로 변경

select em.first_name,
        em.salary,
        em.department_id,
        ms.department_id,
        ms.salary
from employees em, (select max(salary) salary,
                            department_id
                     from employees
                     group by department_id) ms
where em.department_id = ms.department_id
and em.salary = ms.salary;


