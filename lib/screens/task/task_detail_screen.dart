import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/task.dart';
import '../../providers/task_provider.dart';
import '../../widgets/comment_bubble.dart';
import '../../utils/date_utils.dart';
import '../../widgets/common_app_bar.dart';

class TaskDetailScreen extends ConsumerStatefulWidget {
  final String taskId;

  const TaskDetailScreen({super.key, required this.taskId});

  @override
  ConsumerState<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends ConsumerState<TaskDetailScreen> {
  final _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tasks = ref.watch(taskListProvider);
    final task = tasks.firstWhere(
      (t) => t.id == widget.taskId,
      orElse: () => tasks.first,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: const CommonAppBar(
        title: '업무 상세',
        showNotification: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Task Info Card
                  _buildInfoCard(task),

                  const SizedBox(height: 16),

                  // Status Section
                  _buildStatusSection(task),

                  const SizedBox(height: 16),

                  // Photo Proof Section
                  if (task.status == TaskStatus.inProgress ||
                      task.status == TaskStatus.done)
                    _buildPhotoProofSection(task),

                  if (task.status == TaskStatus.inProgress ||
                      task.status == TaskStatus.done)
                    const SizedBox(height: 16),

                  // Comments Section
                  if (task.comments != null && task.comments!.isNotEmpty)
                    _buildCommentsSection(task),
                ],
              ),
            ),
          ),

          // Bottom action area
          _buildBottomActions(task),
        ],
      ),
    );
  }

  Widget _buildInfoCard(Task task) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            task.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3436),
            ),
          ),
          const SizedBox(height: 8),

          // Description
          Text(
            task.description,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),

          const Divider(height: 1, color: Color(0xFFEEEEEE)),
          const SizedBox(height: 16),

          // Start time
          _buildInfoRow('Start time', AppDateUtils.formatYearMonthDay(task.startDate)),
          const SizedBox(height: 10),

          // Due date
          _buildInfoRow('Due date', AppDateUtils.formatYearMonthDay(task.dueDate)),
          const SizedBox(height: 10),

          // Assigned to
          _buildInfoRow('Assigned to', task.assignedBy),
          const SizedBox(height: 10),

          // Labels
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 100,
                child: Text(
                  'Labels',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[500],
                  ),
                ),
              ),
              Expanded(
                child: Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: task.labels.map((label) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD6E8F7),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        label,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF5B9BD5),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[500],
            ),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF2D3436),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusSection(Task task) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '상태',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2D3436),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildStatusButton(
                '시작 전',
                TaskStatus.todo,
                task.status,
              ),
              const SizedBox(width: 8),
              Icon(Icons.arrow_forward_ios,
                  size: 12, color: Colors.grey[300]),
              const SizedBox(width: 8),
              _buildStatusButton(
                '진행 중',
                TaskStatus.inProgress,
                task.status,
              ),
              const SizedBox(width: 8),
              Icon(Icons.arrow_forward_ios,
                  size: 12, color: Colors.grey[300]),
              const SizedBox(width: 8),
              _buildStatusButton(
                '완료',
                TaskStatus.done,
                task.status,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusButton(
      String label, TaskStatus status, TaskStatus currentStatus) {
    final isActive = status == currentStatus;

    Color bgColor;
    Color textColor;
    if (isActive) {
      switch (status) {
        case TaskStatus.todo:
          bgColor = const Color(0xFFFFB84D);
          textColor = Colors.white;
        case TaskStatus.inProgress:
          bgColor = const Color(0xFF5B9BD5);
          textColor = Colors.white;
        case TaskStatus.done:
          bgColor = const Color(0xFF51CF66);
          textColor = Colors.white;
      }
    } else {
      bgColor = const Color(0xFFF1F3F5);
      textColor = Colors.grey[500]!;
    }

    return Expanded(
      child: GestureDetector(
        onTap: () {
          ref.read(taskListProvider.notifier).updateTaskStatus(
                widget.taskId,
                status,
              );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoProofSection(Task task) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '인증',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2D3436),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '작업 완료 인증을 해주세요.',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 16),

          // Image placeholder
          Container(
            width: double.infinity,
            height: 180,
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FA),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFDFE6E9)),
            ),
            child: task.proofImagePath != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      task.proofImagePath!,
                      fit: BoxFit.cover,
                    ),
                  )
                : CustomPaint(
                    painter: _CrossPainter(),
                    child: const Center(
                      child: Icon(
                        Icons.image_outlined,
                        size: 40,
                        color: Color(0xFFB2BEC3),
                      ),
                    ),
                  ),
          ),
          const SizedBox(height: 12),

          // Camera icons / colored circles
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildColorCircle(const Color(0xFFFF6B6B)),
              const SizedBox(width: 12),
              _buildColorCircle(const Color(0xFF51CF66)),
              const SizedBox(width: 12),
              _buildColorCircle(const Color(0xFF5B9BD5)),
            ],
          ),
          const SizedBox(height: 16),

          // DONE button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('사진 인증이 완료되었습니다.')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2D3436),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'DONE',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColorCircle(Color color) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('사진 업로드 기능 (프로토타입)')),
        );
      },
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.camera_alt_outlined,
          size: 16,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildCommentsSection(Task task) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '코멘트',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2D3436),
            ),
          ),
          const SizedBox(height: 16),
          ...task.comments!.map(
            (comment) => CommentBubble(comment: comment),
          ),
          const SizedBox(height: 8),
          // Comment input
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _commentController,
                  decoration: InputDecoration(
                    hintText: '메시지를 입력하세요...',
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[400],
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF8F9FA),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Color(0xFFDFE6E9)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Color(0xFFDFE6E9)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          const BorderSide(color: Color(0xFF5B9BD5), width: 1.5),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  if (_commentController.text.isNotEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('코멘트 전송 (프로토타입)')),
                    );
                    _commentController.clear();
                  }
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Color(0xFF5B9BD5),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.send,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions(Task task) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
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
                '취소',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF636E72),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: task.status == TaskStatus.done
                  ? null
                  : () {
                      final nextStatus = task.status == TaskStatus.todo
                          ? TaskStatus.inProgress
                          : TaskStatus.done;
                      ref
                          .read(taskListProvider.notifier)
                          .updateTaskStatus(widget.taskId, nextStatus);
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5B9BD5),
                foregroundColor: Colors.white,
                disabledBackgroundColor: const Color(0xFFB2BEC3),
                disabledForegroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                task.status == TaskStatus.done
                    ? '완료됨'
                    : task.status == TaskStatus.todo
                        ? '작업 시작'
                        : '작업 완료',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Painter for X-cross placeholder image
class _CrossPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFDFE6E9)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    canvas.drawLine(Offset.zero, Offset(size.width, size.height), paint);
    canvas.drawLine(Offset(size.width, 0), Offset(0, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
