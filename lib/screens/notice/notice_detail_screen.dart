import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/comment.dart';
import '../../providers/notice_provider.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/comment_bubble.dart';
import '../../utils/date_utils.dart';
import '../../widgets/common_app_bar.dart';

class NoticeDetailScreen extends ConsumerStatefulWidget {
  final String noticeId;

  const NoticeDetailScreen({super.key, required this.noticeId});

  @override
  ConsumerState<NoticeDetailScreen> createState() => _NoticeDetailScreenState();
}

class _NoticeDetailScreenState extends ConsumerState<NoticeDetailScreen> {
  final _commentController = TextEditingController();
  final List<Comment> _comments = [];
  bool _confirmed = false;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _addComment() {
    final text = _commentController.text.trim();
    if (text.isEmpty) return;

    final user = ref.read(currentUserProvider);
    setState(() {
      _comments.add(Comment(
        id: 'nc-${DateTime.now().millisecondsSinceEpoch}',
        userId: user?.id ?? '',
        userName: user?.name ?? '',
        content: text,
        createdAt: DateTime.now(),
        isManager: user?.role == 'manager',
      ));
    });
    _commentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final notices = ref.watch(noticeListProvider);
    final notice = notices.where((n) => n.id == widget.noticeId).firstOrNull;

    if (notice == null) {
      return const Scaffold(
        appBar: CommonAppBar(
          title: '공지 상세',
          showNotification: false,
        ),
        body: Center(child: Text('공지사항을 찾을 수 없습니다.')),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CommonAppBar(
        title: '공지 상세',
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
                  // Important badge
                  if (notice.isImportant)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF6B6B),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        '중요',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  // Title
                  Text(
                    notice.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D3436),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Meta info
                  Row(
                    children: [
                      Icon(Icons.person_outline,
                          size: 16, color: Colors.grey[400]),
                      const SizedBox(width: 4),
                      Text(
                        notice.author,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[500],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Icon(Icons.access_time,
                          size: 16, color: Colors.grey[400]),
                      const SizedBox(width: 4),
                      Text(
                        AppDateUtils.formatDateTime(notice.createdAt),
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 16),
                  // Content
                  Text(
                    notice.content,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Color(0xFF2D3436),
                      height: 1.7,
                    ),
                  ),
                  const SizedBox(height: 28),
                  // Confirm button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _confirmed
                          ? null
                          : () {
                              setState(() => _confirmed = true);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('확인 완료되었습니다.'),
                                ),
                              );
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _confirmed
                            ? const Color(0xFFB2BEC3)
                            : const Color(0xFF5B9BD5),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: Text(_confirmed ? '확인 완료' : '확인 완료'),
                    ),
                  ),
                  const SizedBox(height: 28),
                  // Comment section
                  const Text(
                    '댓글',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2D3436),
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (_comments.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                        child: Text(
                          '아직 댓글이 없습니다.',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 14,
                          ),
                        ),
                      ),
                    )
                  else
                    ...List.generate(_comments.length, (index) {
                      return CommentBubble(comment: _comments[index]);
                    }),
                ],
              ),
            ),
          ),
          // Comment input bar
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.15),
                  offset: const Offset(0, -1),
                  blurRadius: 4,
                ),
              ],
            ),
            padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _commentController,
                      decoration: InputDecoration(
                        hintText: '댓글을 입력하세요...',
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 14,
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF1F3F5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                      ),
                      onSubmitted: (_) => _addComment(),
                    ),
                  ),
                  const SizedBox(width: 4),
                  IconButton(
                    onPressed: _addComment,
                    icon: const Icon(
                      Icons.send_rounded,
                      color: Color(0xFF5B9BD5),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
