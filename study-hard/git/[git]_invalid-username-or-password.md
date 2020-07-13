### 문제

```bash
git push

remote: Invalid username or password.
fatal: Authentication failed for 'https://github.com/sang5c/til.git/'
```

- github 비밀번호 변경해서 발생함

### 처리

```bash
git remote remove origin
git remote add origin https://github.com/sang5c/til.git
git push --set-upstream origin master
```

이외에 set-url을 사용하는 방법이 있었으나 공개키 갱신 등의 작업을 해야하길래 더 쉬운 방법으로 대체함.

### 참고

- [보고 해결한거](https://m.blog.naver.com/PostView.nhn?blogId=xyz37&logNo=220056104469&proxyReferer=https:%2F%2Fwww.google.com%2F)
- [set-url 사용하는 방법](https://stackoverflow.com/questions/29297154/github-invalid-username-or-password)
