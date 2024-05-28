# local에서 sql 덤프 파일 생성
mysqldump -u root -p  board > dumpfile.sql

# 한글 깨질 때
mysqldump -u root -p  board -r dumpfile.sql

# dump 파일을 github에 업로드
# 리눅스에서 mariadb 설치
sudo apt-get install mariadb-server

# mariadb 서버 시작
sudo systemctl start mariadb

# mariadb 접속 테스트
sudo mariadb -u root -p

# git clone 받기
git clone 리포지토리

# 덤프 파일을 통해 데이터베이스 복원
mysql -u root -p board < dumpfile.sql