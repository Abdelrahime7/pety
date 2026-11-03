import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_care/core/constant/l10n/l10x.dart';
import 'package:pet_care/core/constant/l10n/provider.dart';
import 'package:pet_care/core/constant/theme/context_x.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_care/core/constant/routers/app_routers.dart';
import 'package:pet_care/core/constant/routers/routes_strings.dart';
import 'package:pet_care/core/constant/theme/theme_prvider.dart';

class SettingsSections extends ConsumerStatefulWidget {
  final dynamic user;

  const SettingsSections({super.key, required this.user});

  @override
  ConsumerState<SettingsSections> createState() => _SettingsSectionsState();
}

class _SettingsSectionsState extends ConsumerState<SettingsSections> {
  bool _cloudBackup = true;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Text shown on the Language row: the chosen language or "System default".
    final selectedLocale = ref.watch(localeProvider);
    final languageLabel = switch (selectedLocale?.languageCode) {
      'en' => l10n.languageEnglish,
      'ar' => l10n.languageArabic,
      _ => l10n.languageSystem,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. ACCOUNT & SECURITY
        _buildSectionHeader(l10n.accountAndSecurity),
        const SizedBox(height: 12),
        _buildGroupCard(
          children: [
            _buildNavigationTile(
              icon: Icons.person,
              title: l10n.personalInformation,
              onTap: () => context.push(profileInfo),
            ),
            _buildDivider(),
            _buildNavigationTile(
              icon: Icons.notifications,
              title: l10n.notificationSettings,
              onTap: () {
                appRouter.push(notificationSettings, extra: widget.user);
              },
            ),
            _buildDivider(),
            _buildNavigationTile(
              icon: Icons.shield,
              title: l10n.privacyAndSecurity,
              onTap: () {},
            ),
          ],
        ),

        const SizedBox(height: 28),

        // 2. APP PREFERENCES
        _buildSectionHeader(l10n.appPreferences),
        const SizedBox(height: 12),
        _buildGroupCard(
          children: [
            _buildSwitchTile(
              icon: Icons.nightlight_round,
              title: l10n.darkMode,
              value: isDark,
              onChanged: (val) {
                ref
                    .read(themeModeProvider.notifier)
                    .setTheme(val ? ThemeMode.dark : ThemeMode.light);
              },
            ),
            _buildDivider(),
            _buildNavigationTile(
              icon: Icons.language,
              title: l10n.language,
              trailingText: languageLabel,
              onTap: _showLanguageSheet,
            ),
            _buildDivider(),
            _buildSwitchTile(
              icon: Icons.cloud,
              title: l10n.cloudBackup,
              value: _cloudBackup,
              onChanged: (val) => setState(() => _cloudBackup = val),
            ),
          ],
        ),
      ],
    );
  }

  // Language picker (System / English / Arabic)
  void _showLanguageSheet() {
    final l10n = context.l10n;
    final current = ref.read(localeProvider)?.languageCode;

    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) {
        Widget option(String label, Locale? locale, String? code) {
          return ListTile(
            title: Text(label),
            trailing: current == code
                ? Icon(Icons.check, color: sheetContext.colors.primary)
                : null,
            onTap: () {
              ref.read(localeProvider.notifier).setLocale(locale);
              Navigator.pop(sheetContext);
            },
          );
        }

        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: 24,
                  end: 24,
                  bottom: 8,
                ),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    l10n.chooseLanguage,
                    style: Theme.of(sheetContext).textTheme.titleMedium,
                  ),
                ),
              ),
              option(l10n.languageSystem, null, null),
              option(l10n.languageEnglish, const Locale('en'), 'en'),
              option(l10n.languageArabic, const Locale('ar'), 'ar'),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  // Section Header Label
  Widget _buildSectionHeader(String title) {
    // toUpperCase only affects Latin letters; Arabic is unchanged.
    return Text(title.toUpperCase(), style: context.style.sectionHeader);
  }

  // White Rounded Card Container
  Widget _buildGroupCard({required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: context.colors.outlineVariant.withValues(alpha: 0.6),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
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
    String? trailingText,
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
            Expanded(child: Text(title, style: context.style.tileTitle)),
            if (trailingText != null) ...[
              Text(
                trailingText,
                style: TextStyle(
                  fontSize: 13,
                  color: context.colors.onSurfaceVariant,
                ),
              ),
              const SizedBox(width: 4),
            ],
            // chevron_right flips to point left automatically in RTL.
            Icon(
              Icons.chevron_right,
              size: 20,
              color: context.colors.onSurfaceVariant,
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
          Expanded(child: Text(title, style: context.style.tileTitle)),
          CupertinoSwitch(
            value: value,
            activeTrackColor: context.colors.primary,
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
        color: context.colors.surfaceContainer,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Icon(icon, size: 20, color: context.colors.onSurfaceVariant),
    );
  }

  // Thin Subtle Divider
  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 1,
      indent: 72,
      endIndent: 16,
      color: context.colors.surface,
    );
  }
}