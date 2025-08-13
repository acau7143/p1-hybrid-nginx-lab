#!/usr/bin/env bash
# ↑ Bash로 스크립트를 실행하라는 의미 (환경변수 PATH를 따라 bash 위치 찾음)

# -e : 명령어가 실패하면 즉시 종료
# -u : 선언되지 않은 변수를 사용하면 오류 처리
# -o pipefail : 파이프라인에서 앞선 명령이 실패하면 전체 실패 처리
set -euo pipefail

# log 함수: 실행 흐름과 시간을 출력하는 유틸리티
log() { echo "[$(date +'%F %T')] $*"; }

log "Update & install nginx"
#sudo apt update                       # 패키지 목록 최신화
sudo apt install -y nginx             # nginx 설치 (-y: 묻지 않고 진행)

log "Enable & start nginx"
# enable: 부팅 시 자동 시작 등록
# --now : 지금 즉시 서비스 시작
sudo systemctl enable --now nginx

log "Show nginx status"
# --no-pager : 출력이 한 화면씩 멈추지 않고 바로 나옴
# || true : status 명령이 실패해도 스크립트 전체 중단 방지
sudo systemctl status nginx --no-pager || true

# UFW(방화벽) 설치 여부 확인
if ! command -v ufw >/dev/null 2>&1; then
  log "UFW not installed, installing..."
  sudo apt install -y ufw
fi

# 방화벽 사용 시 주석 해제
# log "Enable UFW and allow 80/tcp"
# sudo ufw enable                     # 방화벽 켜기
# sudo ufw allow 80/tcp                # 80포트 허용 (HTTP)
# sudo ufw status                      # 방화벽 상태 확인

log "Quick local test with curl"
if command -v curl >/dev/null 2>&1; then
  # -I : HTTP 헤더만 요청 (응답 코드 확인용)
  curl -I http://127.0.0.1 || true
else
  log "curl not found; install with: sudo apt install -y curl"
fi

log "Done. Open http://<SERVER_IP> in your browser."
