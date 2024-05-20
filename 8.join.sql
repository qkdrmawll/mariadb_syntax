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