import 'package:flutter/material.dart';

class InfoInputStep extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const InfoInputStep({
    super.key,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  State<InfoInputStep> createState() => _InfoInputStepState();
}

class _InfoInputStepState extends State<InfoInputStep> {
  final _nameController = TextEditingController();
  final _idController = TextEditingController();
  final _pwController = TextEditingController();
  final _pwConfirmController = TextEditingController();
  String? _selectedBranch;
  String? _selectedLanguage;
  bool _idChecked = false;

  final _branches = ['강남점', '홍대점', '명동점', '잠실점', '신촌점'];
  final _languages = ['한국어', 'English', '日本語', '中文'];

  @override
  void dispose() {
    _nameController.dispose();
    _idController.dispose();
    _pwController.dispose();
    _pwConfirmController.dispose();
    super.dispose();
  }

  void _checkDuplicate() {
    // Mock - always available
    setState(() => _idChecked = true);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('사용 가능한 ID입니다.')),
    );
  }

  void _confirmPassword() {
    if (_pwController.text == _pwConfirmController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('비밀번호가 일치합니다.')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('비밀번호가 일치하지 않습니다.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '정보 입력',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 24),
          // Name
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(hintText: '이름'),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD6E8F7),
                    foregroundColor: const Color(0xFF5B9BD5),
                  ),
                  child: const Text('저장'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // ID
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _idController,
                  decoration: const InputDecoration(hintText: 'ID'),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: _idChecked ? null : _checkDuplicate,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD6E8F7),
                    foregroundColor: const Color(0xFF5B9BD5),
                  ),
                  child: const Text('중복 확인'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Password
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _pwController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: '비밀번호를 설정해주세요.',
                  ),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD6E8F7),
                    foregroundColor: const Color(0xFF5B9BD5),
                  ),
                  child: const Text('저장'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Password Confirm
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _pwConfirmController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: '비밀번호를 중복 확인해주세요.',
                  ),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: _confirmPassword,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD6E8F7),
                    foregroundColor: const Color(0xFF5B9BD5),
                  ),
                  child: const Text('확인'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Branch dropdown
          Text(
            '근무지를 선택해주세요(중복선택 가능)',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            initialValue: _selectedBranch,
            hint: const Text('옵션 선택'),
            decoration: const InputDecoration(),
            items: _branches.map((branch) {
              return DropdownMenuItem(value: branch, child: Text(branch));
            }).toList(),
            onChanged: (value) {
              setState(() => _selectedBranch = value);
            },
          ),
          const SizedBox(height: 16),
          // Language dropdown
          Text(
            '언어를 선택해주세요.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            initialValue: _selectedLanguage,
            hint: const Text('옵션 선택'),
            decoration: const InputDecoration(),
            items: _languages.map((lang) {
              return DropdownMenuItem(value: lang, child: Text(lang));
            }).toList(),
            onChanged: (value) {
              setState(() => _selectedLanguage = value);
            },
          ),
          const SizedBox(height: 32),
          // Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: widget.onPrevious,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFF5B9BD5),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('이전'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: widget.onNext,
                  child: const Text('다음 >'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
