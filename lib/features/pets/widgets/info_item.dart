import 'package:pet_care/core/constant/theme/context_x.dart';
import 'package:flutter/material.dart';

class InfoItem extends StatelessWidget {
  final String label;
  final String value;

  const InfoItem({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: context.style.regular13),

          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: context.style.tileTitle,
            ),
          ),
        ],
      ),
    );
  }
}