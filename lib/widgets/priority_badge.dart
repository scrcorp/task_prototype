import 'package:flutter/material.dart';
import '../models/task.dart';
import '../theme/app_theme.dart';

class PriorityBadge extends StatelessWidget {
  final Priority priority;

  const PriorityBadge({super.key, required this.priority});

  String get _label {
    switch (priority) {
      case Priority.urgent:
        return '긴급';
      case Priority.normal:
        return '보통';
      case Priority.low:
        return '여유';
    }
  }

  Color get _color {
    switch (priority) {
      case Priority.urgent:
        return AppTheme.urgentColor;
      case Priority.normal:
        return AppTheme.normalColor;
      case Priority.low:
        return AppTheme.lowColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        _label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
