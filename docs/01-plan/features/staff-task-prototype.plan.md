# Plan: Staff Task Prototype

## Feature Overview
- **Feature**: staff-task-prototype
- **Level**: Dynamic
- **Priority**: High
- **Status**: Active

## Summary
매장 직원 업무 관리 B2B SaaS 솔루션의 클라이언트 시연용 Flutter Web 프로토타입 개발.
실제 백엔드 없이 Mock Data로 동작하며, 추후 본 프로젝트의 베이스 코드로 활용.

## Scope

### In Scope
1. **로그인** - ID/PW Mock 인증, 심플 카드 UI
2. **회원가입** - 4단계 위저드 (약관동의, 본인인증, 정보입력, 가입완료)
3. **홈 대시보드** - 인사말 헤더, Quick Menu, 공지사항, Bottom Navigation
4. **업무 리스트 (My Task)** - Progress Bar, Daily Routine (Bottom Sheet), Assigned Tasks (우선순위 태그)
5. **업무 상세** - Task Info, Status Action, 사진 인증 UI, 댓글/채팅 UI
6. **공지사항** - 리스트 및 상세 화면

### Out of Scope
- 실제 백엔드 API 연동
- 실제 사진 촬영/업로드
- 푸시 알림
- 다국어 지원
- 출퇴근/스케줄/OJT 기능 (Quick Menu에 아이콘만 배치)

## Tech Stack
- **Framework**: Flutter 3.38.x (Stable)
- **Language**: Dart
- **Target**: Web (Chrome)
- **State Management**: Riverpod
- **Routing**: go_router
- **UI**: Material 3 커스텀 (파스텔톤 Blue/Mint)

## Implementation Priority
1. 프로젝트 셋업 및 기반 코드 (데이터 모델, Mock Data, Provider, 라우팅, 테마)
2. 로그인/회원가입 화면
3. 홈 대시보드
4. 업무 리스트/상세 화면
5. 공지사항 및 통합
6. 빌드 검증

## Design References
- `docs/design_reference/login.png` - 로그인
- `docs/design_reference/signup.png` - 회원가입 4단계
- `docs/design_reference/home.png` - 홈 대시보드
- `docs/design_reference/tasklist.png` - 업무 리스트
- `docs/design_reference/taks_detail.png` - 업무 상세

## Success Criteria
- Flutter Web 빌드 성공 (chrome)
- 모든 6개 화면 네비게이션 동작
- Mock 로그인/로그아웃 동작
- 업무 상태 변경 (시작전 -> 진행중 -> 완료)
- Daily Checklist Bottom Sheet 동작
- 디자인 레퍼런스 대비 90% 이상 일치
