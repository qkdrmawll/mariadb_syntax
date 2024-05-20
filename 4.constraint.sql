-- not null 조건 추가
alter table 테이블명 modify column 컬럼명 타입 not null;

-- auto_increment
alter table author modify column id bigint auto_increment;

-- author.id 제약조건 추가시 fk로 인해 문제 발생
-- ->fk 먼저 제거 이후에 author.id에 제약 조건 추가
select * from information_schema.key_column_usage where table_name = 'post';
alter table post drop foreign key post_ibfk_1;

-- 삭제된 제약 조건 다시 추가
alter table post add constraint post_ibfk_1 foreign key(author_id) references author;

-- uuid : 특정 항목을 전 세계적으로 유일하게 식별
alter table post add column user_id char(36) default (UUID());

-- unique 제약 조건 -> index가 생성됨
alter table author modify column email varchar(255) unique;
show index from author;

-- on delete cascade 테스트 -> 부모 테이블의 id를 수정하면 수정안됨
select * from information_schema.key_column_usage where table_name = 'post';
alter table post drop foreign key post_ibfk_1;
alter table post add constraint post_ibfk_1 foreign key(author_id) references author(id) on delete cascade;

-- on update cascade
alter table post add constraint post_ibfk_1 foreign key(author_id) references author(id) on delete cascade on UPDATE cascade;

-- delete는 set null, update는 cascade로 변경
alter table post add constraint post_ibfk_1 foreign key(author_id) references author(id) on delete set null on update cascade;