#!/usr/bin/env bash

set -euo pipefail

KEY="my-key.pem"
IP="xx.xx.xx.xx"

ssh -i "$KEY" ubuntu@"$IP" << 'EOF'
	set -euo pipefail
	
	echo "[REMOTE] apt 업데이트"
	sudo apt update -y
	
	echo "[REMOTE] nginx 설치"
	sudo apt-get install -y nginx

	echo "[REMOTE] nginx 기동 및 부팅 연동"
	sudo systemctl enable --now nginx

	echo "[REMOTE] 상태 확인"
	sudo systemctl status nginx --no-pager

	echo "[REMOTE] 80/TCP 리스닝 확인"
	ss -tulpn | grep '80' || true

	echo "[REMOTE] 로컬 루프백으로 HTTP 헤더 확인"a
	if command -v curl > /dev/null 2>&1; then
		curl -I http://127.0.0.1 || true
	else
		echo "curl not found"
	
	echo "[REMOTE] 완료"
EOF

	
