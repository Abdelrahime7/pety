import 'package:pet_care/core/constant/theme/context_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:pet_care/features/health/vaccination/domain/entities/vaccination_record.dart';

import 'package:pet_care/core/constant/l10n/l10x.dart';
void showVaccinationDetailsSheet(
  BuildContext context,
  VaccinationRecord record,
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => VaccinationDetailsSheet(record: record),
  );
}

class VaccinationDetailsSheet extends StatelessWidget {
  final VaccinationRecord record;

  const VaccinationDetailsSheet({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    final notes = record.notes;

    return _DetailsSheetContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Header(title: record.vaccineName, subtitle: context.l10n.vaccination),

          SizedBox(height: 20.h),

          _DetailLabel(
            label: context.l10n.vaccinationDate,
            value: DateFormat('MMM dd, yyyy', context.l10n.localeName).format(record.date),
          ),

          SizedBox(height: 12.h),

          _DetailLabel(label: context.l10n.dose, value: '${record.doseNumber}'),

          if (notes?.isNotEmpty == true) ...[
            SizedBox(height: 12.h),
            _DetailLabel(label: context.l10n.notes, value: notes!),
          ],

          SizedBox(height: 20.h),

          _CloseButton(onPressed: () => Navigator.pop(context)),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final String title;
  final String subtitle;

  const _Header({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 48.w,
          height: 48.w,
          decoration: BoxDecoration(
            color: context.colors.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: Icon(
            Icons.vaccines_outlined,
            color: context.colors.primary,
            size: 24.sp,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w800,
                  color: context.colors.onSurface,
                ),
              ),
              SizedBox(height: 3.h),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: context.colors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DetailsSheetContainer extends StatelessWidget {
  final Widget child;

  const _DetailsSheetContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
      decoration: BoxDecoration(
        color: context.colors.surfaceContainer,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: SafeArea(top: false, child: SingleChildScrollView(child: child)),
    );
  }
}

class _DetailLabel extends StatelessWidget {
  final String label;
  final String value;

  const _DetailLabel({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
            color: context.colors.onSurfaceVariant,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: context.colors.onSurface,
          ),
        ),
      ],
    );
  }
}

class _CloseButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _CloseButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: context.colors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: EdgeInsets.symmetric(vertical: 13.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Text(
          context.l10n.close,
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}