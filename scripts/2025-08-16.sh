#!/usr/bin/env bash
# → bash 셸로 이 스크립트를 실행하라는 의미

set -euo pipefail
# -e : 명령어가 실패하면 즉시 스크립트 중단
# -u : 선언되지 않은 변수를 사용하면 오류 발생
# -o pipefail : 파이프라인 중 하나라도 실패하면 전체를 실패로 간주

# 변수 설정 (사용자가 직접 수정해야 하는 부분)
KEY="my-key.pem"       # AWS에서 다운받은 키 파일 이름
IP="xx.xx.xx.xx"       # EC2 퍼블릭 IPv4 주소 (AWS 콘솔에서 확인)


# ssh로 EC2에 접속, Here Document 블록 실행
ssh -i "$KEY" ubuntu@"$IP" << 'EOF'
  # -i "$KEY" → 지정한 키 파일로 인증
  # ubuntu@"$IP" → ubuntu 계정으로 EC2의 퍼블릭 IP에 접속
  # << 'EOF' ~ EOF → 이 블록 안의 명령어들을 원격 서버에서 실행

  echo "[REMOTE] 현재 사용자:"
  whoami
  # → 접속된 계정 이름 출력 (Ubuntu AMI라면 항상 ubuntu)

  echo "[REMOTE] 커널/OS 정보:"
  uname -a
  # → 리눅스 커널 버전과 OS 정보를 출력
EOF
# EOF → Here Document 블록의 끝을 표시
