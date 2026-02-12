import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/task.dart';
import '../../providers/auth_provider.dart';
import '../../providers/task_provider.dart';
import '../../widgets/checklist_bottom_sheet.dart';
import '../../widgets/progress_bar.dart';
import '../../widgets/task_card.dart';
import '../../widgets/common_app_bar.dart';
import '../../utils/date_utils.dart';

class TaskListScreen extends ConsumerStatefulWidget {
  const TaskListScreen({super.key});

  @override
  ConsumerState<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends ConsumerState<TaskListScreen> {
  bool _hideCompleted = false;

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);
    final allTasks = ref.watch(taskListProvider);
    final dailyTasks = ref.watch(dailyTasksProvider);
    final assignedTasks = ref.watch(assignedTasksProvider);

    // Progress calculation
    final doneCount = allTasks.where((t) => t.status == TaskStatus.done).length;
    final totalCount = allTasks.length;

    // Checklist progress
    final allChecklistItems = dailyTasks
        .expand((t) => t.checklist ?? <ChecklistItem>[])
        .toList();
    final checklistDone =
        allChecklistItems.where((item) => item.isCompleted).length;
    final checklistTotal = allChecklistItems.length;

    // Filtered task list (assigned tasks shown in list)
    final displayTasks = _hideCompleted
        ? assignedTasks.where((t) => t.status != TaskStatus.done).toList()
        : assignedTasks;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: const CommonAppBar(
        title: '내 업무',
        showProfile: true,
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),

                    // User Profile Section
                    _buildProfileSection(user),

                    const SizedBox(height: 20),

                    // Daily Checklist Card
                    _buildChecklistCard(checklistDone, checklistTotal),

                    const SizedBox(height: 20),

                    // Progress Section
                    TaskProgressBar(done: doneCount, total: totalCount),

                    const SizedBox(height: 24),

                    // Filter Row
                    _buildFilterRow(),

                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),

            // Task Cards List
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return TaskCard(task: displayTasks[index]);
                  },
                  childCount: displayTasks.length,
                ),
              ),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(height: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection(dynamic user) {
    final joinDateStr = user != null
        ? AppDateUtils.formatMonthDayYear(user.joinDate)
        : '';

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user?.name ?? 'park sung min',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3436),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                user?.role ?? 'manager',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[500],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '가입일 : $joinDateStr',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
        CircleAvatar(
          radius: 28,
          backgroundColor: const Color(0xFFD6E8F7),
          child: Icon(
            Icons.person,
            size: 32,
            color: Colors.grey[400],
          ),
        ),
      ],
    );
  }

  Widget _buildChecklistCard(int done, int total) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => DraggableScrollableSheet(
            initialChildSize: 0.6,
            maxChildSize: 0.85,
            minChildSize: 0.4,
            builder: (_, controller) => const ChecklistBottomSheet(),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0D000000),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(
              Icons.check_circle_outline,
              color: Color(0xFF51CF66),
              size: 22,
            ),
            const SizedBox(width: 10),
            Text(
              'Dailly Checklist ($done/$total)',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2D3436),
              ),
            ),
            const Spacer(),
            Icon(
              Icons.settings_outlined,
              size: 20,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterRow() {
    return Row(
      children: [
        const Text(
          '업무목록',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2D3436),
          ),
        ),
        const Spacer(),
        _buildFilterChip('#전체', !_hideCompleted, () {
          setState(() => _hideCompleted = false);
        }),
        const SizedBox(width: 8),
        _buildFilterChip('#완료제거', _hideCompleted, () {
          setState(() => _hideCompleted = true);
        }),
      ],
    );
  }

  Widget _buildFilterChip(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2D3436) : const Color(0xFFF1F3F5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : Colors.grey[600],
          ),
        ),
      ),
    );
  }
}
