-- 데이터베이스 접속
mariadb -u root -p

-- 스키마(database) 목록 조회
show databases;

-- 스키마(database) 생성
create DATABASE board;

-- 데이터베이스 선택
use board;

-- 테이블 조회
show tables;

-- author 테이블 생성
create table author(id INT PRIMARY KEY, name VARCHAR(255), email VARCHAR(255), password VARCHAR(255));

-- 테이블 컬럼 조회
describe author;

-- 컬럼 상세 조회
show full columns from author;

-- 테이블 생성문 조회
show create table author;

-- posts 테이블 생성
-- foreign key(author_id) references author(id) 테이블 차원의 foreign key, 제약조건 author 의 id를 침조
create table posts(id int primary key, title varchar(255), content varchar(255), author_id int, foreign key(author_id) references author(id));

-- 테이블 index 조회
show index from author;
show index from posts;

-- ALTER문 : 테이블의 구조를 변경
-- 테이블 이름 변경
alter table posts rename post;

-- 테이블 컬럼 추가
alter table author add column test1 varchar(50);
alter table author add column address varchar(255);

-- 테이블 컬럼 삭제
alter table author drop column test1;

-- 테이블 컬럼명 변경
alter table post change column content contents;

-- 테이블 컬럼 타입과 제약조건 변경, 컬럼이 아래 변경 사항으로 덮어쓰기
alter table author modify column email varchar(255) not null;
alter table post modify column title varchar(255) not null;
alter table post modify column contents varchar(3000);

-- 테이블 삭제
drop post;