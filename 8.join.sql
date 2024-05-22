-- inner join
-- 두 테이블 사이에 지정된 조건에 맞는 레코드만 반환. on 조건을 통해 교집합 찾기
select * from author inner join post on author.id=post.author_id;
select * from author a inner join post p on a.id=p.author_id;

-- 글쓴이가 있는 글 목록(id,title,contents)과 글쓴이의 이메일을 출력
-- 익명 글은 다 날아감 -> inner join이 교집합을 찾는 것이기 때문
select p.id, p.title, p.contents, a.email from post p inner join author a on p.author_id=a.id;

-- 모든 글목록을 출력하고, 만약에 글쓴이가 있다면 이메일을 출력
select * from post left join author on post.author_id=author.id;
select p.id, p.title , p.title, a.email  from post p left join author a on p.author_id=a.id;

-- join된 상황에서 where 조건 : on 뒤에 where 조건이 나옴
-- 1) 글쓴이가 있는 글 중에 글의 title과 저자의 email을 출력, 이때 저자의 나이는 25세 이상
select p.title, a.email from post p inner join author a on p.author_id=a.id WHERE a.age >=25;
-- 2) 모든 글 목록 중에 글의 title과 저자가 있다면 email을 출력, 이때 2024-05-01 이후에 만들어진 글만 출력
select p.title, a.email FROM post p left join author a on p.author_id  = a.id WHERE p.created_time > '2024-05-01';
select p.title, a.email FROM post p left join author a on p.author_id  = a.id where DATE_FORMAT(p.created_time) > '2024-05-01';

-- 글을 안 쓴 글쓴이 출력
select a.id, a.email from author a left join post p on p.author_id=a.id where p.author_id is null;

-- union : 중복제외한 두 테이블의 select을 결합
-- 컬럼의 개수와 타입이 같아야 함에 유의
-- union all : 중복 포함
select 컬럼1, 컬럼2 from table1 union select 컬럼1, 컬럼2 from table2;
-- author table의 name, email 그리고 post 테이블의 title, contents
select name, email from author union select title, contents from post;

-- 서브쿼리 : select문 안에 또 다른 select문을 서브쿼리라 한다
-- select절 안에 서브쿼리
-- author email과 해당 author가 쓴 글의 개수를 출력
select email, (select count(*)from post p where p.author_id = a.id) as count from author a ;
select a.id, if(p.id is null,0,count(*)) from author a left join post p on a.id=p.author_id group by a.id;

-- from절 안에 서브쿼리
select a.name from (select * from author) as a;

-- where절 안에 서브쿼리
-- 글을 쓴 글쓴이만 출력
select a.* from author a inner join post p on a.id = p.author_id;
select * from author where id in (select author_id from post);

-- 집계함수
select COUNT(*) from author;
select sum(price) from post;
select avg(price) from post;
select round(avg(price),0) from post;

-- group by와 집계함수
select author_id, count(*) from post group by author_id;

-- where와 group by
-- 연도별 post 글 출력, 연도가 null인 데이터는 제외
select date_format(created_time,'%Y') as year ,count(*) from post p where created_time is not null group by year;

-- HAVING : group by를 통해 나온 통계에 대한 조건
select count(*) from post group by author_id;
select count(*) as count from post group by author_id having count>=2;
--(실습) 포스팅 price가 2000원 이상인 글을 대상으로, 작성자별로 몇건인지와 평균 price를 구하되 평균price가 3000원 이상인 데이터를 대상으로만 통계 출력
select author_id , count(*), avg(price) as ap from post where price>=2000 group by author_id having ap>=3000;
-- (실습) 1건 이상의 글을 쓴 사람의 id와 name을 구할건데, 나이는 25세 이상인 사람만 통계에 사용하고, 가장 나이가 많은 사람 1명의 통계만 출력
select a.id, a.name from post p inner join author a group by author_id having count(*)>=2;

-- 다중열 group by
select author_id, title, count(title) from post group by author_id, title;