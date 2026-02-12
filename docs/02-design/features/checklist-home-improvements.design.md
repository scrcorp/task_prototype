# Design: Checklist & Home Improvements

## 1. Daily Checklist Improvements

### Data Model Updates
- Update `ChecklistItem` in `prototype/lib/models/task.dart`:
  - Add `verificationType`: `enum VerificationType { none, photo }`.
  - Add `verificationData`: `String?` (e.g., photo path).

### Mock Data
- Add a new Daily Task in `prototype/lib/data/mock_data.dart` with a checklist item requiring `VerificationType.photo`.

### UI: `ChecklistBottomSheet`
- **Sorting**: Update `_ChecklistEntry` generation to sort items: `!isCompleted` first, then `isCompleted`.
- **Interaction**: Wrap `ListTile` or its container in `InkWell`/`GestureDetector` to handle taps on the entire row.
- **Verification Flow**:
  - When tapping an unchecked item with `VerificationType.photo`:
    - Show a `Dialog` or `Modal` asking for photo proof.
    - On confirmation (mock photo selection), update item status to completed.
  - When tapping a checked item:
    - Toggle back to incomplete directly.

## 2. Home Screen Fixes

### Performance
- **Diagnosis**: The lag might be due to `_buildTaskSummaryCard` or excessive rebuilds.
- **Fix**: Ensure `const` constructors are used where possible. Check if mock data generation is expensive (unlikely but possible).

### Navigation (Notice -> Back)
- **Problem**: Likely context context issue or `go_router` stack handling.
- **Fix**: Verify `context.push` vs `context.go` usage. `context.push('/notices/:id')` should stack correctly. Ensure `NoticeDetailScreen` uses `Navigator.pop(context)` or `context.pop()`.

## 3. New Features

### Notification Screen
- **Route**: `/notifications`
- **Screen**: `NotificationScreen` in `prototype/lib/screens/notification/notification_screen.dart`.
- **UI**: Simple list of mock notifications.
- **Entry**: Update `HomeScreen` app bar bell icon to `context.push('/notifications')`.

### My Page & Logout
- **Route**: `/mypage`
- **Screen**: `MyPageScreen` in `prototype/lib/screens/mypage/mypage_screen.dart`.
- **UI**: User profile info + "Log out" button.
- **Logic**:
  - Logout button calls `ref.read(authProvider.notifier).logout()`.
  - `AppRouter` redirect logic should automatically handle the transition to `/login`.
- **Entry**: Add `IconButton(Icons.person)` to `HomeScreen` app bar.

## 4. Architecture & Directory Structure

```
prototype/lib/
├── models/
│   └── task.dart             # Update ChecklistItem
├── screens/
│   ├── notification/         # New
│   │   └── notification_screen.dart
│   └── mypage/              # New
│       └── mypage_screen.dart
├── widgets/
│   └── checklist_bottom_sheet.dart # Update logic
```
