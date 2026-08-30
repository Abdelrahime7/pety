import 'package:flutter/material.dart';

class SecurityActionCard extends StatelessWidget {
  final VoidCallback onTap;

  const SecurityActionCard({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    const Color ink = Color(0xFF0F172A);
    const Color inkSoft = Color(0xFF94A3B8);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: const Color(0xFFF1F5F9)),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4)],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 40, height: 40,
                  decoration: BoxDecoration(color: const Color(0xFFFFF1F2), borderRadius: BorderRadius.circular(16)),
                  child: const Icon(Icons.key, color: Color(0xFFF43F5E), size: 16),
                ),
                const SizedBox(width: 16),
                const Text('Change Password', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: ink)),
              ],
            ),
            const Icon(Icons.chevron_right, color: inkSoft, size: 16),
          ],
        ),
      ),
    );
  }
}
