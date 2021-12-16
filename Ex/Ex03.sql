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

