# 처음 설치 때 dpkg 오류

![image.png](../errors/image.png)

요약하면 두 가지가 겹쳤어요.

1. **의존성 버전 꼬임 (repo 혼용/부분 업그레이드)**

요약하면 두 가지가 겹쳤어요.

1. **의존성 버전 꼬임 (repo 혼용/부분 업그레이드)**
- 메시지 핵심: `libpython3.10-stdlib`가 `libpython3.10-minimal (= 3.10.12-1~22.04.10)`을 요구하는데, 시스템에는 `…22.04.5`가 깔리려 함.
- 원인
    - 서로 다른 미러/레포가 섞임(예: 어떤 건 `22.04.10`, 어떤 건 `22.04.5`).
    - 과거 설치/업그레이드가 중간에 끊겨 “절반만” 올라간 상태.
    - QEMU/VirtualBox 이미지 기본 소스가 오래되어 `apt update` 전에 설치 시도.
- 결과: A 패키지는 최신, B는 구버전 → “Unmet dependencies” 뜸.
1. **dpkg 락 파일 권한 오류**
- `apt --fix-broken install`을 **sudo 없이** 실행해서 `Permission denied`가 남.
- 또는 백그라운드에서 다른 프로세스(예: `unattended-upgrades`, 다른 `apt/dpkg`)가 실행 중일 때도 같은 락 오류가 남.

---

### 왜 이런 상황이 생기나?

- 설치 직후 `apt update` 없이 바로 패키지 설치함.
- `sources.list`에 서로 다른 릴리스/미러가 섞임.
- 설치/업그레이드 중 터미널을 닫거나 VM을 강제 종료.
- `sudo` 안 붙이고 `apt/dpkg` 실행.

---

### 재발 방지 팁

- 항상 순서: `sudo apt update && sudo apt full-upgrade -y` → 그다음 원하는 패키지 설치.
- `Software & Updates`에서 **Server for your country** 또는 **Main server** 하나로 통일.
- `apt` 작업 중엔 터미널/VM 끄지 말기.
- 락 나면 먼저 확인: `ps aux | grep -E 'apt|dpkg' | grep -v grep` (돌고 있으면 종료 기다림).
- 모든 패키지 작업은 **반드시 `sudo`*로.

---

### 지금 상태를 풀 때의 핵심 명령(복습)

```bash

# 1) 다른 apt/dpkg 프로세스 확인
ps aux | grep -E 'apt|dpkg' | grep -v grep

# 2) 목록 갱신
sudo apt update

# 3) 깨진 의존성/중단된 설정 마무리
sudo apt --fix-broken install
sudo dpkg --configure -a

# 4) 캐시 정리 & 정합성 맞추는 업그레이드
sudo apt clean
sudo apt autoclean
sudo apt full-upgrade -y

# 5) (필요시) 정확한 버전으로 맞춰 설치
# sudo apt install libpython3.10-minimal=3.10.12-1~22.04.10 libpython3.10-stdlib=3.10.12-1~22.04.10

# 6) 그 다음에 git
sudo apt install -y git

```