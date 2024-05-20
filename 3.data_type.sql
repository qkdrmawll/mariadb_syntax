-- tinyint는 -128~127까지 표현
-- author 테이블에 age 컬럼 추가
alter table author add column age tinyint;

insert into author(id, email, age) values(5, 'hello@naver.com',125);

alter table author modify column age tinyint unsigned;
insert into author(id, email, age) values(6, 'hello@naver.com',200);

-- decimal 실습
-- 총 10개의 자릿수에 3자리가 소수부
alter table post add column price decimal(10,3);

-- decimal 소수점 초과 값 입력 후 짤림 확인
insert into post(id,title,price) values(7,'hello',3.12312);

-- update : price 1234.1
update post set price=1234.1 where id=7;

-- blob 바이너리데이터 실습
-- author 테이블에 profile_image 컬럼을 blob형식으로 추가
alter table author add column profile_image blob;
insert into author(id, email, profile_image) values(6, 'eunji@naver.com', LOAD_FILE('이미지 경로'));

-- enum : 삽입될 수 있는 데이터 종류를 한정하는 데이터 타입
-- role 컬럼
alter table author add column role enum('user', 'admin') not null;
alter table author modify column role enum('admin', 'user') not null default 'user';

-- date 타입
-- author 테이블에 birth_day 컬럼을 date로 추가
-- 날짜 타입의 insert는 문자열 형식으로 insert
alter table author add column birth_day date;
insert into author(id, email, birth_day) values(10, 'eunji@naver.com', '2001-06-19');

-- datetime 타입
-- author, post 둘다 create_time 컬럼을 datetime으로 추가
alter table author add column created_time datetime;
alter table post add column created_time datetime;

insert into author(id, email, created_time) values(13, 'eunji@naver.com', '2024-05-17 12:00:00');
insert into post (id, title , created_time) values(6, '제목', '2024-05-17 12:00:00');

-- 자동으로 현재 시간 추가
alter table author modify column created_time datetime default current_timestamp;

-- 비교연산자
-- and 또는 &&
select * from post where id >= 2 and id <= 4;
select * from post where id between 2 and 4;
-- or 또는 ||
-- not 또는 !
select * from post where not(id < 2 or id > 4);

-- NULL인지 아닌지
select * from post where contents is null;

-- in(리스트 형태), not in(리스트 형태)
select * from post where id in (1,2,3,4);
select * from post where id not in (1,2,3,4);

-- like : 특정 문자를 포함하는 데이터를 조회하기 위해 사용하는 키워드
select * from post where title like '%o' #o로 끝나는 title 검색
select * from post where title like 'h%' #h로 시작하는 title 검색
select * from post where title like '%l%' #단어의 중간에 l라는 키워드가 있는 경우 검색
select * from post where title not like '%o' #o로 끝나는 title이 아닌 것을 검색

-- ifnull(a,b) : 만약에 a가 null이면 b 반환, null이 아니면 a 반환
select title, contents, author_id from post;

-- REGEXP : 정규표현식을 활용한 조회
select * from author where name regexp '[a-z]';
select * from author where name regexp '[가-힣]';

-- 날짜 변환 : 숫자 -> 날짜, 문자 -> 날짜
-- CAST와 CONVERT
select CAST(20200101 AS DATE);
select CAST('20200101' AS DATE);
select CONVERT(20200101 , DATE);
select CONVERT('20200101' , DATE);

-- 05 -> 5 형식으로 변경
SELECT cast(DATE_FORMAT(created_time, '%m') as unsigned) from post;



-- datetime 타입 조회 방법
select * from post where created_time like '2024-05%';
select * from post where created_time <= '2024-12-31' and created_time>='1999-01-01';
select * from post where created_time between '1999-01-01' and '2024-12-31';

-- date_format
select date_format(created_time, '%Y-%m') from post;
select * from post where DATE_FORMAT(created_time, '%Y') ='2024';

-- 오늘 날짜 출력
select now();