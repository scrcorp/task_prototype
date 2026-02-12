import 'package:flutter/material.dart';
import '../../widgets/common_app_bar.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CommonAppBar(
        title: '알림',
        showNotification: false,
      ),
      body: Center(
        child: Text('알림이 없습니다.'),
      ),
    );
  }
}
