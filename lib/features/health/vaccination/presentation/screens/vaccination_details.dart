import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:pet_care/core/constant/theme/app_colors.dart';
import 'package:pet_care/core/constant/theme/app_style.dart';
import 'package:pet_care/features/health/vaccination/domain/entities/vaccination_serie.dart';

class VaccinationDetailsScreen extends StatelessWidget {
  final VaccinationSerie vaccination;

  const VaccinationDetailsScreen({
    super.key,
    required this.vaccination,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd MMM yyyy');

    final createdDate = dateFormat.format(vaccination.createdAt);

    final isCompleted =
        vaccination.completedDoses >= vaccination.requiredDoses;

    final status = isCompleted ? 'Completed' : 'In progress';

    final progress =
        '${vaccination.completedDoses} / ${vaccination.requiredDoses} doses';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(
          'Vaccination Details',
          style: AppStyle.tileTitle,
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _VaccinationHeader(
              vaccineName: vaccination.vaccineName,
              status: status,
              isCompleted: isCompleted,
            ),

            const SizedBox(height: 24),

            const _SectionTitle(
              title: 'Vaccination',
            ),

            const SizedBox(height: 12),

            _InfoCard(
              children: [
                _InfoRow(
                  icon: Icons.vaccines_rounded,
                  label: 'Vaccine',
                  value: vaccination.vaccineName,
                ),

                const _InfoDivider(),

                _InfoRow(
                  icon: Icons.layers_rounded,
                  label: 'Dose progress',
                  value: progress,
                  valueColor: AppColors.primary,
                ),

                const _InfoDivider(),

                _InfoRow(
                  icon: Icons.numbers_rounded,
                  label: 'Required doses',
                  value: vaccination.requiredDoses.toString(),
                ),

                const _InfoDivider(),

                _InfoRow(
                  icon: Icons.check_circle_outline_rounded,
                  label: 'Status',
                  value: status,
                  valueColor: isCompleted
                      ? AppColors.primary
                      : AppColors.primary,
                ),

                const _InfoDivider(),

                _InfoRow(
                  icon: Icons.calendar_today_rounded,
                  label: 'Created',
                  value: createdDate,
                ),
              ],
            ),

            if (vaccination.description != null &&
                vaccination.description!.trim().isNotEmpty) ...[
              const SizedBox(height: 24),

              const _SectionTitle(
                title: 'Description',
              ),

              const SizedBox(height: 12),

              _NotesCard(
                notes: vaccination.description!,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _VaccinationHeader extends StatelessWidget {
  final String vaccineName;
  final String status;
  final bool isCompleted;

  const _VaccinationHeader({
    required this.vaccineName,
    required this.status,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(
              Icons.vaccines_rounded,
              color: AppColors.primary,
              size: 30,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  vaccineName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyle.tileTitle.copyWith(
                    fontSize: 18,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  status,
                  style: AppStyle.regular10.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppStyle.tileTitle.copyWith(
        fontSize: 16,
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final List<Widget> children;

  const _InfoCard({
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: children,
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              size: 19,
              color: AppColors.primary,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppStyle.regular10,
                ),

                const SizedBox(height: 4),

                Text(
                  value,
                  style: AppStyle.tileTitle.copyWith(
                    fontSize: 14,
                    color: valueColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoDivider extends StatelessWidget {
  const _InfoDivider();

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      color: Colors.black.withValues(alpha: 0.06),
    );
  }
}

class _NotesCard extends StatelessWidget {
  final String notes;

  const _NotesCard({
    required this.notes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        notes,
        style: AppStyle.regular10,
      ),
    );
  }
}

