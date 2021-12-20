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

