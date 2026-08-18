import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';

class SettingsSections extends StatefulWidget {
  const SettingsSections({super.key});

  @override
  State<SettingsSections> createState() => _SettingsSectionsState();
}

class _SettingsSectionsState extends State<SettingsSections> {
  bool _darkMode = false;
  bool _cloudBackup = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. ACCOUNT & SECURITY
        _buildSectionHeader('ACCOUNT & SECURITY'),
        const SizedBox(height: 12),
        _buildGroupCard(
          children: [
            _buildNavigationTile(
              icon: Icons.person,
              title: 'Personal Information',
              onTap: () {},
            ),
            _buildDivider(),
            _buildNavigationTile(
              icon: Icons.notifications,
              title: 'Notification Settings',
              onTap: () {},
            ),
            _buildDivider(),
            _buildNavigationTile(
              icon: Icons.shield,
              title: 'Privacy & Security',
              onTap: () {},
            ),
          ],
        ),

        const SizedBox(height: 28),

        // 2. APP PREFERENCES
        _buildSectionHeader('APP PREFERENCES'),
        const SizedBox(height: 12),
        _buildGroupCard(
          children: [
            _buildSwitchTile(
              icon: Icons.nightlight_round,
              title: 'Dark Mode',
              value: _darkMode,
              onChanged: (val) => setState(() => _darkMode = val),
            ),
            _buildDivider(),
            _buildSwitchTile(
              icon: Icons.cloud,
              title: 'Cloud Backup',
              value: _cloudBackup,
              onChanged: (val) => setState(() => _cloudBackup = val),
            ),
          ],
        ),
      ],
    );
  }

  // Section Header Label
  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        color: AppColors.secondaryText,
        letterSpacing: 1.1,
      ),
    );
  }

  // White Rounded Card Container
  Widget _buildGroupCard({required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border.withOpacity(0.6), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  // Navigation Tile
  Widget _buildNavigationTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            _buildIconContainer(icon),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.text,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right,
              size: 20,
              color: AppColors.secondaryText,
            ),
          ],
        ),
      ),
    );
  }

  // Switch Tile
  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          _buildIconContainer(icon),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.text,
              ),
            ),
          ),
          CupertinoSwitch(
            value: value,
            activeTrackColor: AppColors.primary,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  // Rounded Light Gray Icon Box
  Widget _buildIconContainer(IconData icon) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Icon(icon, size: 20, color: const Color(0xFF64748B)),
    );
  }

  // Thin Subtle Divider
  Widget _buildDivider() {
    return const Divider(
      height: 1,
      thickness: 1,
      indent: 72,
      endIndent: 16,
      color: Color(0xFFF8FAFC),
    );
  }
}
