import 'package:flutter/material.dart';

class EmailVerifyStep extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const EmailVerifyStep({
    super.key,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  State<EmailVerifyStep> createState() => _EmailVerifyStepState();
}

class _EmailVerifyStepState extends State<EmailVerifyStep> {
  final _emailController = TextEditingController();
  final _codeController = TextEditingController();
  bool _codeSent = false;
  bool _verified = false;

  @override
  void dispose() {
    _emailController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  void _sendCode() {
    if (_emailController.text.isNotEmpty) {
      setState(() => _codeSent = true);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('인증번호가 발송되었습니다.')),
      );
    }
  }

  void _verifyCode() {
    // Mock verification - always succeeds
    setState(() => _verified = true);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('인증이 완료되었습니다.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '이메일 본인 인증',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          '이메일 본인 인증을 진행해주세요.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: '이메일',
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: _codeSent ? null : _sendCode,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD6E8F7),
                  foregroundColor: const Color(0xFF5B9BD5),
                ),
                child: const Text('인증번호 보내기'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _codeController,
                decoration: const InputDecoration(
                  hintText: '인증번호',
                ),
                enabled: _codeSent,
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: _codeSent && !_verified ? _verifyCode : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD6E8F7),
                  foregroundColor: const Color(0xFF5B9BD5),
                ),
                child: const Text('인증'),
              ),
            ),
          ],
        ),
        const Spacer(),
        Row(
          children: [
            SizedBox(
              width: 100,
              child: OutlinedButton(
                onPressed: widget.onPrevious,
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF636E72),
                  side: const BorderSide(color: Color(0xFFDFE6E9)),
                ),
                child: const Text('이전'),
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 140,
              child: ElevatedButton(
                onPressed: _verified ? widget.onNext : null,
                child: const Text('다음 >'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
