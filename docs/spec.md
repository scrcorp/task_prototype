# Project Specification: Staff Task Management System (Flutter)

## 1. 프로젝트 개요 (Overview)

이 프로젝트는 매장 직원 업무 관리 B2B SaaS 솔루션입니다.
다중 브랜드/지점 관리가 가능하며, **모든 클라이언트(앱, 웹, 관리자)는 Flutter 프레임워크를 사용하여 개발합니다.**

**현재 단계: `/prototype` 폴더 내에서 `Flutter Web` 빌드를 통해 클라이언트 시연용 프로토타입 개발에 집중합니다.**

---

## 2. 프로젝트 디렉토리 구조 (Directory Structure)

전체 프로젝트는 아래 4개의 모듈로 구성됩니다.

1.  **`/prototype`** (Current Focus 🎯)
    - **목적:** 클라이언트 시연 및 기획 검증용 웹 애플리케이션.
    - **기술:** **Flutter (Web build)**.
    - **특징:** 실제 백엔드 없이 로컬 Mock Data로 동작하며, 추후 본 프로젝트(`taskmanager`)의 베이스 코드로 활용.

2.  **`/taskmanager`** (Future)
    - **목적:** 실제 직원들이 사용할 모바일/태블릿 앱.
    - **기술:** Flutter (iOS/Android/iPadOS).

3.  **`/taskmanager_admin`** (Future)
    - **목적:** 매장 관리자가 직원을 배정하고 업무를 생성하는 대시보드.
    - **기술:** Flutter (Web build).

4.  **`/task_server`** (Future)
    - **목적:** 전체 데이터를 관리하는 API 서버.
    - **기술:** Python (FastAPI) or Node.js.

---

## 3. 상세 요구사항: Prototype (`/prototype`)

### 3.1 기술 스택 (Tech Stack)

- **Framework:** Flutter (Channel: Stable)
- **Language:** Dart
- **Target Platform:** Web (Chrome 시연용)
- **State Management:** Riverpod (권장) 또는 Provider
- **Routing:** go_router (웹 URL 처리 필수)
- **UI Concept:** Material 3 기반의 커스텀 디자인 (Reference 이미지 준수)

### 3.2 주요 기능 및 UI Flow

#### A. 로그인 (Auth - Mock)

- **기능:** ID/PW 입력 후 로그인 버튼 클릭 시 Mock User 정보 로드.
- **디자인:** 심플한 중앙 정렬 카드 형태.

#### B. 메인 홈 (Dashboard)

- **Header:** "Good morning, [Name]" 인사말, 알림 아이콘.
- **Quick Menu:** [내 업무], [출퇴근], [스케줄], [OJT] 아이콘 그리드.
- **Notice:** 최신 공지사항 카드 표시.
- **Bottom Navigation:** [홈] - [내 업무] - [공지사항].

#### C. 업무 리스트 (My Task)

- **Progress Bar:** 전체 업무 달성률 표시 (Done / Left).
- **Daily Routine (데일리 루틴):**
  - 리스트 아이템 클릭 시 **Bottom Sheet** 출력.
  - Bottom Sheet 내부에서 체크박스로 세부 항목(청소, 기물 정리 등) 완료 처리.
- **Assigned Tasks (할당된 업무):**
  - 우선순위 태그(`긴급`, `보통`, `여유`) 표시.
  - 클릭 시 상세 페이지로 이동.

#### D. 업무 상세 (Task Detail)

- **Task Info:** 제목, 설명, 마감기한, 담당자 프로필 표시.
- **Status Action:** 하단 버튼을 통해 상태 변경 (`시작 전` -> `진행 중` -> `완료`).
- **Proof (인증):** 사진 촬영/업로드 UI (Mock: 갤러리에서 선택하는 시늉).
- **Communication:** 관리자와의 댓글/채팅 UI (말풍선 형태).

---

## 4. 데이터 구조 (Mock Data Schema)

`/prototype/lib/data/mock_data.dart`에 정의하여 사용.

```dart
enum TaskType { daily, assigned }
enum Priority { urgent, normal, low }
enum TaskStatus { todo, inProgress, done }

class Task {
  final String id;
  final TaskType type;
  final String title;
  final String description;
  final Priority priority; // assigned only
  final TaskStatus status;
  final DateTime dueDate;
  final List<ChecklistItem>? checklist; // daily only
  final List<Comment>? comments; // assigned only

  Task({ ... });
}

```

---

## 5. 디자인 참조 (Design References)

**중요:** 개발 시 아래 경로에 있는 이미지 파일들을 반드시 참고하여 레이아웃과 스타일을 구현해주세요.
이미지 파일명은 예시이므로, 실제 폴더 내의 파일들을 확인하세요.

**경로:** `doce/design_reference/`

- **로그인 화면:** `doce/design_reference/login.png` (예상)
- **회원가입 화면:** `doce/design_reference/signup.png` (예상)
- **메인 대시보드:** `doce/design_reference/home.png` (예상)
- **업무 리스트:** `doce/design_reference/task_list.png` (예상)
- **상세 및 채팅:** `doce/design_reference/task_detail.png` (예상)

**UI 스타일 가이드:**

- **Color:** 이미지에서 추출한 파스텔톤(Blue/Mint) 메인 컬러 사용.
- **Shape:** 카드와 버튼은 `RoundedRectangleBorder`(radius: 12~16) 적용.
- **Shadow:** 과하지 않은 부드러운 `BoxShadow` 적용.
- **Layout:** 모바일과 태블릿(iPad) 모두 대응 가능한 반응형 레이아웃 (`LayoutBuilder` 활용).

---

## 6. 개발 가이드라인 (Rules)

1. **Mock Data First:** UI를 그리기 전에 데이터 모델과 Mock Data를 먼저 정의하고 시작할 것.
2. **Widget Separation:** 재사용 가능한 컴포넌트(TaskCard, Badge, CommentBubble 등)는 별도 위젯 파일로 분리할 것.
3. **Clean Code:** 모든 로직은 가능한 UI 코드와 분리(Repository 패턴 혹은 Riverpod Provider 활용)할 것.

```

```
