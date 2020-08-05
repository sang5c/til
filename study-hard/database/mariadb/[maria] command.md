### db 접속
```mysql based
mysql -u root
```
- U를 대문자로 입력하면 `Ignoring query to other database` 오류남

### db 생성
```mysql based
CREATE DATABASE <DBNAME>
```

### 컬럼(스키마) 조회
```mysql based
SHOW COLUMNS FROM <TABLE NAME>
```

### 사용자 관련
```mysql based
SELECT HOST, USER, PASSWORD FROM MSYQL.USER;

CREATE USER '<ID>'@'%' IDENTIFIED BY '<PASSWD>'@'%';

GRANT ALL PRIVILEGES ON <DBNAME>.* TO '<ID>'@'%';

FLUSH PRIVILEGES;

UPDATE USER 
SET password = password('비밀번호') 
WHERE user = 'username';
```
- 사용자 조회, 생성, 권한부여, 새로고침
- 권한제외는 REVOKE
- '%'은 외부 접속을 의미한다.

GRANT 종류
- CREATE, ALTER, DROP
- SELECT, INSERT, UPDATE, DELETE
- RELOAD
- SHUTDOWN
- ALL
- USAGE
    - 사용자 추가 권한
