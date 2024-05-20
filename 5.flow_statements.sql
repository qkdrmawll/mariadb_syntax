-- 흐름제어 : case문
select 컬럼1, 컬럼2, 컬럼3,
case 컬럼 4
    when [비교값1] then 결과값1
    when [비교값2] then 결과값2
    else 결과값3
end
from 테이븖명;

-- post 테이블에서 1번 user는 first author, 2번 user는 second author
select id,title, contents,
case author_id
    when 1 then 'first author'
    when 2 then 'second author'
    else 'others'
end
from post;

-- author_id가 있으면 그대로 출력, 없으면 익명 출력
select id,title, contents,
case
    when author_id is null then '익명'
    else author_id 
end as author_id 
from post;

-- 위 케이스 문을 ifnull 구문으로 변환
select id,title,contents, ifnull(author_id, '익명') from post;

-- 위 케이스 문을 if 구문으로 변환
select id, title, contents, if(author_id is null,'익명',author_id) from post;