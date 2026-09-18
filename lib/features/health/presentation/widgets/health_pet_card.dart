import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';
import 'package:pet_care/features/health/domain/entity/health_record.dart';
import 'package:pet_care/features/health/domain/enums/health_record_type.dart';
import 'package:pet_care/features/pets/domain/entity/pet.dart';

class HealthPetCard extends StatelessWidget {
  final Pet pet;
  final List<HealthRecord> records;
  final VoidCallback onTap;

  const HealthPetCard({super.key, required this.pet, required this.records, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final latest = records.isEmpty ? null : records.first;
    final meta = '${pet.breed} • ${_age(pet.birthDate)}';
    final status = latest == null ? 'No records yet' : '${_label(latest.type.name)}${latest.type == HealthRecordType.allergy ? ' due' : ''}';
    final statusColor = latest == null ? AppColors.textSecondary : _color(latest.type);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(color: const Color(0xFFF1F5F9)),
          boxShadow: const [BoxShadow(color: Color(0x0A0F172A), blurRadius: 8, offset: Offset(0, 2))],
        ),
        child: Row(
          children: [
            _Image(url: pet.photoUrl),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(pet.name, style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w700, color: AppColors.text)),
                SizedBox(height: 3.h),
                Text(meta, style: TextStyle(fontSize: 11.sp, color: AppColors.secondaryText)),
                SizedBox(height: 6.h),
                Row(children: [
                  Icon(Icons.description_outlined, size: 12.sp, color: statusColor),
                  SizedBox(width: 4.w),
                  Text(records.isEmpty ? status : '${records.length} records', style: TextStyle(fontSize: 10.sp, color: statusColor, fontWeight: FontWeight.w600)),
                  if (records.isNotEmpty) ...[
                    SizedBox(width: 8.w),
                    Container(padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 3.h), decoration: BoxDecoration(color: statusColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(999.r)), child: Text(status, style: TextStyle(fontSize: 9.sp, color: statusColor, fontWeight: FontWeight.w600))),
                  ],
                ]),
              ]),
            ),
            Icon(Icons.chevron_right, color: AppColors.secondaryText, size: 18.sp),
          ],
        ),
      ),
    );
  }

  String _label(String value) => value[0].toUpperCase() + value.substring(1);

  String _age(DateTime birthDate) {
    final now = DateTime.now();
    var years = now.year - birthDate.year;
    if (DateTime(now.year, birthDate.month, birthDate.day).isAfter(now)) years--;
    return years > 0 ? '$years years' : 'Less than a year';
  }

  Color _color(HealthRecordType type) => switch (type) {
        HealthRecordType.vaccination => const Color(0xFF0D9488),
        HealthRecordType.checkup => const Color(0xFF0284C7),
        HealthRecordType.medication => const Color(0xFFF97316),
        HealthRecordType.allergy => const Color(0xFFEF4444),
        HealthRecordType.surgery => const Color(0xFF8B5CF6),
        HealthRecordType.other => AppColors.textSecondary,
      };
}

class _Image extends StatelessWidget {
  final String url;
  const _Image({required this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 58.w,
      height: 58.w,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(14.r)),
      child: url.isEmpty ? const Icon(Icons.pets, color: AppColors.icon) : Image.network(url, fit: BoxFit.cover),
    );
  }
}
