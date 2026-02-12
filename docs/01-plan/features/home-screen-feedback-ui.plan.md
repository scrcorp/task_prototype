# Plan: Home Screen Feedback UI

## Feature Overview
- **Feature**: home-screen-feedback-ui
- **Level**: Quick Fix
- **Priority**: Normal
- **Status**: Active

## Summary
Reorganize the Home screen layout by removing the bottom comment section and adding a new "Opinion Input" section between the Quick Menu Grid and the Shared Notices Section.

## Scope

### 1. Remove Bottom Comment Section
- Remove the existing `_buildCommentSection` and its usage in `HomeScreen`.

### 2. Add Opinion Input Section
- **Location**: Between `QuickMenuGrid` and `_buildNoticesSection`.
- **UI**: A text input field with a send button, similar to the previous comment section but repositioned.
- **Functionality**: Allow users to type and "send" (mock) an opinion/feedback.

## Tech Stack
- **Framework**: Flutter
- **State Management**: Riverpod (if needed for state, otherwise internal state)

## Implementation Plan
1.  **Modify `HomeScreen`**:
    - Remove `_buildCommentSection`.
    - Create `_buildOpinionInputSection`.
    - Insert `_buildOpinionInputSection` into the `Column` children between `QuickMenuGrid` and `_buildNoticesSection`.
2.  **Verify**: Ensure the layout looks correct and the keyboard interaction works.

## Success Criteria
- Bottom comment section is gone.
- New opinion input section appears correctly in the specified location.
- "Send" action shows a snackbar or similar feedback.
