--★practice05  (혼합문제)
--#문제01.
/*담당 매니저가 배정되어있으나 커미션비율이 없고, 월급이 3000초과인 직원의
이름, 매니저아이디, 커미션 비율, 월급 을 출력하세요.
(45건)*/

select  first_name as "직원이름",
        manager_id as "매니저아이디",
        commission_pct as "커미션 비율",
        salary as "월급"
from employees
where manager_id is not null
and commission_pct is null
and salary > 3000;

--#문제02.
/*각 부서별로 최고의 급여를 받는 사원의 직원번호(employee_id), 이름(first_name), 급여
(salary), 입사일(hire_date), 전화번호(phone_number), 부서번호(department_id) 를 조회하
세요
-조건절비교 방법으로 작성하세요
-급여의 내림차순으로 정렬하세요
-입사일은 2001-01-13 토요일 형식으로 출력합니다.
-전화번호는 515-123-4567 형식으로 출력합니다.
(11건)*/

--1) group by, 최고급여
select max(salary),
        department_id
from employees
group by department_id;

--2) 
select employee_id as "직원번호",
        first_name as "이름",
        salary as "급여",
        to_char(hire_date,'yyyy-mm-dd DAY') as "입사일",
        replace(phone_number, '.', '-') as "전화번호",
        department_id as "부서번호"
from employees
where (salary, department_id) in (select max(salary),
                                         department_id
                                  from employees
                                  group by department_id)
order by salary desc;

--#문제03.★
/*매니저별 담당직원들의 평균급여 최소급여 최대급여를 알아보려고 한다.
-통계대상(직원)은 2005년 이후(2005년 1월 1일 ~ 현재)의 입사자 입니다.
-매니저별 평균급여가 5000이상만 출력합니다.
-매니저별 평균급여의 내림차순으로 출력합니다.
-매니저별 평균급여는 소수점 첫째자리에서 반올림 합니다.
-출력내용은 매니저아이디, 매니저이름(first_name), 매니저별평균급여, 매니저별최소급여, 매
니저별최대급여 입니다.
(9건)*/

--#문제04.
/*각 사원(employee)에 대해서 사번(employee_id), 이름(first_name), 부서명
(department_name), 매니저(manager)의 이름(first_name)을 조회하세요.
부서가 없는 직원(Kimberely)도 표시합니다.
(106명)*/

select em.employee_id as "사번",
        em.first_name as "이름",
        de.department_name as "부서명",
        ma.first_name as "매니저 이름"
from employees em, employees ma, departments de
where em.manager_id = ma.employee_id
and ma.department_id = de.department_id;

--#문제05.
/*2005년 이후 입사한 직원중에 입사일이 11번째에서 20번째의 직원의
사번, 이름, 부서명, 급여, 입사일을 입사일 순서로 출력하세요*/

--1)
select employee_id,
        first_name,
        department_id,
        salary,
        hire_date
from employees
where hire_date >= '2005/01/01'
order by hire_date asc;

--2)
select rownum,
        tin.employee_id,
        tin.first_name,
        tin.department_id,
        tin.salary,
        tin.hire_date
from (select employee_id,
             first_name,
             department_id,
             salary,
             hire_date
        from employees
        where hire_date >= '2005/01/01'
        order by hire_date asc)tin;
      
--3)
select tout.rnum,
        tout.employee_id as "사번",
        tout.first_name as "이름",
        tout.department_id as "부서명",
        tout.salary as "급여",
        tout.hire_date as "입사일"
from (select rownum rnum,
             tin.employee_id,
             tin.first_name,
             tin.department_id,
             tin.salary,
             tin.hire_date
      from (select employee_id,
                   first_name,
                   department_id,
                   salary,
                   hire_date
            from employees
            where hire_date >= '2005/01/01'
            order by hire_date asc)tin
     )tout
where tout.rnum between 11 and 20;

--#문제06.
/*가장 늦게 입사한 직원의 이름(first_name last_name)과 연봉(salary)과 근무하는 부서 이름
(department_name)은?*/

--1)
select max(hire_date)
from employees em, departments de
where em.department_id = de.department_id;
--2)
select  em.first_name||em.last_name as "FULL NAME",
        em.salary as "급여",
        de.department_name as "부서이름",
        em.hire_date as "입사일"
from employees em, departments de
where em.department_id = de.department_id
and em.hire_date = (select max(hire_date)
                    from employees em, departments de
                    where em.department_id = de.department_id);

--#문제07.★
/*평균연봉(salary)이 가장 높은 부서 직원들의 직원번호(employee_id), 이름(firt_name), 성
(last_name)과 업무(job_title), 연봉(salary)을 조회하시오.*/

                    
--#문제08.
/*평균 급여(salary)가 가장 높은 부서는?*/
                    
--1) 
select  max(avg(salary))
from employees em, departments de
where em.department_id = de.department_id
group by em.department_id;

--2)
select  avg(salary),
        de.department_name
from employees em, departments de
where em.department_id = de.department_id
group by de.department_name
having avg(salary) in (select  max(avg(salary))
                        from employees em, departments de
                        where em.department_id = de.department_id
                        group by em.department_id);

--#문제09.
/*평균 급여(salary)가 가장 높은 지역은?*/
                        
--1)
select max(avg(salary))
from employees em, departments de, locations lo, countries co, regions re
where em.department_id = de.department_id
and de.location_id = lo.location_id
and lo.country_id = co.country_id
and co.region_id = re.region_id
group by re.region_id;

--2)
select avg(salary),
        re.region_name
from employees em, departments de, locations lo, countries co, regions re
where em.department_id = de.department_id
and de.location_id = lo.location_id
and lo.country_id = co.country_id
and co.region_id = re.region_id
group by re.region_name
having avg(salary) in (select max(avg(salary))
                    from employees em, departments de, locations lo, countries co, regions re
                    where em.department_id = de.department_id
                    and de.location_id = lo.location_id
                    and lo.country_id = co.country_id
                    and co.region_id = re.region_id
                    group by re.region_id);


--#문제10.
/*평균 급여(salary)가 가장 높은 업무는?*/

                    --1)
select max(avg(em.salary))
from employees em, jobs job
where em.job_id = job.job_id
group by job.job_id;

--2)
select job.job_title
from employees em, jobs job
where em.job_id = job.job_id
group by job.job_title
having avg(em.salary) in (select max(avg(em.salary))
                        from employees em, jobs job
                        where em.job_id = job.job_id
                        group by job.job_id);