import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/auth_provider.dart';
import '../../providers/task_provider.dart';
import '../../providers/notice_provider.dart';
import '../../models/task.dart';
import '../../widgets/quick_menu_grid.dart';
import '../../utils/date_utils.dart';
import '../../widgets/common_app_bar.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final tasks = ref.watch(taskListProvider);
    final notices = ref.watch(noticeListProvider);
    final colorScheme = Theme.of(context).colorScheme;

    final pendingTasks =
        tasks.where((t) => t.status != TaskStatus.done).toList();
    final urgentTasks =
        tasks.where((t) => t.priority == Priority.urgent && t.status != TaskStatus.done).toList();

    final userName = user?.name ?? '사용자';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CommonAppBar(
        title: '홈',
        showProfile: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              // ---- Status Chips ----
              Row(
                children: [
                  _BadgeChip(
                    label: '${pendingTasks.length} Works',
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  _BadgeChip(
                    label: '${urgentTasks.length} Alert',
                    color: const Color(0xFFFF6B6B),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // ---- Alert Card ----
              if (urgentTasks.isNotEmpty)
                _buildAlertCard(context, urgentTasks.length),
              if (urgentTasks.isNotEmpty) const SizedBox(height: 16),

              // ---- Today's Task Summary Card ----
              _buildTaskSummaryCard(context, userName, pendingTasks.length),
              const SizedBox(height: 20),

              // ---- User Profile Section ----
              _buildProfileSection(context, userName, user?.branch ?? '', user?.role ?? ''),
              const SizedBox(height: 24),

              // ---- Quick Menu Grid ----
              const QuickMenuGrid(),
              const SizedBox(height: 24),

              // ---- Opinion Input Section ----
              _buildOpinionInputSection(context),
              const SizedBox(height: 24),

              // ---- Shared Notices Section ----
              _buildNoticesSection(context, notices, colorScheme),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // ---------- Alert Card ----------
  Widget _buildAlertCard(BuildContext context, int alertCount) {
    return GestureDetector(
      onTap: () => context.go('/tasks'),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF0E6),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFFFD0A8), width: 0.8),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFFFF6B6B).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.notifications_active,
                color: Color(0xFFFF6B6B),
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Alert',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 14,
                          color: const Color(0xFFFF6B6B),
                        ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '지금 진행해야 할 업무가 $alertCount건 있습니다.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 13,
                          color: const Color(0xFF636E72),
                        ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: Color(0xFFFF6B6B),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  // ---------- Today's Task Summary Card ----------
  Widget _buildTaskSummaryCard(
      BuildContext context, String userName, int taskCount) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.primary,
            colorScheme.primary.withValues(alpha: 0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withValues(alpha: 0.25),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sungmin Park',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 6),
                Text(
                  '오늘 하루 업무 $taskCount건\n확인해주세요.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.9),
                        height: 1.4,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  AppDateUtils.formatFullDate(DateTime.now()),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 12,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white.withValues(alpha: 0.25),
            child: const Icon(
              Icons.person,
              size: 32,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // ---------- Profile Section ----------
  Widget _buildProfileSection(
      BuildContext context, String name, String branch, String role) {
    final roleName = role == 'manager' ? '매니저' : '직원';

    return Row(
      children: [
        CircleAvatar(
          radius: 26,
          backgroundColor: const Color(0xFFD6E8F7),
          child: const Icon(
            Icons.person,
            color: Color(0xFF5B9BD5),
            size: 28,
          ),
        ),
        const SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sungmin Park',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 16,
                  ),
            ),
            const SizedBox(height: 2),
            Text(
              '$branch / $roleName',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 13,
                    color: const Color(0xFF636E72),
                  ),
            ),
          ],
        ),
      ],
    );
  }

  // ---------- Opinion Input Section ----------
  Widget _buildOpinionInputSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '의견 보내기',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 16,
              ),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFFF8F9FA),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFDFE6E9)),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: '자유롭게 의견을 작성해주세요...',
                    hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFFB2BEC3),
                          fontSize: 14,
                        ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    filled: false,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('의견이 전송되었습니다.')),
                  );
                },
                icon: const Icon(Icons.send, color: Color(0xFF5B9BD5)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ---------- Shared Notices Section ----------
  Widget _buildNoticesSection(
      BuildContext context, List notices, ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '공유 공지 사항',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 16,
                  ),
            ),
            TextButton(
              onPressed: () => context.go('/notices'),
              child: Text(
                '더보기',
                style: TextStyle(
                  color: colorScheme.primary,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ...notices.take(3).map((notice) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: GestureDetector(
              onTap: () => context.push('/notices/${notice.id}'), // Use push for stack
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FA),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: notice.isImportant
                        ? colorScheme.primary.withValues(alpha: 0.3)
                        : const Color(0xFFDFE6E9),
                    width: 0.8,
                  ),
                ),
                child: Row(
                  children: [
                    if (notice.isImportant)
                      Container(
                        width: 6,
                        height: 6,
                        margin: const EdgeInsets.only(right: 10),
                        decoration: const BoxDecoration(
                          color: Color(0xFFFF6B6B),
                          shape: BoxShape.circle,
                        ),
                      ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            notice.title,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF2D3436),
                                  fontSize: 14,
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${notice.author} | ${AppDateUtils.formatShortDate(notice.createdAt)}',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: const Color(0xFF636E72),
                                      fontSize: 12,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right,
                      color: Color(0xFFB2BEC3),
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}

// ---------- Badge Chip ----------
class _BadgeChip extends StatelessWidget {
  final String label;
  final Color color;

  const _BadgeChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
