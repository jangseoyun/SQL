--★그룹함수
-- 평균 avg
select avg(salary)
from employees;

select first_name, --> 오류 발생 (1개의 row에 표현할 수 없음)
        avg(salary)
from employees;

-- count()
--특정 컬럼의 갯수를 세어주는 것 데이터의 총 건수를 구하는 함수
select count(*), --> 전체의 row 개수
        count(commission_pct),--> 특정 컬럼에서 null을 제외한 수를 구할때 
        count(department_id)
from employees;

--급여가 16000이상인 경우만 (조건문에 해당하는 전체 row의 개수)
select count(*)
from employees
where salary >= 16000;
--예제)부서 번호가 100인 사람의 개수
select count(*)
from employees
where department_id = 100;

--그룹함수 sum()
select sum(salary), 
        count(*),
        avg(salary)
from employees;
-- 응용
select sum(salary), 
        count(*),
        avg(salary)
from employees
where salary >= 16000;

--그룹함수 avg()
select count(*),
        sum(salary),
        avg(nvl(salary,0)) -->null값을 포함하여 평균을 낼 경우 nvl() 사용
from employees;

--그룹함수 max()최대값/min()최소값
select count(*),
        max(salary),
        min(salary)
from employees;

--★group by(각 그룹 별로 데이터를 구함)
select avg(salary),
        department_id --> 그룹별로 계산에 참여했기때문에 가능하다.
from employees
group by department_id; --> 그룹별로 평균을 구함(부서 아이디가 같은 구간끼리)

--★group by 절
select avg(salary), department_id
from employees
group by department_id
order by department_id asc;

select avg(salary),
        count(*),
        department_id
from employees
group by department_id;

select department_id,
        job_id,
        count(*),
        avg(salary)
from employees
group by department_id, job_id
order by department_id asc, job_id desc;

--예제)
--where절에는 그룹함수를 사용할 수 없다.
--오류나는 쿼리문
select department_id,
        count(*),
        sum(salary)
from employees
where sum(salary) >= 20000
group by department_id;

--★having절
select department_id,
        count(*),
        sum(salary)
from employees
group by department_id
having sum(salary) >= 20000
and department_id = 100;

--★case~end문
select employee_id,
        first_name,
        salary,
        job_id,
        case when job_id = 'AC_ACCOUNT' then salary+(salary*0.1)
             when job_id = 'SA_REP' then salary+(salary*0.2)
             when job_id = 'ST_CLERK' then salary+(salary*0.3)
             else salary
        end bonus -- 컬럼명으로 지정
from employees;

--★DECODE(기준,조건,계산 마지막 기본)별명
select employee_id,
        first_name,
        salary,
        job_id,
        decode(job_id, 'AC_ACCOUNT', salary+(salary*0.1)
        ,'SA_REP', salary+(salary*0.2)
        ,'ST_CLERK', salary+(salary*0.3)
        ,salary) as bonus
from employees;

--예제1)
--> decode() 파라미터에는 범위값으로 평가되는 것은 들어갈 수 없다
--> 따라서 between사용 불가 ** = 일때만 가능
select first_name,
        department_id,
        case when department_id >= 10 and department_id <=50 then 'A-TEAM'
             when department_id >= 60 and department_id <=100 then 'B-TEAM'
             when department_id >= 110 and department_id <= 150 then 'C-TEAM'
             else '팀없음'
        end as "Team name"
from employees;

select first_name,
        department_id,
        case when department_id between 10 and 50 then 'A-TEAM'
             when department_id between 60 and 100 then 'B-TEAM' 
             when department_id between 110 and 150 then 'C-TEAM'    
             else '팀없음'
        end teamname
from employees;

--★join문 두개 이상의 테이블 조합

-->row = 2889개 , coulum = 15개
--> 카디전 프로덕트
select *
from employees, departments;

-->1. row = 107개 , coulum = 11개
select *
from employees;

-->2. row = 27개 , coulum = 4개
select *
from departments;

--join문 / 테이블 별명 지어주기 
--> row = 106개 (null값이 고려안됨 fk로 찾아갈 수 없다), coulum = 4개
--> 소속을 정해주지 않을 경우 있는곳으로 알아서 찾아감, 동일한 컬럼명이 존재하면 소속을 정해줘야함
select  em.employee_id,
        em.first_name,
        em.salary,
        de.department_name,
        em.department_id, --> 어느 테이블의 컬럼인지 지정해줘야함
        de.department_id --> 어느 테이블의 컬럼인지 지정해줘야함
from employees em, departments de --> 별명 지정, as사용불가
where em.department_id = de.department_id;

--예제1) 모든 직원이름, 부서이름, 업무명 을 출력하세요
--> 별명을 지정해준 경우, 호출할때도 별명으로 호출해줘야한다. 
--> row = 106개 , coulum = 3개
select emt.first_name,
        det.department_name,
        jot.job_title
from employees emt, departments det, jobs jot
where emt.department_id = det.department_id 
and emt.job_id = jot.job_id;

---------------------------------------------------
--> where절에 join + 타 조건 가능
select emt.first_name,
        det.department_name,
        jot.job_title
from employees emt, departments det, jobs jot
where emt.department_id = det.department_id 
and emt.job_id = jot.job_id
and salary > 10000
order by em.first_name asc;


