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

select first_name,
        salary,
        department_id
from employees;

select *
from departments;
