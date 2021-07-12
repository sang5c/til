# windows 에서 linux로 파일 전달시 CRLF가 문제를 발생시킬 수 있다.

date
- 2021-07-12

---

문제가 되었던 코드는 [깃허브](https://github.com/sang5c/til/tree/main/study-hard/docker/book/chapter03) 에서 볼 수 있다.

도커/컨테이너를 활용한 컨테이너 개발 실전 입문이라는 책의 예제를 따라하던 중에 정상 동작하지 않는 예제를 만나서 고생했다. 

docker container를 생성해서 내부에서 cron을 통해 간단한 echo 스크립트를 실행시키는 내용이었는데, cron이 동작하지 않았다. 
원인은 windows에서 작성한 파일의 개행문자가 LF(Line Feed)가 아닌 CRLF(Carriage Return Line Feed)였기 때문이고, 
이것 때문에 스크립트가 먹통이었다. 인지하고 있음에도 docker와 cron쪽이 익숙치 않아 바로 해답으로 연결하지 못하고 헤매게 되었다.

이것저것 수정하다보니 중간에 정상 동작하는 경우가 있었는데 그땐 왜 됐는지 정확히 모르겠다. 
아얘 안됐으면 차라리 답을 찾기 수월했겠다 싶다.
여러 방법으로 파일을 열어봤는데 vi에서 확인을 해도 CR 문자(^M)가 보이지 않는 것도 당황을 선사했다.

![vi](https://github.com/sang5c/til/blob/main/blog/images/Untitled.png)

해결하려면 에디터에서 Line separator 설정을 LF로 바꿔주면 된다. VS Code, Intellij 동일하게 우측 하단에 있다.

![line separator](https://github.com/sang5c/til/blob/main/blog/images/Untitled%201.png)

아래는 관련 있는  명령어, 개념 등을 정리한 내용이다.

## CRLF

CR(carriage return, \r) LF(Line Feed, \n)

윈도우의 개행문자는 CRLF이고, 이외의 대부분 운영체제는 LF이다. 
윈도우에서 작성한 파일을 CRLF를 linux에서 볼때 `^M` 문자가 나오는 경우가 있다. 이는 `Ctrl + V + M`으로 입력할 수 있다.

## Git

windows에서 작성한 파일을 문제없이 다른 OS에서 사용하려면 아래 설정을 활성화한다.

`git config —global core.autocrlf=true`

- local → Github CRLF를 LF로 변경한다.
- Github → local LF를 CRLF로 변경한다.
- [답변의 그림](https://stackoverflow.com/questions/1967370/git-replacing-lf-with-crlf) 을 참고한다.

## cron, crontab

### 설치 방법

- (ubuntu) `apt install cron`

### manual

아래는 man 페이지에서 비교할만한 부분만 발췌했다. 
docker ubuntu에서는 man 기능을 활성화 해야 사용할 수 있다. 
방법은 [[Docker] Ubuntu20.04에서 man 사용하기](https://sang5c.tistory.com/53) 를 참고한다.

- man cron
    - NAME: daemon to execute scheduled commands (Vixie Cron)
    - DESCRIPTION: cron is started automatically from /etc/init.d on entering multi-user runlevels.
    - NOTES: In general, the system administrator should not use /etc/cron.d/, 
      but use the standard system crontab /etc/crontab.
- crontab
    - NAME: maintain crontab files for individual users (Vixie Cron)
    - DESCRIPTION: crontab  is the program used to install, 
      deinstall or list the tables used to drive the cron(8) daemon in Vixie Cron.  
      Each user can have their own crontab, and though these are files in /var/spool/cron/crontabs, 
      they are not intended to be edited directly.

크론은 여러 유저에게 한번에 job을 등록하고, 크론탭은 각각의 사용자에게 job을 등록하는 명령어라고 이해했다.

실무에서 써보지 않아 실제로 어떻게 사용하는지는 모르지만, cron의 NOTES에서 보는것처럼 시스템 관리자에게 crontab사용을 권장하고 있다. `crontab -l` 명령을 사용하면 등록된 잡들을 확인할 수 있어 crontab이 cron보다 사용이 더 편리하다고 느꼈다.

`cron` 명령어는 daemon을 실행하는 명령어이다. 크론의 경우 `/etc/cron.d/` 폴더에 job을 위치시키면 자동으로 추가된다.

크론탭의 경우 `crontab -e` 를 입력하여 job을 직접 작성하거나, 또는 파일로 작성한 후 `crontab <file>` 을 통해 파일을 등록한다. (추가가 아닌 파일교체가 된다)

cron job 문법은 간략히만 작성해 둔다.

```bash
분 시 일 월 1주일에n회 command
```

- asterisk는 all을 의미한다. 예를들어 * * * * * 으로 작성되어있다면 매 분마다를 의미하고, 
  60초마다 command를 실행하게 된다. 매 초를 의미하는 인자는 없다.
- 매일 13시 정각에 echo를 실행하고싶다면 `0 13 * * * echo "hello world!"`
- 매월 20일마다 매 시간, 3분이 되면 echo를 실행하고 싶다면 `3 * 20 * * echo "hello world"`

## Docker

- 컨테이너 모두 삭제하기
    - `docker rm -f $(docker ps -aq)`
    - -f: force, 실행중인 컨테이너도 삭제
    - ps -q: id만 출력
- 이미지 모두 삭제하기
    - `docker rmi $(docker image ls -aq)`
    - 커맨드 내에서 다른 커맨드를 실행하려면 $(명령어)를 사용한다. shell에서도 동일하게 적용된다.
        - `echo "$(date)"`
- 사용하지 않는 데이터 지우기. 이미지 캐시 비우기용으로 사용하였다.
    - `docker system prune`
    - 네트워크, 볼륨, 이미지, 컨테이너를 정리하는 명령어이다.
- docker 컨테이너에 bash 쉘로 연결
    - `docker exec -it <container> bash`
- shell 명령을 windows에서 작성하였다면 개행문자가 LF로 설정되었는지 확인해야 한다.

### 참고

cron, crontab

- [https://infoages.com/2123](https://infoages.com/2123)
- [https://help.dreamhost.com/hc/en-us/articles/215767047-Creating-a-custom-Cron-Job](https://help.dreamhost.com/hc/en-us/articles/215767047-Creating-a-custom-Cron-Job)
- man page
