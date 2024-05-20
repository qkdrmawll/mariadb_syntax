-- dirty read 동시성 이슈 실습
-- 한 트랜잭션이 다른 트랜잭션이 수정 중인 데이터를 읽을 수있는 문제
-- 워크벤치에서 auto_commit 해재 후 update 실행 -> commit이 안된 상태 (워크벤치에는 임시저장 상태)
-- 터미널을 열어서 select 했을 때 위 변경사항이 변경됐는지 확인

--phantom read 동시성 이슈 실습
-- 워크벤치에서 시간을 두고 2번의 select가 이루어지고, 터미널에서 중간에 insert 실행-> 2번의 select 결과값이 동일한지 확인
start transaction;
select * from author;
do sleep(15);
select * from author;
commit;
-- 터미널
insert into author(name,email) values ('kim', 'jip@want');

-- lost update 이슈를 해결하기 위한 공유락 (shared lock)
start transaction;
select post_count from author where id=1 lock in share mode;
do sleep(15);
select post_count from author where id=1 lock in share mode;
commit;
-- 터미널
select post_count from author where id=1 lock in share mode;
update author set post_count=0 where id=1;

-- 배타적 잠금 (exclusive lock) : select for update
-- select 부터 잠금
start transaction;
select post_count from author where id=1 for update;
do sleep(15);
select post_count from author where id=1 for update;
commit;
-- 터미널
select post_count from author where id=1 for update;
update author set post_count=0 where id=1;