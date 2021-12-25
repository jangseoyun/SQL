--★Practice06.
--테이블 생성/조인/제거

-- book 시퀀스 생성
create sequence seq_book_id
increment by 1
start with 1
nocache;

-- author 시퀀스 생성
create sequence seq_author_id
increment by 1
start with 1
nocache;

-----------------------------------------------------------
--★테이블 생성

--book 테이블 생성
create table book(
    book_id number(5),
    title varchar2(50) not null,
    pubs varchar2(50),
    pub_date date,
    author_id number(10),
    
    primary key(book_id),
    constraint book_fk foreign key(author_id)
    references author(author_id)
);

create table author(
    author_id number(5),
    author_name varchar2(50) not null,
    author_desc varchar2(50),

    primary key(author_id)
);

-----------------------------------------------------------
--★데이터 삽입
--book 테이블 데이터 삽입
--#1
insert into book
values(seq_book_id.nextval,'우리들의 일그러진 영웅','다림','1998-02-22',1);
--#2
insert into book
values(seq_book_id.nextval,'삼국지','민음사','2002-03-01',1);
--#3
insert into book
values(seq_book_id.nextval,'토지','마로니에북스','2012-08-15',2);
--#4
insert into book
values(seq_book_id.nextval, '유시민의 글쓰기 특강', '생각의길','2015-04-01',3);
--#5
insert into book
values(seq_book_id.nextval, '패션왕', '중앙북스(books)','2012-02-22',4);
--#6
insert into book
values(seq_book_id.nextval, '순정만화', '재미주의', '2011-08-03', 5);
--#7
insert into book
values(seq_book_id.nextval, '오직두사람','문학동네','2017-05-04',6);
--#8
insert into book
values(seq_book_id.nextval, '26년', '재미주의', '2012-02-04', 5);

-----------------------------------------------------------
--#author 테이블 데이터 삽입
--#1
insert into author
values(seq_author_id.nextval, '김문열', '경북 영양');
--#2
insert into author
values(seq_author_id.nextval, '박경리', '경상남도 통영');
--#3
insert into author
values(seq_author_id.nextval, '유시민', '17대 국회의원');
--#4
insert into author
values(seq_author_id.nextval, '기안84', '기안동에서 산 84년생');
--#5
insert into author
values(seq_author_id.nextval, '강풀', '온라인 만화가 1세대');
--#6
insert into author
values(seq_author_id.nextval, '김영하', '알쓸신잡');
-----------------------------------------------------------
--#select문 join

select *
from book bk, author at
where bk.author_id = at.author_id;

-----------------------------------------------------------
--#강풀의 author_desc 정보를 ‘서울특별시’ 로 변경해 보세요

update author
set author_desc = '서울특별시'
where author_name = '강풀';

--#author 테이블에서 기안84 데이터를 삭제해 보세요  삭제 안됨
-- 사용중인 fk삭제 이후 해당 pk 삭제

delete from book
where author_id = 4;

delete from author
where author_id = 4;

commit;
