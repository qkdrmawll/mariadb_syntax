# redis 설치
sudo apt-get update
sudo apt-get install redis-server

# redis 접속
# cli : command line interface
redis-cli

# redis는 0~15번까지의 database 구성
# 데이터베이스 선택 
select 번호(0번디폴트)

# 데이터베이스 내 전체 key 조회
keys *

# 일반 string 자료구조
# key:value 값 세팅
# key값은 중복되면 안됨 
SET key(키) value(값)
set test_key1 test_value1
set user:email:1 hongildong@naver.com
# set할 때 key값이 이미 존재하면 덮어쓰기 되는 것이 기본
# 맵 저장소에서 key값은 유일하게 관리가 되므로
# nx : not exist -> 존재하지 않을 때만 적용하겠다는 옵션
set user:email:1 hongildong@naver.com nx 
# ex(만료시간-초단위) - ttl(time to live) 
set user:email:2 hongildong2@naver.com ex 20

# get을 통해 value값 얻기
get test_key1

# 특정 key 삭제
del user:email:1

# 현재 데이터베이스의 모든 key 삭제
flushdb

# 좋아요 기능 구현
set likes:posting:1 0
incr likes:posting:1 # 특정 key값의 value를 1만큼 증가
decr likes:posting:1
get likes:posting:1

# 재고 기능 구현
set product:1:stock 100
decr product:1:stock
get product:1:stock

# bash쉘을 활용하여 재고감소 프로그램 작성
redis_stock.sh

# 캐싱 기능 구현
# 1번 author 회원 정보 조회
# select name, email, age from author where id=1;
# 위 데이터의 결과값을 redis로 캐싱 : json 데이터 형식으로 저장
set user:1:detail "{\"name\":\"hong\", \"email\":\"hong@naver.com\", \"age\":30}" ex 10

# list
# redis의 list는 java의 deque와 같은 구조 즉,double-ended queue구조
# 데이터 왼쪽 삽입
LPUSH key value
# 데이터 오른쪽 삽입
RPUSH key value
# 데이터 왼쪽부터 꺼내기
LPOP key
# 데이터 오른쪽부터 꺼내기
RPOP key
#  데이터 개수 조회
LLEN key

lpush hongildongs hong1
lpush hongildongs hong1
lpush hongildongs hong1
lpop hongildongs
llen hongildongs

# list의 요소 조회시에는 범위 지정
# 0 -1 처음부터 끝까지
lrange hongildongs start end 
lrange hongildongs 0 -1 

# TTL 적용
expire hongildongs 30

# TTL 조회
ttl hongildongs

# 꺼내서 없애는게 아니라, 꺼내서 보기만
lrange hongildongs -1 -1
lrange hongildongs 0 0

# pop과 push 동시에
RPOPLPUSH A리스트 B리스트

# 어떤 목적으로 사용될 수 있을까?
# 최근 방문한 페이지
# 5개 정도 데이터 push
# 최근 방문한 페이지 3개를 보여주기
lpush recently_visit naver
lpush recently_visit daum
lpush recently_visit kakao
lpush recently_visit google
lpush recently_visit nate

lrange recently_visit 0 2

# 방문 페이지 5개에서 뒤로가기 구현
rpush forwards naver
rpush forwards daum
rpush forwards kakao
rpush forwards google
rpush forwards nate

rpoplpush forwards backwards 

# 최근 본 상품 목록 -> 다시 본 상품이 또 리스트에 들어가면 안되기 때문에 sorted set을 사용하는 것이 적절하다

# set 자료구조
# set 자료구조에 멤버추가
# 중복이 제거된다
sadd members member1
sadd members member1
sadd members member2

# set 조회
smembers members

# set에서 멤버 삭제
srem members member2

# set멤버 개수 반환
scard members

# 특정 멤버가 set안에 있는지 존재 여부 확인
sismember members member3

# 매일 방문자수 계산
# 재방문은 count하지 않음
sadd visit:2024-05-27 hong1@naver.com

# zset (sorted set)
zadd zmembers 3 member1
zadd zmembers 4 member2
zadd zmembers 1 member3
zadd zmembers 2 member4

# score 기준 오름차순 정렬
zrange zmembers 0 -1

# score 기준 내림차순 정렬
zrevrange zmembers 0 -1

# zset 삭제
zrem zmembers members2

# zrank는 해당 멤버가 몇번째 index인지 출력
zrank zmembers member2

# 최근 본 상품목록
zadd recent:products 192411 apple
zadd recent:products 192413 apple
zadd recent:products 192415 banana
zadd recent:products 192417 orange
zadd recent:products 192420 apple

zrevrange recent:products 0 2

# hashes 
hset product:1 name "apple" price 1000 stock 50
hget product:1 name
hget product:1 price
hget product:1 stock
# 모든 객체 값 get
hgetall product:1
# 특정 요소 값 수정
hset product:1 stock 40
# 특정 요소의 값을 증가
hincrby product:1 stock 5
# 특정 요소의 값을 감소
hincrby product:1 stock -5