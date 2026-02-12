import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/notice.dart';
import '../data/mock_data.dart';

class NoticeNotifier extends StateNotifier<List<Notice>> {
  NoticeNotifier() : super([...mockNotices]);
}

final noticeListProvider =
    StateNotifierProvider<NoticeNotifier, List<Notice>>((ref) {
  return NoticeNotifier();
});
