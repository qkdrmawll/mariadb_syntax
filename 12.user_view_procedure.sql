-- 사용자 관리
-- 사용자 목록 조회
select * from mysql.user;

-- 사용자 생성
-- %는 원격 포함한 anywhere 접속
create user 'test1'@'localhost' identified by '4321';
create user 'test1'@'%' identified by '4321';

-- 사용자에게 select 권한 부여
grant select on board.author to 'test1'@'localhost';
grant select on board.author to 'test1'@'%';

-- 사용자 권한 회수
revoke select on board.author from 'test1'@'localhost';
revoke select on board.author from 'test1'@'%';

-- 환경설정을 변경 후 확정
flush privileges;

-- test1으로 로그인 후 조회
select * from board.author;

-- 권한 조회
show grants for 'test1'@'localhost';

-- 사용자 계정 삭제
drop user 'test1'@'localhost'

-- view
-- view 생성
-- name과 age, role만 조회할 수 있는
create view author_for_marketing_team as select name, age, role from author;

-- view 조회
select * from author_for_marketing_team;

-- 테스트 계정에 view select 권한 부여
grant select on board.author_for_marketing_team to 'test1'@'%';

-- view 변경
create or replace view author_for_marketing_team as select name, email, age, role from author;

-- view 삭제
drop view author_for_marketing_team;

-- 프로시저 생성
DELIMITER //
CREATE PROCEDURE test_procedure()
BEGIN
        select "hello world" ;
END
// DELIMITER ;

-- 프로시저 호출
call test_procedure();

-- 프로시저 삭제
drop procedure test_procedure;

-- 게시글 목록 조회 프로시저 생성
DELIMITER //
CREATE PROCEDURE 게시글목록조회()
BEGIN
    select * from post;
END
// DELIMITER ;

call 게시글목록조회();

-- postId를 통한 게시글 단건 조회
DELIMITER //
CREATE PROCEDURE 게시글단건조회(in postId int)
BEGIN
    select * from post where id = postId;
END
// DELIMITER ;

call 게시글단건조회(3);

-- 저자id와 제목을 통한 게시글 단건 조회
DELIMITER //
CREATE PROCEDURE 게시글단건조회(in 저자id int, in 제목 varchar(255))
BEGIN
    select * from post where author_id = 저자id and title=제목;
END
// DELIMITER ;

call 게시글단건조회(4,'hello');

-- 글쓰기 (author_id)
DELIMITER //
CREATE PROCEDURE 게시글생성(in 저자id int, in 제목 varchar(255), in 내용 varchar(3000))
BEGIN
    insert into post(title, contents, author_id) values(제목, 내용, 저자id);
END
// DELIMITER ;

call 게시글생성(1,'hello', 'world');

-- 글쓰기2 (email)
DELIMITER //
CREATE PROCEDURE 게시글생성2(in 이메일 varchar(255), in 제목 varchar(255), in 내용 varchar(3000))
BEGIN
    declare authorId int;
    select id into authorId from author where email = 이메일;
    insert into post(title, contents, author_id) values(제목, 내용, authorId);
END
// DELIMITER ;

call 게시글생성2('hong1@naver.com','hello', 'world');

-- sql에서 문자열 합치는 명령어 concat('hello','world');
-- 글 상세 조회 : input 값 postId
-- title, contents, '홍길동' + '님'

DELIMITER //
CREATE PROCEDURE 게시글상세조회(in postId int)
BEGIN
    select title, contents , concat(a.name,'님') from post p inner join author a on p.author_id = a.id where p.id = postId;
END
// DELIMITER ;

call 게시글상세조회(1);

DELIMITER //
CREATE PROCEDURE 게시글상세조회(in postId int)
BEGIN
    declare authorName varchar(255);
    select name into authorName from author where id = (select author_id from post where id = postId);
    set authorName = concat(authorName, '님')
    select title, contents , authorName from post p where p.id = postId;
END
// DELIMITER ;

call 게시글상세조회(1);

-- 등급조회
-- 글을 100개 이상 쓴 사용자는 고수입니다. 출력
-- 글을 10개 이상 100개 미만이면 중수입니다.
-- 그외는 초보입니다. 
-- input값 : email 값
DELIMITER //
CREATE PROCEDURE 등급조회(in 이메일 varchar(255))
BEGIN
    declare authorId int;
    declare count int;
    select id into authorId from author where email = 이메일;
    select count(*) into count from post where author_id = author_id;
    if count >= 100 then 
        select '고수입니다.';
    elseif count>=10 then
        select '중수입니다.';
    else
        select '초보입니다.';
    end if;
END
// DELIMITER ;
call 등급조회('hong1@naver.com');


-- 반복문을 통해 post 대량 생성
-- 사용자가 입력한 반복 횟수에 따라 글이 도배되는데, title은 '안녕하세요'
CREATE PROCEDURE 글도배(in 반복횟수 int)
BEGIN
    declare a int;
    set a = 0;
    while (a < 반복횟수) do
        insert into post(title) values('안녕하세요');
        set a = a + 1
    end while
END
// DELIMITER ;

-- 프로시저 생성문 조회
show create procedure 프로시저명;

-- 프로시저 권한 부여
grant execute on board.프로시저명 to 'test1'@'localhost';