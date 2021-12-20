--equi join
--null제외 row = 106개
select em.first_name,
        em.salary,
        de.department_id,
        de.department_name
from employees em, departments de
where em.department_id = de.department_id;

select count(*)
from employees em, departments de
where em.department_id = de.department_id;

----------------------------------------------
--예)
select em.first_name,
        de.department_name,
        job.job_title
from employees em, departments de, jobs job
where em.department_id = de.department_id
and em.job_id = job.job_id;

--outer join
--★left outer join
select em.first_name,
        em.salary,
        em.department_id,
        de.department_id,
        de.department_name
from employees em left outer join departments de
on em.department_id = de.department_id;

--left outer join 오라클에서만! 쓰는 문법
select *
from employees em , departments de
where em.department_id = de.department_id(+)
and em.employee_id = 178; -- join을 했기때문에 null값인 178이 나오는것
--null찾기
select *
from employees em
where em.department_id is null;

--right outer join
select em.first_name,
        em.salary,
        em.department_id,
        de.department_id,
        de.department_name
from employees em right outer join departments de
on em.department_id = de.department_id;

--left outer join 오라클에서만! 쓰는 문법
select *
from employees em , departments de
where em.department_id(+) = de.department_id;
--기준만 변경해줌 왼->오가 편하기때문에 (테이블 위치만 변경)
select em.first_name,
        em.salary,
        em.department_id,
        de.department_id,
        de.department_name
from  departments de left outer join employees em
on de.department_id = em.department_id;

select *
from  departments de , employees em
where de.department_id = em.department_id(+);

--★full outer join
select em.first_name,
        em.salary,
        em.department_id,
        de.department_id,
        de.department_name
from employees em full outer join departments de
on em.department_id = de.department_id;

--★self join
select em.employee_id,
        em.first_name,
        em.salary,
        em.phone_number,
        em.manager_id,
        ma.employee_id,
        ma.first_name,
        ma.phone_number,
        ma.email
from employees em, employees ma
where em.manager_id = ma.employee_id;

--잘 못된 join (문법적으로 맞지만 의미가 완전히 다름)
--조심 ! 
select em.employee_id,
        em.first_name,
        em.salary,
        lo.location_id,
        lo.city
from employees em, locations lo
where em.salary = lo.location_id;
