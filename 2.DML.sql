-- insert into : 데이터 삽입
insert into 테이블명(컬럼1, 컬럼2, 컬럼3) values(데이터1, 데이터2, 데이터3);
insert into author(id, name, email) values(1,'eunji','eunji@test.com');
insert into posts(id, title, content, author_id) values(1,'제목','내용',1);

-- select : 데이터 조회, * : 모든 컬럼 조회
select * from author;

-- 테이블 제약 조건 조회
-- information_schema의 key_column_usage라는 컬럼 중 table_name이 posts인 것을 조회
select * from information_schema.key_column_usage where table_name = 'posts';

insert into author(id, name, email,password,address) values(2, hong, hong@naver.com,1234,1234);
insert into author(id, name, email,password,address) values(2, 'hong', 'hong@naver.com','1234','1234');

-- update 테이블명  set 컬럼명=데이터 where 조건;
-- 덮어쓰기 x, 지정 속성만 변경
-- where문을 빠뜨리게 될 경우, 모든 데이터에 update문이 적용됨에 유의
update author set name = abc, email='abc@test.com' where id=1; 
update author set email='abc2@test.com' where id=2;

-- delete from 테이블명 where 조건;
-- where문이 생략 될 경우, 모든 데이터에 delete문이 적용됨에 유의
delete from author where id=5;

-- select문의 다양한 조회 방법
select * from author;
select * from author where id=1;
select * from author where id>2;
select * from author where id>2 and name=bang;

-- 특정 컬럼만을 조회할때
select name, email from author where id=3;

-- 중복제거하고 조회하기
select distinct title from post;

-- 정렬 : order by, 데이터의 출력 결과를 특정 기준으로 정렬
-- 정렬 조건 없이 조회할 경우, pk를 기준으로 오름차순 정렬
-- asc :오름차순, desc: 내림차순
select * from author order by name asc;

-- multi order by : 여러 컬럼으로 정렬
-- 먼저 쓴 컬럼 우선 정렬, 그다음 정렬 옵셥 적용
select * from post order by title;
select * from post order by title, id desc;

-- limit number  특정 숫자로 결과값 개수 제한
select * from author order by id desc limit 1;

-- alias(별칭)을 이용한 select : as 키워드 사용
select name as 이름, email as 이메일 from author;
select a.name as 이름, a.email as 이메일 from author as a;

-- null을 조회조건으로 
select * from post where author_id is null;
select * from post where author_id is not null;
