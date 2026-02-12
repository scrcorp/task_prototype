import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';

class ChecklistBottomSheet extends ConsumerWidget {
  const ChecklistBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dailyTasks = ref.watch(dailyTasksProvider);

    // Flatten all checklist items across daily tasks
    final allItems = <_ChecklistEntry>[];
    for (final task in dailyTasks) {
      if (task.checklist != null) {
        for (final item in task.checklist!) {
          allItems.add(_ChecklistEntry(
            taskId: task.id,
            taskTitle: task.title,
            item: item,
          ));
        }
      }
    }

    // Sort: Incomplete first, then completed
    allItems.sort((a, b) {
      if (a.item.isCompleted == b.item.isCompleted) {
        return 0;
      }
      return a.item.isCompleted ? 1 : -1;
    });

    final completedCount = allItems.where((e) => e.item.isCompleted).length;
    final totalCount = allItems.length;
    final progress = totalCount > 0 ? completedCount / totalCount : 0.0;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),
          // Title
          const Text(
            'Dailly Checklist',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3436),
            ),
          ),
          const SizedBox(height: 16),
          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: const Color(0xFFE0E0E0),
              valueColor:
                  const AlwaysStoppedAnimation<Color>(Color(0xFF5B9BD5)),
            ),
          ),
          const SizedBox(height: 20),
          // Checklist items
          Flexible(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: allItems.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final entry = allItems[index];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  onTap: () {
                    if (!entry.item.isCompleted &&
                        entry.item.verificationType == VerificationType.photo) {
                      _showVerificationDialog(context, ref, entry);
                    } else {
                      ref
                          .read(taskListProvider.notifier)
                          .toggleChecklistItem(entry.taskId, entry.item.id);
                    }
                  },
                  title: Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${entry.taskTitle}, ${entry.item.title}',
                          style: TextStyle(
                            fontSize: 14,
                            color: entry.item.isCompleted
                                ? Colors.grey[400]
                                : const Color(0xFF2D3436),
                            decoration: entry.item.isCompleted
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                      ),
                      if (entry.item.verificationType == VerificationType.photo)
                        const Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Icon(Icons.camera_alt,
                              size: 16, color: Colors.grey),
                        ),
                    ],
                  ),
                  subtitle: entry.item.isCompleted
                      ? Text(
                          '완료됨',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[400],
                          ),
                        )
                      : null,
                  trailing: Icon(
                    entry.item.isCompleted
                        ? Icons.radio_button_checked
                        : Icons.radio_button_unchecked,
                    color: entry.item.isCompleted
                        ? const Color(0xFF5B9BD5)
                        : Colors.grey[400],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          // Close button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                side: const BorderSide(color: Color(0xFFDFE6E9)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'close',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF2D3436),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showVerificationDialog(
      BuildContext context, WidgetRef ref, _ChecklistEntry entry) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('인증 필요'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('이 업무는 사진 인증이 필요합니다.'),
            SizedBox(height: 16),
            Icon(Icons.camera_alt, size: 48, color: Colors.grey),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          ElevatedButton(
            onPressed: () {
              ref
                  .read(taskListProvider.notifier)
                  .toggleChecklistItem(entry.taskId, entry.item.id);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('사진이 인증되었습니다.')),
              );
            },
            child: const Text('사진 촬영/업로드'),
          ),
        ],
      ),
    );
  }
}

class _ChecklistEntry {
  final String taskId;
  final String taskTitle;
  final ChecklistItem item;

  _ChecklistEntry({
    required this.taskId,
    required this.taskTitle,
    required this.item,
  });
}
