# Plan: Refine App Bar Logic

## Feature Overview
- **Feature**: refine-app-bar-logic
- **Level**: Standard
- **Priority**: High
- **Status**: Active

## Summary
Refine the `CommonAppBar` widget and its application to ensure a strict and consistent header structure across the application, distinguishing between "Tab Roots" and "Sub-pages".

## Problem Statement
1. **Home Screen**: Icons are clustered on the right. Filter (tune) icon needs removal. Header must follow: [Profile] | [Title] | [Notification].
2. **Tab Roots (My Task, Notice)**: Currently showing a Back button instead of a Profile icon.
3. **Sub-pages**: Currently showing a Notification icon, which should be hidden. Header must follow: [Back] | [Title] | [Empty].

## Scope

### 1. `CommonAppBar` Logic Update
- Add a flag or logic to conditionally hide the Notification icon.
- Ensure `showProfile` correctly toggles between Profile and Back button.

### 2. Screen Refactoring
- **HomeScreen**: Remove remaining custom header elements (tune icon). Set `showProfile: true`.
- **TaskListScreen**: Set `showProfile: true`.
- **NoticeListScreen**: Set `showProfile: true`.
- **Detail/Sub-pages**: Ensure `showProfile: false` and hide notification icon.

## Implementation Plan
1.  **Update `CommonAppBar`**:
    - Add `bool showNotification` property (default: true).
    - Logic to return an empty `SizedBox` or similar if `showNotification` is false.
2.  **Update `HomeScreen`**: Cleanup any lingering custom header code.
3.  **Update Tab Roots**: Ensure `showProfile: true` is passed to `CommonAppBar` in `TaskListScreen` and `NoticeListScreen`.
4.  **Update Sub-pages**: Ensure `showNotification: false` is passed in Detail, Notification, and My Page screens.
5.  **Verify**: Cross-check all 7+ screens for header consistency.

## Success Criteria
- Home/Task/Notice screens: [Profile] | [Title] | [Notification].
- Sub-pages (Detail/Noti/MyPage): [Back] | [Title] | [None].
- No "Tune" icon on the Home screen.
