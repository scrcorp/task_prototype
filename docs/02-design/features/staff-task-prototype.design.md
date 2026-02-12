# Design: Staff Task Prototype

## Technical Architecture

### Project Structure
```
prototype/
├── lib/
│   ├── main.dart                    # App entry point
│   ├── app.dart                     # MaterialApp + GoRouter setup
│   ├── theme/
│   │   └── app_theme.dart           # Material 3 theme (pastel blue/mint)
│   ├── models/
│   │   ├── user.dart                # User model
│   │   ├── task.dart                # Task, ChecklistItem models
│   │   ├── comment.dart             # Comment model
│   │   └── notice.dart              # Notice model
│   ├── data/
│   │   └── mock_data.dart           # All mock data
│   ├── providers/
│   │   ├── auth_provider.dart       # Auth state (login/logout)
│   │   ├── task_provider.dart       # Task list & state management
│   │   └── notice_provider.dart     # Notice data provider
│   ├── router/
│   │   └── app_router.dart          # go_router configuration
│   ├── screens/
│   │   ├── login/
│   │   │   └── login_screen.dart
│   │   ├── signup/
│   │   │   ├── signup_screen.dart          # Stepper container
│   │   │   ├── terms_step.dart             # Step 1: 약관동의
│   │   │   ├── email_verify_step.dart      # Step 2: 본인인증
│   │   │   ├── info_input_step.dart        # Step 3: 정보입력
│   │   │   └── complete_step.dart          # Step 4: 가입완료
│   │   ├── home/
│   │   │   └── home_screen.dart
│   │   ├── task/
│   │   │   ├── task_list_screen.dart
│   │   │   └── task_detail_screen.dart
│   │   └── notice/
│   │       ├── notice_list_screen.dart
│   │       └── notice_detail_screen.dart
│   ├── widgets/
│   │   ├── task_card.dart           # Reusable task card
│   │   ├── priority_badge.dart      # Priority tag (긴급/보통/여유)
│   │   ├── checklist_bottom_sheet.dart  # Daily checklist bottom sheet
│   │   ├── comment_bubble.dart      # Chat-style comment bubble
│   │   ├── progress_bar.dart        # Task progress bar
│   │   ├── quick_menu_grid.dart     # Home quick menu grid
│   │   └── bottom_nav_shell.dart    # Bottom navigation shell
│   └── utils/
│       └── date_utils.dart          # Date formatting helpers
├── pubspec.yaml
└── web/
    └── index.html
```

## Data Models

### User
```dart
class User {
  final String id;
  final String name;
  final String role;           // 'manager', 'staff'
  final String profileImage;   // asset path
  final String branch;         // 지점명
  final DateTime joinDate;
}
```

### Task
```dart
enum TaskType { daily, assigned }
enum Priority { urgent, normal, low }
enum TaskStatus { todo, inProgress, done }

class Task {
  final String id;
  final TaskType type;
  final String title;
  final String description;
  final Priority priority;
  TaskStatus status;
  final DateTime startDate;
  final DateTime dueDate;
  final String assignedTo;
  final String assignedBy;
  final List<String> labels;
  List<ChecklistItem>? checklist;    // daily type only
  List<Comment>? comments;           // assigned type only
  String? proofImagePath;
}

class ChecklistItem {
  final String id;
  final String title;
  bool isCompleted;
}
```

### Comment
```dart
class Comment {
  final String id;
  final String userId;
  final String userName;
  final String content;
  final DateTime createdAt;
  final bool isManager;
}
```

### Notice
```dart
class Notice {
  final String id;
  final String title;
  final String content;
  final DateTime createdAt;
  final String author;
  final bool isImportant;
}
```

## Routing (go_router)

| Route | Screen | Auth Required |
|-------|--------|:------------:|
| `/login` | LoginScreen | No |
| `/signup` | SignupScreen | No |
| `/` | HomeScreen | Yes |
| `/tasks` | TaskListScreen | Yes |
| `/tasks/:id` | TaskDetailScreen | Yes |
| `/notices` | NoticeListScreen | Yes |
| `/notices/:id` | NoticeDetailScreen | Yes |

- ShellRoute with BottomNavigationBar for `/`, `/tasks`, `/notices`
- Redirect to `/login` if not authenticated

## State Management (Riverpod)

### Providers
```
authProvider          -> StateNotifierProvider<AuthNotifier, AuthState>
currentUserProvider   -> Provider<User?> (derived from authProvider)
taskListProvider      -> StateNotifierProvider<TaskNotifier, List<Task>>
dailyTasksProvider    -> Provider<List<Task>> (filtered from taskListProvider)
assignedTasksProvider -> Provider<List<Task>> (filtered from taskListProvider)
taskProgressProvider  -> Provider<double> (calculated completion rate)
noticeListProvider    -> StateNotifierProvider<NoticeNotifier, List<Notice>>
```

## Theme (Material 3)

### Color Scheme
```dart
// Primary: Pastel Blue
primary: Color(0xFF5B9BD5)        // Main action color
onPrimary: Colors.white
primaryContainer: Color(0xFFD6E8F7)

// Secondary: Mint
secondary: Color(0xFF7EC8C8)
secondaryContainer: Color(0xFFD4F0F0)

// Surface
surface: Color(0xFFF8F9FA)
background: Colors.white

// Priority colors
urgent: Color(0xFFFF6B6B)  // 긴급 - red
normal: Color(0xFFFFB84D)  // 보통 - orange
low: Color(0xFF51CF66)     // 여유 - green
```

### Typography
- Headlines: Bold, dark gray
- Body: Regular, medium gray
- Card radius: 12-16
- BoxShadow: subtle, offset(0,2), blur(8), color(0x0D000000)

## Screen Specifications

### 1. Login Screen
- Centered card layout
- Title: "직원 관리 프로그램"
- ID TextField, PW TextField (obscured)
- "로그인" button (primary color, full width in card)
- "아직 회원이 아닌가요?" text
- "회원가입 바로가기 >" link (bold, primary color)

### 2. Signup Screen (4-step Stepper)
- Top step indicator: 약관동의 → 본인인증 → 정보입력 → 가입완료
- Step 1: Terms checkbox list + "다음" button
- Step 2: Email input + verify code + "이전/다음" buttons
- Step 3: Name, ID, PW, PW confirm, branch dropdown, language dropdown + "이전/다음"
- Step 4: Completion message "가입이 완료 되었어요. 관리자가 승인한 이후 계정을 사용할 수 있어요." + "홈으로" button

### 3. Home Dashboard
- AppBar: "Good morning, [Name]" with notification bell icon
- Alert card (if any)
- Today's task summary card
- Profile card with user info
- Quick menu (공유 공지 사항 section)
- Comment section at bottom
- Bottom nav: 홈 | 내업무 | 공지사항

### 4. Task List Screen
- AppBar: "mytask" with bell icon
- User profile section (name, role, join date, avatar)
- Daily Checklist card (expandable, shows completion count)
- Progress bar: "남은 업무(N/Total)" with done/left slider
- Filter: 전체 | 완료제거
- Task cards list with priority badges (긴급/보통/여유) and arrow
- Bottom nav

### 5. Task Detail Screen
- AppBar: "task detail"
- Task title, description
- Start time, Due date
- Assigned to, Labels
- Status action buttons
- 사진 인증 section (image placeholder with camera icon)
- "작업 완료" / 취소 buttons
- Comment section (chat bubbles)

### 6. Notice Screen
- Notice list with cards
- Notice detail with title, content, comment section
- "확인 완료" button

## Implementation Order
1. **Phase 1**: Project setup + theme + models + mock data + providers + router
2. **Phase 2**: Login + Signup screens
3. **Phase 3**: Home dashboard + Bottom nav shell
4. **Phase 4**: Task list + Task detail + Bottom sheet + Comments
5. **Phase 5**: Notice screens + Final integration
