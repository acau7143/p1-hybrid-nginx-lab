## Day 1 — VM 생성 & SSH 접속 & GitHub 연동
- 목표: VM 생성, SSH 서버 활성화, GitHub SSH 키 등록
- 결과: VM에 SSH 접속 성공, GitHub push 가능
- 관련 파일:
  - [2025-08-10.sh](scripts/2025-08-10.sh)
  - [2025-08-10.md](./diary/2025-08-10.md)

## Day 2 — nginx 설치 & 접속 확인
- 목표: nginx 설치 및 브라우저 접속
- 결과: nginx welcome 페이지 접속 성공
- 관련 파일:
  - [2025-08-13.sh](./scripts/2025-08-13.sh)
  - [2025-08-13.md](./diary/2025-08-13.md)

## Day 3 — AWS EC2 생성 & SSH 접속
- 목표: AWS EC2 Ubuntu 인스턴스 생성, Key Pair로 SSH 접속 확인
- 결과: EC2에 SSH 접속 성공 (ubuntu 계정)
- 관련 파일:
  - [2025-08-16.sh](./scripts/2025-08-16.sh)
  - [2025-08-16.md](./diary/2025-08-16.md)

## Day 4 — nginx 설치 & 접속 확인
- 목표: EC2 Ubuntu에 nginx 설치, 80 포트 오픈 후 외부 접속
- 결과: nginx welcome/커스텀 페이지 접속 성공
- 관련 파일:
  - [2025-08-16-day04.sh](./scripts/2025-08-16-day04.sh)
  - [2025-08-16-day04.md](./diary/2025-08-16-day04.md)

## Day 5 — VM ↔ EC2 네트워크 통신 확인
- 목표: 온프레미스 VM에서 AWS EC2까지 ping / traceroute 테스트
- 결과: ping 정상 응답(0% 손실, RTT 약 215~222ms), traceroute는 중간 hop 차단으로 `* * *` 표시됨 (정상 현상)
- 관련 파일:
  - [2025-09-05.sh](./scripts/2025-09-05.sh)
  - [2025-09-05.md](./diary/2025-09-05.md)
