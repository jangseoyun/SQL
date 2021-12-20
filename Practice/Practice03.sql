--★practice03
--#문제01. 
/*직원들의 사번(employee_id), 이름(firt_name), 성(last_name)과 부서명(department_name)을
조회하여 부서이름(department_name) 오름차순, 사번(employee_id) 내림차순 으로 정렬하세
요.(106건)*/

select em.employee_id as "사번",
        em.first_name as "이름",
        em.last_name as "성",
        de.department_name "부서명"
from employees em, departments de
where em.department_id = de.department_id
order by de.department_name asc, em.employee_id desc;

--#문제02.
/*employees 테이블의 job_id는 현재의 업무아이디를 가지고 있습니다.
직원들의 사번(employee_id), 이름(firt_name), 급여(salary), 부서명(department_name), 현
재업무(job_title)를 사번(employee_id) 오름차순 으로 정렬하세요.
부서가 없는 Kimberely(사번 178)은 표시하지 않습니다.
(106건)*/

select em.employee_id as "사번",
        em.first_name as "이름",
        em.salary as "급여",
        de.department_name as "부서명",
        job.job_title as "현재업무"
from employees em, jobs job, departments de
where em.job_id = job.job_id 
and em.department_id = de.department_id
order by em.employee_id, job.job_title;

--#문제2-1
/*문제2에서 부서가 없는 Kimberely(사번 178)까지 표시해 보세요
(107건)*/

select em.employee_id as "사번",
        em.first_name as "이름",
        em.salary as "급여",
        de.department_name as "부서명",
        job.job_title as "현재업무"
from employees em, jobs job, departments de
where em.job_id = job.job_id 
and em.department_id = de.department_id(+)
order by em.employee_id, job.job_title;

--#문제03.
/*도시별로 위치한 부서들을 파악하려고 합니다.
도시아이디, 도시명, 부서명, 부서아이디를 도시아이디(오름차순)로 정렬하여 출력하세요
부서가 없는 도시는 표시하지 않습니다.
(27건)*/

select  lo.location_id as "도시아이디",
        lo.city as "도시명",
        de.department_name as "부서명",
        de.department_id as "부서아이디"
from departments de, locations lo
where de.location_id = lo.location_id
order by lo.location_id asc;

--#문제3-1 문제3에서 부서가 없는 도시도 표시합니다.

select  lo.location_id as "도시아이디",
        lo.city as "도시명",
        de.department_name as "부서명",
        de.department_id as "부서아이디"
from departments de right outer join locations lo
on de.location_id = lo.location_id
order by lo.location_id asc;

--#문제04.
/*지역(regions)에 속한 나라들을 지역이름(region_name), 나라이름(country_name)으로 출력하
되 지역이름(오름차순), 나라이름(내림차순) 으로 정렬하세요.
(25건)*/

select re.region_name as "지역이름",
        coun.country_name as "나라이름"
from countries coun , regions re
where coun.region_id = re.region_id
order by re.region_name asc, coun.country_name desc
;

--#문제05.
/*자신의 매니저보다 채용일(hire_date)이 빠른 사원의
사번(employee_id), 이름(first_name)과 채용일(hire_date), 매니저이름(first_name), 매니저입
사일(hire_date)을 조회하세요.
(37건)*/

select em.employee_id as "사번",
        em.first_name as "이름",
        em.hire_date as "채용일",
        em.manager_id as "매니저 아이디",
        ma.employee_id as "직원 아이디",
        ma.first_name as "매니저이름",
        ma.hire_date as "매니저입사일"
from employees em , employees ma
where em.manager_id = ma.employee_id
and ma.hire_date>em.hire_date;

--#문제06.
/*나라별로 어떠한 부서들이 위치하고 있는지 파악하려고 합니다.
나라명, 나라아이디, 도시명, 도시아이디, 부서명, 부서아이디를 나라명(오름차순)로 정렬하여
출력하세요.
값이 없는 경우 표시하지 않습니다.
(27건)*/

select co.country_name as "나라명",
        co.country_id as "나라 아이디",
        lo.city as "도시명",
        lo.location_id as "도시 아이디",
        de.department_name as "부서명",
        de.department_id as "부서 아이디"
from departments de, locations lo, countries co
where de.location_id = lo.location_id 
and lo.country_id = co.country_id
group by co.country_name,co.country_id,
         lo.city,lo.location_id,
         de.department_id,de.department_name
order by co.country_name asc;

--#문제07.
/*job_history 테이블은 과거의 담당업무의 데이터를 가지고 있다.
과거의 업무아이디(job_id)가 ‘AC_ACCOUNT’로 근무한 사원의 사번, 이름(풀네임), 업무아이
디, 시작일, 종료일을 출력하세요.
이름은 first_name과 last_name을 합쳐 출력합니다.
(2건)*/

select em.employee_id as "사번",
        em.first_name || em.last_name as "FULL NAME",
        em.job_id as "현재 JOB_ID",
        johi.job_id as "과거 JOB_ID",
        johi.start_date as "시작일",
        johi.end_date as "종료일"
from employees em, job_history johi
where em.employee_id = johi.employee_id
and johi.job_id = 'AC_ACCOUNT';

--#문제08.★
/*각 부서(department)에 대해서 부서번호(department_id), 부서이름(department_name),
매니저(manager)의 이름(first_name), 위치(locations)한 도시(city), 나라(countries)의 이름
(countries_name) 그리고 지역구분(regions)의 이름(resion_name)까지 전부 출력해 보세요.
(11건)*/



--#문제 09.
/*각 사원(employee)에 대해서 사번(employee_id), 이름(first_name), 부서명
(department_name), 매니저(manager)의 이름(first_name)을 조회하세요.
부서가 없는 직원(Kimberely)도 표시합니다.
(106명)*/

select em.employee_id as "사번",
        em.first_name as "이름",
        de.department_name as "부서명",
        ma.first_name as "매니저 이름"
from employees em , employees ma, departments de
where em.manager_id = ma.employee_id
and em.department_id = de.department_id(+);