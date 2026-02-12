import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showProfile;
  final bool showNotification;
  final VoidCallback? onProfilePressed;
  final VoidCallback? onNotificationPressed;

  const CommonAppBar({
    super.key,
    required this.title,
    this.showProfile = false,
    this.showNotification = true,
    this.onProfilePressed,
    this.onNotificationPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Color(0xFF2D3436),
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      leading: showProfile
          ? IconButton(
              onPressed: onProfilePressed ?? () => context.push('/mypage'),
              icon: const Icon(Icons.person_outline, size: 24),
              style: IconButton.styleFrom(
                foregroundColor: const Color(0xFF636E72),
              ),
            )
          : IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back_ios, size: 20),
              style: IconButton.styleFrom(
                foregroundColor: const Color(0xFF636E72),
                  ),
                ),
      actions: [
        if (showNotification)
          IconButton(
            onPressed:
                onNotificationPressed ?? () => context.push('/notifications'),
            icon: const Icon(Icons.notifications_none, size: 24),
            style: IconButton.styleFrom(
              foregroundColor: const Color(0xFF636E72),
            ),
          )
        else
          const SizedBox(width: 48), // Match leading size for centering title
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
