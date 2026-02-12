import 'package:flutter/material.dart';

class TermsStep extends StatefulWidget {
  final VoidCallback onNext;

  const TermsStep({super.key, required this.onNext});

  @override
  State<TermsStep> createState() => _TermsStepState();
}

class _TermsStepState extends State<TermsStep> {
  final List<bool> _checked = [false, false, false];

  final List<String> _terms = [
    '계정 관련 약관에 동의 하시나요?',
    '000에 동의 하시나요?',
    '@@@에 동의 하시나요?',
  ];

  bool get _allChecked => _checked.every((v) => v);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '약관 동의',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 24),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF8F9FA),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFDFE6E9)),
          ),
          child: Text(
            '계정 관련 약관 약관',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        const SizedBox(height: 24),
        ...List.generate(_terms.length, (index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Checkbox(
                  value: _checked[index],
                  onChanged: (value) {
                    setState(() {
                      _checked[index] = value ?? false;
                    });
                  },
                  activeColor: const Color(0xFF5B9BD5),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _checked[index] = !_checked[index];
                      });
                    },
                    child: Text(
                      _terms[index],
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
        const Spacer(),
        SizedBox(
          width: 140,
          child: ElevatedButton(
            onPressed: _allChecked ? widget.onNext : null,
            child: const Text('다음 >'),
          ),
        ),
      ],
    );
  }
}
