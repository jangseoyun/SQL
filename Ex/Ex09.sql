--★webdb계정에 book테이블 생성
create table book(
    book_id number,
    title varchar2(50),
    author varchar2(10),
    pub_date date
);

--book 테이블에 pubs 컬럼 추가
alter table book add(pubs varchar2(50));

--book테이블에 컬럼속성 변경하기
alter table book modify(title varchar2(100));

--컬럼명 변경하기
alter table book rename column title to subject;

--컬럼 삭제
alter table book drop(author);

--테이블명 변경하기
rename book to article;

--테이블 삭제
drop table article;

----------------------------------------------------
--★제약조건 포함된 테이블 생성

create table author(
    author_id number(10),
    author_name varchar2(100) not null,
    author_desc varchar2(500),
    primary key(author_id)
);

--book 테이블 만들기 
create table book(
    book_id number(10),
    title varchar2(200) not null,
    pubs varchar2(100),
    pub_date date,
    author_id number(10),
    primary key(book_id),
    CONSTRAINT book_fk FOREIGN key (author_id)
    REFERENCES author(author_id)    
);

--작가 (author) 테이블에 데이터 추가(insert)
-- 묵시적 방법
insert into author
values(1, '박경리', '토지 작가');

--명시적 방법
insert into author(author_id, author_name)
values (2, '이문열');
--동일한 결과
insert into author( author_name, author_id)
values ('이문열', 2);

insert into author 
values (3, '기안84', '웹툰작가');

--작가 테이블 정보(데이터) 수정
--조건절을 통해서 단일 혹은 다중으로 데이터를 변경할 수 있다.
--where절 없으면 전체 변경
update author
set author_name = '김경리',
    author_desc = '토지작가'
where author_id = 1;

--작가 테이블 정보(필드) 삭제
--where절쓰지 않으면 전체 삭제 됨 
delete from author
where author_id = 1;

--시퀀스 sequence ex) 번호표 
create sequence seq_author_id
increment by 1 --> 한번에 몇씩 올라가게 할 것 인가
start with 1 --> 시작번호 지정 
nocache;

--★시퀀스 적용한 최종 데이터 넣는 방법
insert into author
values(seq_author_id.nextval, '박경리', '토지 작가');

insert into author
values(seq_author_id.nextval, '이문열', '삼국지 작가');

--시퀀스 전체 조회하기
select *
from user_sequences;

--현재 시퀀스 조회 (조회는 카운트 포함되지 않음)
select seq_author_id.currval
from dual;

--다음 시퀀스 조회(조회 카운트에 포함됨)
select seq_author_id.nextval
from dual;

--시퀀스 삭제
drop sequence seq_author_id;

select *
from author;

-------------------------------------
--시퀀스 삭제
drop sequence seq_author_id;
--테이블 삭제 --> 테이블 삭제시 pk fk가 연결되어 있기 때문에 
--fk 속한 테이블부터 먼저 지운다, 데이터를 지우려고해도 먼저 fk해당 부분을 제거하고 pk row제거
drop table author;
drop table book;