import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/comment.dart';

class CommentBubble extends StatelessWidget {
  final Comment comment;

  const CommentBubble({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    final isManager = comment.isManager;
    final timeFormat = DateFormat('HH:mm');

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment:
            isManager ? MainAxisAlignment.start : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isManager) ...[
            CircleAvatar(
              radius: 16,
              backgroundColor: const Color(0xFF5B9BD5),
              child: Text(
                comment.userName[0],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment:
                  isManager ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              children: [
                Text(
                  comment.userName,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: isManager
                        ? const Color(0xFFF1F3F5)
                        : const Color(0xFFD6E8F7),
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(16),
                      topRight: const Radius.circular(16),
                      bottomLeft: isManager
                          ? const Radius.circular(4)
                          : const Radius.circular(16),
                      bottomRight: isManager
                          ? const Radius.circular(16)
                          : const Radius.circular(4),
                    ),
                  ),
                  child: Text(
                    comment.content,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF2D3436),
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  timeFormat.format(comment.createdAt),
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
          ),
          if (!isManager) ...[
            const SizedBox(width: 8),
            CircleAvatar(
              radius: 16,
              backgroundColor: const Color(0xFF7EC8C8),
              child: Text(
                comment.userName[0],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
