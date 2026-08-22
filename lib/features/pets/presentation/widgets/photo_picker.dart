import 'package:flutter/material.dart';

class PetPhotoPicker extends StatelessWidget {
  final VoidCallback? onTap;

  const PetPhotoPicker({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              color: const Color(0xFFF3F7FA),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFCFD9E0), width: 1.2),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.camera_alt_outlined, color: Color(0xFF8C9BA8), size: 30),
                SizedBox(height: 6),
                Text(
                  'UPLOAD PHOTO',
                  style: TextStyle(color: Color(0xFF8C9BA8), fontSize: 9, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: Color(0xFF20C997),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add, color: Colors.white, size: 18),
            ),
          ),
        ],
      ),
    );
  }
}