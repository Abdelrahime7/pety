import 'package:pet_care/core/constant/theme/context_x.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhotoPicker extends StatelessWidget {
  final Function(File)? onImageSelected;
  final File? imageFile;

  PhotoPicker({super.key, this.onImageSelected, this.imageFile});

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final XFile? file = await _picker.pickImage(source: ImageSource.gallery);

    if (file != null && onImageSelected != null) {
      onImageSelected!(File(file.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: pickImage,
      child: Stack(
        children: [
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              color: context.colors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: context.colors.outlineVariant,
                width: 1.2,
              ),
            ),

            // ⭐ SHOW IMAGE IF AVAILABLE
            child: imageFile == null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.camera_alt_outlined,
                        color: context.colors.onSurfaceVariant,
                        size: 30,
                      ),
                      SizedBox(height: 6),
                      Text(
                        'UPLOAD PHOTO',
                        style: TextStyle(
                          color: context.colors.onSurfaceVariant,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.file(imageFile!, fit: BoxFit.cover),
                  ),
          ),

          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: context.colors.primary,
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
