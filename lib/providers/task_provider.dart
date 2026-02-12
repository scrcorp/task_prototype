import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task.dart';
import '../data/mock_data.dart';

class TaskNotifier extends StateNotifier<List<Task>> {
  TaskNotifier() : super([...mockDailyTasks, ...mockAssignedTasks]);

  void updateTaskStatus(String taskId, TaskStatus newStatus) {
    state = [
      for (final task in state)
        if (task.id == taskId) task.copyWith(status: newStatus) else task,
    ];
  }

  void toggleChecklistItem(String taskId, String checklistItemId) {
    state = [
      for (final task in state)
        if (task.id == taskId)
          task.copyWith(
            checklist: task.checklist?.map((item) {
              if (item.id == checklistItemId) {
                return item.copyWith(isCompleted: !item.isCompleted);
              }
              return item;
            }).toList(),
          )
        else
          task,
    ];
  }
}

final taskListProvider =
    StateNotifierProvider<TaskNotifier, List<Task>>((ref) {
  return TaskNotifier();
});

final dailyTasksProvider = Provider<List<Task>>((ref) {
  final tasks = ref.watch(taskListProvider);
  return tasks.where((t) => t.type == TaskType.daily).toList();
});

final assignedTasksProvider = Provider<List<Task>>((ref) {
  final tasks = ref.watch(taskListProvider);
  return tasks.where((t) => t.type == TaskType.assigned).toList();
});

final taskProgressProvider = Provider<double>((ref) {
  final tasks = ref.watch(taskListProvider);
  if (tasks.isEmpty) return 0.0;
  final done = tasks.where((t) => t.status == TaskStatus.done).length;
  return done / tasks.length;
});
