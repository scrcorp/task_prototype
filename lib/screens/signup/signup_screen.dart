import 'package:flutter/material.dart';
import 'terms_step.dart';
import 'email_verify_step.dart';
import 'info_input_step.dart';
import 'complete_step.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  int _currentStep = 0;

  final _stepLabels = ['약관동의', '본인인증', '정보 입력', '가입 완료'];

  void _next() {
    if (_currentStep < 3) {
      setState(() => _currentStep++);
    }
  }

  void _previous() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildStepIndicator(),
            const Divider(height: 1),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: _buildCurrentStep(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Row(
        children: List.generate(_stepLabels.length, (index) {
          final isActive = index == _currentStep;
          final isCompleted = index < _currentStep;
          return Expanded(
            child: Column(
              children: [
                Container(
                  height: 3,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: isActive || isCompleted
                        ? const Color(0xFF5B9BD5)
                        : const Color(0xFFDFE6E9),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _stepLabels[index],
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                    color: isActive || isCompleted
                        ? const Color(0xFF2D3436)
                        : const Color(0xFFB2BEC3),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return TermsStep(onNext: _next);
      case 1:
        return EmailVerifyStep(onNext: _next, onPrevious: _previous);
      case 2:
        return InfoInputStep(onNext: _next, onPrevious: _previous);
      case 3:
        return const CompleteStep();
      default:
        return const SizedBox.shrink();
    }
  }
}
