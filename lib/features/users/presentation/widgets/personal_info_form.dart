import 'package:pet_care/core/constant/theme/context_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care/features/users/domain/entity/user.dart';

import 'package:pet_care/core/constant/l10n/l10x.dart';
class PersonalInfoForm extends StatefulWidget {
  final TextEditingController nameController;
  final User? user;
  final ValueChanged<String>? onNameSaved; // callback to persist the new name

  const PersonalInfoForm({
    super.key,
    required this.nameController,
    this.user,
    this.onNameSaved,
  });

  @override
  State<PersonalInfoForm> createState() => _PersonalInfoFormState();
}

class _PersonalInfoFormState extends State<PersonalInfoForm> {
  bool _isEditingName = false;
  final FocusNode _nameFocusNode = FocusNode();

 

  @override
  void initState() {
    super.initState();
    // Pre-fill controller with current name if empty
    if (widget.nameController.text.isEmpty) {
      widget.nameController.text = widget.user?.name ?? '';
    }
  }

  void _enterEditMode() {
    setState(() => _isEditingName = true);
    // Focus the field right after the frame builds
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _nameFocusNode.requestFocus();
    });
  }

  void _saveName() {
    setState(() => _isEditingName = false);
    final newName = widget.nameController.text.trim();
    if (newName.isNotEmpty) {
      widget.onNameSaved?.call(newName);
    }
  }

  @override
  void dispose() {
    _nameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
      final Color ink = context.colors.onSurface;
      final Color inkSoft = context.colors.onSurfaceVariant;
      final Color inkMuted = context.colors.onSurfaceVariant;
      
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.h),
        // Name field — editable
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: context.colors.surfaceContainer,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _isEditingName
                  ? context.colors.primary
                  : context.colors.outlineVariant,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: _isEditingName
                    ? Theme(
                        data: Theme.of(context).copyWith(
                          textSelectionTheme: TextSelectionThemeData(
                            selectionColor: context.colors.primary.withOpacity(
                              0.2,
                            ), // the highlight color behind selected text
                            cursorColor:
                                context.colors.primary, // the blinking cursor
                            selectionHandleColor: context
                                .colors
                                .primary, // the teardrop drag handle
                          ),
                        ),
                        child: TextField(
                          controller: widget.nameController,
                          focusNode: _nameFocusNode,
                          autofocus: true,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: ink,
                          ),
                          decoration: const InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                          ),
                          onSubmitted: (_) => _saveName(),
                        ),
                      )
                    : Text(
                        widget.nameController.text.isNotEmpty
                            ? widget.nameController.text
                            : (widget.user?.name ?? context.l10n.userName),
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: ink,
                        ),
                      ),
              ),
              GestureDetector(
                onTap: _isEditingName ? _saveName : _enterEditMode,
                child: Icon(
                  _isEditingName ? Icons.check : Icons.edit_outlined,
                  color: _isEditingName
                      ? context.colors.primary
                      : inkMuted.withValues(alpha: 0.6),
                  size: 16,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Email field — unchanged, read-only
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: context.colors.outlineVariant.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: context.colors.outlineVariant),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  widget.user?.email ?? 'sarah.j@example.com',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: inkMuted,
                  ),
                ),
              ),
              Icon(
                Icons.lock,
                color: inkMuted.withValues(alpha: 0.4),
                size: 14,
              ),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsetsDirectional.only(start: 4, top: 8),
          child: Row(
            children: [
              Text(
                context.l10n.emailCannotBeChanged,
                style: TextStyle(fontSize: 11, color: inkSoft),
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  context.l10n.contactSupport,
                  style: TextStyle(
                    fontSize: 11,
                    color: context.colors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}