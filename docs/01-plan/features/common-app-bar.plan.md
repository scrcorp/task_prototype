# Plan: Common App Bar Implementation

## Feature Overview
- **Feature**: common-app-bar
- **Level**: Standard
- **Priority**: High
- **Status**: Active

## Summary
Implement a unified, reusable `CommonAppBar` widget to enforce a consistent header structure across all screens.
The structure will be:
- **Left**: Profile Icon (Main) or Back Button (Sub-page).
- **Center**: Screen Title.
- **Right**: Notification Icon.

## Scope

### 1. Create `CommonAppBar` Widget
- **Location**: `prototype/lib/widgets/common_app_bar.dart`
- **Props**:
  - `title`: String (required)
  - `showProfile`: bool (default: false, shows Profile icon if true, Back button if false)
  - `onProfilePressed`: VoidCallback? (optional)
  - `onNotificationPressed`: VoidCallback (default action: push to `/notifications`)

### 2. Refactor Screens
- Replace existing `AppBar` or custom header implementations in:
  - `HomeScreen` (Remove custom `_buildHeader`)
  - `TaskListScreen`
  - `NoticeListScreen`
  - `TaskDetailScreen` (Ensure right icon consistency)
  - `NoticeDetailScreen` (Ensure right icon consistency)
  - `NotificationScreen`
  - `MyPageScreen`

### 3. Logic
- **Profile Icon**: Navigates to `/mypage`.
- **Notification Icon**: Navigates to `/notifications`.
- **Back Button**: Standard `Navigator.pop`.

## Tech Stack
- **Framework**: Flutter
- **Routing**: go_router

## Implementation Plan
1.  **Create Widget**: Implement `CommonAppBar` adhering to `PreferredSizeWidget`.
2.  **Refactor Home**: Replace the custom header with `CommonAppBar`.
3.  **Refactor Lists**: Update `TaskListScreen` and `NoticeListScreen`.
4.  **Refactor Details**: Update detail screens to match the right-side icon requirement.
5.  **Verify**: Ensure navigation works correctly from all headers.

## Success Criteria
- All screens show the same AppBar structure.
- Profile icon appears on main screens (`/`, `/tasks`, `/notices` root tabs).
- Back button appears on sub-screens.
- Notification icon is present and functional on all screens.
