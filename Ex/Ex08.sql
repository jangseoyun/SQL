--★rownum 
-- 예제) 급여를 가장 많이 받는 5명의 직원 이름 출력

/* 해당 방법으로 구할 수 없다
select max(salary)
from employees;

select first_name,
        salary
from employees
where salary = (select max(salary)
                from employees);
*/   
--rownum 이해(정렬한거 아님.)
select  rownum,
        first_name,
        salary
from employees
where rownum >= 1
and rownum <= 5;

--급여순으로 정렬 시도 --> rownum 섞여버림
--rownum부터 지정을하고 정렬을해서 섞임(정렬이 가장 나중에 실행됨)
select  rownum,
        first_name,
        salary
from employees
order by salary desc;
---------------------------------------------------
--급여 순서로 정렬
select first_name,
        salary
from employees 
order by salary desc;

-- ★쿼리문으로 테이블을 만듬 (정렬된 테이블을 만들어준다)
--> 이미 정렬이된 테이블을 사용했기 때문에 나중에 정렬을 해주는 것과 같음
--가상의 테이블 생성
select rownum,
        first_name,
        salary
from (select first_name,
             salary
      from employees 
      order by salary desc)
where rownum <= 5;

-------------------------------------------------
-- *는 안쓰는것이 좋다(오류날 수 있음) 하나씩 다 작성해주는것이 좋다.
select rownum,
        first_name,
        salary,
        email
from (select *
      from employees 
      order by salary desc);

-- 1번부터 가져오는것은 되는데 , 중간의 구간만 선택해서 가져오는것은 불가
select rownum,
        first_name,
        salary,
        email
from (select *
      from employees 
      order by salary desc)
where rownum >= 2
and rownum <= 5;

-------------------------------------------------------
--구간 선택 안됨 (rownum , where절 동시 진행)
select rownum,
        o.first_name,
        o.salary
from (select first_name,
             salary
      from employees 
      order by salary desc) o
where rownum >= 2
and rownum <= 5;

--해결방법
select  r.rno,
        r.first_name,
        r.salary
from (select rownum rno,
             o.first_name,
             o.salary
        from (select first_name,
                     salary
                from employees 
                order by salary desc) o
       )r
where rno >= 2
and rno <= 4;

--예제1)07년에 입사한 직원중 급여가 많은 직원중 3에서 7등의 이름 급여 입사일은?
--1)
select  first_name,
        hire_date,
        salary
from employees
where hire_date between '07/01/01' and '07/12/31'
order by salary desc;

--2)
select rownum rnum,
        tin.first_name,
        tin.salary,
        tin.hire_date
from (select first_name,
             hire_date,
             salary
      from employees
      where hire_date between '07/01/01' and '07/12/31'
      order by salary desc) tin;

--3) 
select tout.rnum,
        tout.first_name,
        tout.salary,
        tout.hire_date
from (select rownum rnum,
             tin.first_name,
             tin.salary,
             tin.hire_date
      from (select first_name,
                    hire_date,
                    salary
            from employees
            where hire_date between '07/01/01' and '07/12/31'
            order by salary desc) tin
      )tout
where rnum >= 3
and rnum <= 5;

--예제1)07년에 입사한 직원중 급여가 많은 직원중 3에서 7등의 이름 급여 입사일+부서명은?
--1)join 추가
select  em.first_name,
        em.salary,
        em.hire_date,
        de.department_name
from employees em, departments de
where em.department_id = de.department_id
and hire_date between '07/01/01' and '07/12/31';

--2) 
select rownum rnum,
        tin.first_name,
        tin.salary,
        tin.hire_date,
        tin.department_name
from (select  em.first_name,
              em.salary,
              em.hire_date,
              de.department_name
     from employees em, departments de
     where em.department_id = de.department_id
     and hire_date between '07/01/01' and '07/12/31'
     order by salary desc )tin;

--3)
select tout.rnum,
        tout.first_name,
        tout.salary,
        tout.hire_date,
        tout.department_name
from (select rownum rnum,
             tin.first_name,
             tin.salary,
             tin.hire_date,
             tin.department_name
       from (select  em.first_name,
                     em.salary,
                     em.hire_date,
                     de.department_name
              from employees em, departments de
              where em.department_id = de.department_id
              and hire_date between '07/01/01' and '07/12/31'
              order by salary desc )tin
       )tout
where tout.rnum >= 3
and tout.rnum <= 7;

--chapter05
--★ DCL 계정관리
--system 접속 + 계정 생성
create user webdb identified by 1234;

--접속 권한 (resource, connect정해져있는것)
grant resource, connect to webdb;

--계정 비밀번호 변경
alter user webdb identified by webdb;
