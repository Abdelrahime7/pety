import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PetPhotoPicker extends StatelessWidget {
  final Function(File)? onImageSelected;
  final File? imageFile;

   PetPhotoPicker({
    super.key,
    this.onImageSelected,
    this.imageFile,
  });

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
              color: const Color(0xFFF3F7FA),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFCFD9E0), width: 1.2),
            ),

            // ⭐ SHOW IMAGE IF AVAILABLE
            child: imageFile == null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.camera_alt_outlined,
                          color: Color(0xFF8C9BA8), size: 30),
                      SizedBox(height: 6),
                      Text(
                        'UPLOAD PHOTO',
                        style: TextStyle(
                          color: Color(0xFF8C9BA8),
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.file(
                      imageFile!,
                      fit: BoxFit.cover,
                    ),
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
