## Network

### TCP 3-way handshake, 4-way handshake
#### 3-way handshake
- TCP에서 연결이 잘 되는지 확인하는 과정. handshake 성공시 논리적으로 연결된다.
- 이름에서 보듯 3단계로 나뉜다. 
  TCP는 양방향 통신이며 server에서 client로 연결 확보, client에서 server로의 연결확보 두 가지를 모두 해야하기 때문에 3단계로 이루어져 있다. 
- 연결 과정. SYN은 synchronize sequence numbers(시퀀스 번호 동기화), ACK는 acknowledgment(승인)의 약자이다. SYN으로 받은 값에 1을 더하는 응답을 통해 연결을 확인한다.
  1. Client -> Server: SYN(a)
  2. Server -> Client: SYN(b)-ACK(a+1)
  3. Client -> Server: ACK(b+1)
- state 변화과정
  - client: CLOSED -> SYN-SENT -> ESTABLESHED
  - server: LISTEN -> SYN-RECVED -> ESTABLESHED
  
#### 4-way handshake
- TCP 연결을 종료하는 과정. handshake 성공시 논리적으로 연결 해제된다. (자원 반납)
- 해제 과정
  1. Client -> Server: 클라이언트는 FIN 보내고 ACK 대기상태. 클라이언트는 FIN-WAIT-1
  2. Server -> Client: ACK를 보내고 앱 종료 요청후 잠시 대기. 서버는 CLOSE-WAIT, 클라이언트는 ACK를 받으면 FIN-WAIT-2상태
  3. Server -> Client: 앱 종료되면 FIN 전송. 서버는 LAST-ACK, 클라이언트는 FIN을 받으면 TIME-WAIT
  4. Client -> Server: ACK, 종료. 클라이언트는 못받은 패킷이 있을 수 있으므로 잠시 대기 후 종료, 서버는 ACK를 받으면 종료. 
- state 변화과정
  - client: ESTABLESHED -> FIN-WAIT-1 -> FIN-WAIT-2 -> TIME-WAIT -> CLOSED
  - server: ESTABLESHED -> CLOSE-WAIT -> LAST-ACK -> CLOSED

참고
  * [[TCP] 3-way-handshake & 4-way-handshake](https://asfirstalways.tistory.com/356)
  * [[ 네트워크 쉽게 이해하기 22편 ] TCP 3 Way-Handshake & 4 Way-Handshake](https://mindnet.tistory.com/entry/%EB%84%A4%ED%8A%B8%EC%9B%8C%ED%81%AC-%EC%89%BD%EA%B2%8C-%EC%9D%B4%ED%95%B4%ED%95%98%EA%B8%B0-22%ED%8E%B8-TCP-3-WayHandshake-4-WayHandshake)
