
import 'package:flutter/material.dart';

class LogoutActionCard extends StatelessWidget {
  final VoidCallback onTap;

  const LogoutActionCard({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const Color ink = Color(0xFF0F172A);
    const Color inkSoft = Color(0xFF94A3B8);
    const Color danger = Color(0xFFF43F5E);
    const Color dangerBackground = Color(0xFFFFF1F2);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(
            color: const Color(0xFFF1F5F9),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 4,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: dangerBackground,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.logout_rounded,
                    color: danger,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 16),
                const Text(
                  'Log Out',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: ink,
                  ),
                ),
              ],
            ),
            const Icon(
              Icons.chevron_right,
              color: inkSoft,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}

