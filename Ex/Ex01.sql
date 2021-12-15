--select 문 (select절, from절)
--명령어 순서대로 실행되는것이 아니다. ; 전으로 마우스 커서를 두고 ctrl+enter치면 해당 내용 실행
select *
from employees;

--부서 테이블 전체 출력
select *
from departments;

--selct 컬럼명 (원하는 컬럼만 조회)
select employee_id,  
        first_name,
        last_name
from employees;

--예제 : tip form절 테이블부터 맞추고 컬럼명 작성
select first_name,
        phone_number,
        hire_date,
        salary
from employees;

select first_name,
        last_name,
        salary,
        phone_number,
        email,
        hire_date
from employees;

-->SQL에서 받을 때(출력할) 컬럼명 별명 적용하기 empNo
--select as 문
--특수문자 넣을 때는 ""로 표기 
select employee_id as empNo,
        first_name as "f-name",
        salary as "연  봉"
from employees;

--예제
select first_name as 이름,
        phone_number as 전화번호,
        hire_date as 입사일,
        salary as 급여
from employees;

--as 생략 가능하다
select employee_id  사원번호,
        first_name  "name",
        last_name  성,
        salary as 급여,
        phone_number as 전화번호,
        email as 이메일,
        hire_date as 입사일
from employees;

--concatenation 두개의 컬럼 합치기
select first_name, last_name
from employees;

select first_name || last_name
from employees;

select first_name ||' '|| last_name
from employees;

select first_name ||' 입사일은 '|| hire_date
from employees;

select first_name ||' '|| last_name as name
from employees;

--산술 연산자 사용하기
select first_name,
        salary as 월급,
        salary*12 as 연봉,
        (salary+300)*12 as 인상
from employees;

--예제(오류 문자*숫자) 숫자만 연산할 수 있다
select job_id*12
from employees;

select first_name ||'-'|| last_name 성명,
        salary 급여,
        salary*12 연봉,
        (salary*12)+5000 연봉2,
        phone_number 전화번호
from employees;

--where절 (비교연산자)
--부서번호가 10인/ 사원의 이름을/ 구하시오/
select first_name,
        last_name,
        salary,
        department_id
from employees
where department_id = 10;

--예제1 : 연봉이 15000 이상인 /사원들의 /이름과 /월급을 /출력하세요
select first_name,
        salary
from employees
where salary >= 15000;

--예제2 : 07/01/01 일 이후에 입사한 /사원들의 /이름과 /입사일을 /출력하세요
select first_name,
        hire_date
from employees
where hire_date > '07/01/01'; --날짜는 ''로 감싸서 기입

--예제3 : 이름이 Lex인/ 직원의 연봉을/ 출력하세요
select salary*12,
        first_name
from employees
where first_name = 'Lex';

--where and : 조건문에서 조건이 2개일때 
--연봉이 14000이상 17000이하인 사원의 이름과 연봉을 구하시오
select first_name,
        salary
from employees
where salary >= 14000
        and salary <=17000;
        
--예제1 or : 연봉이 14000 이하이거나 17000 이상인/ 사원의 이름과/ 연봉을/ 출력하세요
select first_name,
        salary
from employees
where salary <= 14000 
        or salary >= 17000;

--예제1 and : 입사일이 04/01/01 에서 05/12/31 사이의/ 사원의 이름과/ 입사일을/ 출력하세요
select first_name,
        hire_date
from employees
where hire_date >= '04/01/01' 
        and hire_date <= '05/12/31';
        
--between 연산자/ between~and 특정구간 값 출력하기
select first_name,
        salary
from employees
where salary >= 14000
and salary <= 17000;

--between은 이상~이하일때만 가능하다(포함 개념)
select first_name,
        salary
from employees
where salary 
between 14000 and 17000;

--in 연산자로 여러 조건을 검사하기
--or 연산자 사용
select first_name,
        last_name,
        salary
from employees
where first_name = 'Neena' 
or first_name = 'Lex'
or first_name = 'john';

--in 연산자 사용
select first_name,
        last_name,
        salary
from employees
where first_name in ('Neena', 'Lex', 'John');

--예제1 : 연봉이 2100, 3100, 4100, 5100 인 사원의 이름과 연봉을 출력
select first_name,
        salary
from employees
where salary in (2100,3100,4100,5100);
------------------------------------------------
--Like 연산자로 비슷한것들 모두 찾기
select *
from employees
where first_name like 'L%';

--예제 1: 이름에 am을 포함한 사원의 이름과 연봉을 출력
select first_name,
        salary
from employees
where first_name like '%am%';

--예제 2: 이름의 두번째 글자가 a 인 사원의 이름과 연봉을 출력하세요
-- _ (언더바) 한칸이 한글자
select first_name,
        salary
from employees
where first_name like '_a%';

--예제 3: 이름의 네번째 글자가 a인 사원의 이름을 출력하세요
select first_name
from employees
where first_name like '___a%';

--예제 4: 이름이 4글자인 사중중 끝에서 두번째 글자가 a인 사원의 이름을 출력하세요
select first_name
from employees
where first_name like '__a_';

-------------------------------------------

--null
-- null을 포함한 산술식은 결과가 null이다.
select first_name,
        salary,
        commission_pct,
        salary*commission_pct
from employees
where salary between 13000 and 15000;

--is null / is not null
--is null만 불러오기(영업사원이 아닌사람)
select *
from employees
where commission_pct is null;

--is not null만 불러오기 (영업사원)
select *
from employees
where commission_pct is not null;

--예제 1: 커미션비율이 있는 사원의 이름과 연봉 커미션비율을 출력하세요
select first_name,
        salary,
        commission_pct
from employees
where commission_pct is not null;

--예제 2: 담당매니저가 없고 커미션비율이 없는 직원의 이름을 출력하세요
select first_name, 
        manager_id,
        commission_pct
from employees
where manager_id is null
and commission_pct is null; 
---------------------------------------------------

--order by (정렬/ 오름차순, 내림차순)
-- 오름차순 asc / 내림차순 desc
select *
from employees
order by salary asc, first_name desc ; --정렬은 굳이 필요없으면 하지 않아도된다. 정렬하면 속도가 느려질 수 있음 (에너지 소비가 많이됨)

select first_name,
        salary
from employees
where salary >= 9000
order by salary asc;

--예제 1) 
-- 부서 번호를 오름차순정렬/ 부서번호, 급여, 이름 출력
-- 급여가 10000 이상인 직원의 이름 급여를 급여가 큰 직원부터 출력
-- 부서번호를 오름차순으로 정렬하고/ 부서번호가 같으면 급여가 높은 사람부터 부서번호 /급여/ 이름을 출력하세요
--1
select department_id,
        salary,
        first_name
from employees
order by department_id asc; 
--2
select first_name,
        salary
from employees
where salary >= 10000
order by salary desc,first_name asc;
--3
select department_id,
        salary,
        first_name
from employees
order by department_id asc, salary desc;
