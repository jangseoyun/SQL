--단일행 함수

--문자함수 - INITCAP(컬럼명)
--문자열 첫글자만 대문자 나머지 소문자
select  email,
        INITCAP(email),
        department_id
from employees
where department_id = 100;

--LOWER(컬럼명), UPPER(컬럼명)
select first_name,
        lower(first_name) "전체소문자",
        upper(first_name) "전체대문자"
from employees
where department_id = 100;

--substr(컬럼명,시작위치,글자수)
--원래 글자에서 해당부분만 가져올때(어떤것을 어디서부터 몇글자)
select first_name,
        substr(first_name, 1, 3), --0번째없다. 바로 1번째부터
        substr(first_name, -3, 2) -- -정수의 경우, 뒤에서부터 
from employees
where department_id = 100;

--lpad(컬럼명,자리수,'채울문자'), rpad
-- 글자수를 맞추고 부족한 문자는 채울문자로 왼쪽에 채움 
select first_name,
        lpad(first_name, 10, '*'),
        rpad(first_name, 10, '*')
from employees;

--replace(컬럼명, '수정할 문자1', '바꿀 문자2')
--기존 글자수 상관없이 순수하게 문자1을 문자2로 변경해줌
select first_name,
        replace(first_name, 'a', '*')
from employees
where department_id = 100;

--응용) 당첨자 아이디 가리기
select first_name,
        replace(first_name, 'a', '*'),
        replace(first_name, substr(first_name, 2, 3),'***')
from employees
where department_id = 100;
--------------------------------------------
--숫자함수
-- round(숫자, 출력을 원하는 자리의 수 )
select 123
from employees;

--가상의 테이블 dual
select 123
from dual; 

--round(숫자, 출력을 원하는 자리수) 반올림 
select round(123.346, 2) "r2",
        round(123.656, 0) "r0", --0번째는 정수부분만 출력
        round(123.456, -1) "r-1", --정수 부분
        round(123.856, -1) "r-1" --정수 부분
from dual; 

--trunc(숫자, 출력을 원하는 자리수)
-- 주어진 숫자 버림(반올림아님)
select trunc(123.346, 2) "r2",
        trunc(123.956, 0) "r0",
        trunc(123.456, -1) "r-1"
from dual;
-----------------------------------------------
--날짜함수 sysdate 현재 날짜
select sysdate
from dual;

--month_between(날짜1, 날짜2)큰 수에서 작은 수 빼주는 개념
select hire_date,
        sysdate,
        trunc(months_between(sysdate, hire_date),0),
        months_between(sysdate, hire_date),
        months_between(hire_date, sysdate)
from employees
where department_id = 100;

--to_char(숫자, '출력모양') 숫자 -> 문자
select first_name,
        salary,
        salary*12,
        to_char(salary*12, '$9999999'), --$999는 9는 자릿수
        tO_char(salary*12, '099999'), --빈자리를 0으로 채워라(다른 숫자 넣을 수 없음)
        to_char(salary*12, '999999.99'), --소수점 두자리 수 까지 표현하라 
        to_char(salary*12*12, '999,999,999'),
        to_char(salary*12*12, '999,999,999.000') --소수점도 표현
from employees
where department_id = 100;

--to_char 날짜->문자
select sysdate,
        to_char(sysdate, 'yyyy') 연도,
        to_char(sysdate, 'yy') 두자리,
        to_char(sysdate, 'mm') 월, --숫자까지만 출력
        to_char(sysdate, 'month') 월이나옴,
        to_char(sysdate, 'dd') 일
from dual;

--시간 
select sysdate,
        to_char(sysdate, 'hh'),
        to_char(sysdate, 'hh24'), 
        to_char(sysdate, 'mi'), -->분
        to_char(sysdate, 'ss')
from dual;

--날짜 시간 총합
select sysdate,
        to_char(sysdate, 'yyyy-mm-dd'),
        to_char(sysdate, 'yyyy/mm/dd hh24:mi:ss'),
        to_char(sysdate, 'yyyy"년"mm"월"dd"일" hh24:mi:ss'),
        to_char(sysdate, 'yyyy/mm/dd dy hh24:mi:ss')
from dual;
----------------------------------------------------
--일반함수 NVL , NVL2
select first_name,
        commission_pct,
        nvl(commission_pct, 0),
        nvl2(commission_pct, 100, 0) --> nvl2(컬럼명, null이아닐때, null일때)
from employees;


