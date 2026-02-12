# Plan: Checklist & Home Improvements

## Feature Overview
- **Feature**: checklist-home-improvements
- **Level**: Standard
- **Priority**: High
- **Status**: Active

## Summary
Implements improvements to the Daily Checklist UX, fixes performance and navigation issues on the Home screen, and adds Notification and My Page (Logout) features.

## Scope

### 1. Daily Checklist Improvements
- **Photo Proof**: Add a sample task requiring photo verification.
- **Reordering**: Sort incomplete tasks to the top, completed tasks to the bottom.
- **Interaction**: Make the entire list tile clickable to toggle status.
- **Verification Flow**: Show a verification dialog (e.g., photo upload) when checking a task that requires it.

### 2. Home Screen Fixes
- **Performance**: Optimize the Login -> Home transition (investigate lag).
- **Navigation**: Fix the error when pressing 'Back' after viewing a Notice from the Home screen.

### 3. New Features
- **Notification Screen**: Implement screen for the bell icon.
- **My Page Entry**: Add a person icon to the AppBar to navigate to My Page.
- **My Page**: Implement a simple My Page with a Logout button.

## Tech Stack
- **Framework**: Flutter
- **State Management**: Riverpod
- **Routing**: go_router

## Implementation Plan
1.  **Refactor Models**: Update `Task` model to support 'verification type' (simple vs. photo).
2.  **Update Mock Data**: Add new mock tasks for testing.
3.  **Checklist UI**: Update `ChecklistBottomSheet` logic for sorting and interactivity.
4.  **Verification UI**: Create a simple verification dialog/screen.
5.  **Navigation Fixes**: Debug `go_router` stack for Notice -> Back issue.
6.  **Performance**: Profile startup; likely mock delay or excessive rebuilding.
7.  **New Screens**: Create `NotificationScreen` and `MyPageScreen`.
8.  **Logout Logic**: Ensure `authProvider` clears state and router redirects to Login.

## Success Criteria
- Daily checklist behaves as requested (sort, click area, verification).
- Home screen loads smoothly.
- Back button works correctly from Notice detail.
- Notification screen is accessible.
- My Page allows logout, redirecting to Login.
