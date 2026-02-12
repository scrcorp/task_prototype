# Design: Refine App Bar Logic

## 1. `CommonAppBar` Enhancements

### Parameters
- `final bool showNotification`: New parameter, default `true`.

### Logic
- **Leading**:
  - `showProfile == true` -> `IconButton(Icons.person_outline)`
  - `showProfile == false` -> `IconButton(Icons.arrow_back_ios)`
- **Actions**:
  - `showNotification == true` -> `[IconButton(Icons.notifications_none)]`
  - `showNotification == false` -> `[]` (empty list)

## 2. Screen Refactoring

| Screen | `showProfile` | `showNotification` | Title |
|--------|:---:|:---:|---|
| `HomeScreen` | `true` | `true` | "직원 관리" (or similar) |
| `TaskListScreen` | `true` | `true` | "내 업무" |
| `NoticeListScreen` | `true` | `true` | "공지사항" |
| `TaskDetailScreen` | `false` | `false` | "업무 상세" |
| `NoticeDetailScreen` | `false` | `false` | "공지 상세" |
| `NotificationScreen` | `false` | `false` | "알림" |
| `MyPageScreen` | `false` | `false` | "마이페이지" |

## 3. `HomeScreen` Specific Cleanup
- Remove `_buildHeader` method.
- Remove all `IconButton`s from the top of the `body` column.
- Use `Scaffold.appBar` property.
