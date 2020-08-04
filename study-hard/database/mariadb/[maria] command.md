### db 접속
```mysql based
mysql -u root
```
- U를 대문자로 입력하면 `Ignoring query to other database` 오류남

### db 생성
```mysql based
CREATE DATABASE <DBNAME>
```

### 사용자 관련
```mysql based
SELECT HOST, USER, PASSWORD FROM MSYQL.USER;
CREATE USER '<ID>'@'%' IDENTIFIED BY '<PASSWD>'@'%';
GRANT ALL PRIVILEGES ON <DBNAME>.* TO '<ID>'@'%';
FLUSH PRIVILEGES;
```
- 사용자 조회, 생성, 권한부여, 새로고침
