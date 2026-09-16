import 'package:flutter/material.dart';
import 'package:pet_care/core/constant/theme/app_colors.dart';

/// Horizontal row of selectable day chips (MON 20, TUE 21, ...).
class WeekDaySelector extends StatelessWidget {
  final List<DateTime> days;
  final DateTime? selectedDay;
  final ValueChanged<DateTime> onDaySelected;

  const WeekDaySelector({
    super.key,
    required this.days,
    required this.selectedDay,
    required this.onDaySelected,
  });

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: days
            .map((day) => _DayChip(
                  day: day,
                  isSelected: selectedDay != null && _isSameDay(day, selectedDay!),
                  onTap: () => onDaySelected(day),
                ))
            .toList(),
      ),
    );
  }
}

class _DayChip extends StatelessWidget {
  final DateTime day;
  final bool isSelected;
  final VoidCallback onTap;

  const _DayChip({
    required this.day,
    required this.isSelected,
    required this.onTap,
  });

  static const _weekdayLabels = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];

  @override
  Widget build(BuildContext context) {
    
    final accentColor = AppColors.primary; // Use your app's accent color here  

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: isSelected ? Border.all(color: accentColor, width: 1.5) : null,
        ),
        child: Column(
          children: [
            Text(
              _weekdayLabels[day.weekday - 1],
              style: TextStyle(
                fontSize: 11,
                color: isSelected ? accentColor : Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              '${day.day}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isSelected ? accentColor : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}