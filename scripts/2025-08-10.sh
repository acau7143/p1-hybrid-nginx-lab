#!/bin/bash
# bash 스크립트에서 하나라도 명령이 실패하면 바로 스크립트를 종료
set -e
sudo apt update
sudo apt install -y openssh-server
# --now 하면은 start 필요없이 시작된다.
sudo systemctl enable --now ssh
sudo systemctl status ssh --no-pager
echo "Tip: NAT 포트포워딩이면 호스트에서 ssh -p 2222 <user>@127.0.0.1"

