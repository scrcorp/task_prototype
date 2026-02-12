import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class QuickMenuGrid extends StatelessWidget {
  const QuickMenuGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final menus = [
      _QuickMenuItem(
        icon: Icons.assignment,
        label: '내 업무',
        onTap: () => context.go('/tasks'),
      ),
      _QuickMenuItem(
        icon: Icons.access_time,
        label: '출퇴근',
        onTap: () => _showPreparing(context),
      ),
      _QuickMenuItem(
        icon: Icons.calendar_month,
        label: '스케줄',
        onTap: () => _showPreparing(context),
      ),
      _QuickMenuItem(
        icon: Icons.school,
        label: 'OJT',
        onTap: () => _showPreparing(context),
      ),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: menus
          .map((menu) => _QuickMenuTile(item: menu))
          .toList(),
    );
  }

  void _showPreparing(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('준비 중입니다.'),
        duration: Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

class _QuickMenuItem {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickMenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });
}

class _QuickMenuTile extends StatelessWidget {
  final _QuickMenuItem item;

  const _QuickMenuTile({required this.item});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: item.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                item.icon,
                color: colorScheme.primary,
                size: 26,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              item.label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF2D3436),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
