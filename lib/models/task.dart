import 'comment.dart';

enum TaskType { daily, assigned }

enum Priority { urgent, normal, low }

enum TaskStatus { todo, inProgress, done }

enum VerificationType { none, photo }

class ChecklistItem {
  final String id;
  final String title;
  bool isCompleted;
  final VerificationType verificationType;
  String? verificationData;

  ChecklistItem({
    required this.id,
    required this.title,
    this.isCompleted = false,
    this.verificationType = VerificationType.none,
    this.verificationData,
  });

  ChecklistItem copyWith({
    String? id,
    String? title,
    bool? isCompleted,
    VerificationType? verificationType,
    String? verificationData,
  }) {
    return ChecklistItem(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      verificationType: verificationType ?? this.verificationType,
      verificationData: verificationData ?? this.verificationData,
    );
  }
}

class Task {
  final String id;
  final TaskType type;
  final String title;
  final String description;
  final Priority priority;
  TaskStatus status;
  final DateTime startDate;
  final DateTime dueDate;
  final String assignedTo;
  final String assignedBy;
  final List<String> labels;
  List<ChecklistItem>? checklist;
  List<Comment>? comments;
  String? proofImagePath;

  Task({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.priority,
    required this.status,
    required this.startDate,
    required this.dueDate,
    required this.assignedTo,
    required this.assignedBy,
    required this.labels,
    this.checklist,
    this.comments,
    this.proofImagePath,
  });

  Task copyWith({
    String? id,
    TaskType? type,
    String? title,
    String? description,
    Priority? priority,
    TaskStatus? status,
    DateTime? startDate,
    DateTime? dueDate,
    String? assignedTo,
    String? assignedBy,
    List<String>? labels,
    List<ChecklistItem>? checklist,
    List<Comment>? comments,
    String? proofImagePath,
  }) {
    return Task(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      startDate: startDate ?? this.startDate,
      dueDate: dueDate ?? this.dueDate,
      assignedTo: assignedTo ?? this.assignedTo,
      assignedBy: assignedBy ?? this.assignedBy,
      labels: labels ?? this.labels,
      checklist: checklist ?? this.checklist,
      comments: comments ?? this.comments,
      proofImagePath: proofImagePath ?? this.proofImagePath,
    );
  }
}
