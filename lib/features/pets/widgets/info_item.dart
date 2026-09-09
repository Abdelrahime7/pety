
import 'package:flutter/material.dart';
import 'package:pet_care/core/constant/theme/app_style.dart';

class InfoItem extends StatelessWidget {
  final String label;
  final String value;

  const InfoItem({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppStyle.regular13,
          ),

          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: AppStyle.tileTitle,
            ),
          ),
        ],
      ),
    );
  }
}
