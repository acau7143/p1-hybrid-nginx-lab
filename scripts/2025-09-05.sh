#!/bin/usr/bin/env bash
set -euo pipefail

IP="퍼블릭IP"

log(){ echo "[DAY5] $*"; }

log "Ping 테스트 (4회)"
ping -c 4 "$IP" || { log "Ping 실패 - 보안그룹 ICMP 허용 여부 확인"; exit 1; }

log "Traceroute 테스트"
if ! command -v traceroute >/dev/null 2>&1; then
  echo "traceroute 미설치 → 설치 필요 (sudo apt-get install -y traceroute)"
  exit 1
fi

traceroute "$IP" | head -n 20

log "OK - Day5 통신 테스트 완료"

# Bash에서 && 와 || 의미
# cmd1 || cmd2
# → cmd1이 실패(0이 아닌 exit code) 하면 cmd2 실행

#cmd1 && cmd2
#→ cmd1이 성공(0 exit code) 하면 cmd2 실행

#Bash에서 exit 코드
# exit 0 → 정상 종료 (성공)
# exit 1 (혹은 0이 아닌 값) → 에러 종료 (실패)
