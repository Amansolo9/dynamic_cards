import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../dominant_color_util.dart';

class ImageCardData {
  final File file;
  final Color dominantColor;
  ImageCardData({required this.file, required this.dominantColor});
}

class ImagePickerViewModel extends ChangeNotifier {
  final List<ImageCardData> _images = [];
  final ImagePicker _picker = ImagePicker();

  List<ImageCardData> get images => List.unmodifiable(_images);

  Future<void> pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final color = await getDominantColor(file);
      _images.add(ImageCardData(file: file, dominantColor: color));
      notifyListeners();
    }
  }

  Future<void> refreshImages() async {
    notifyListeners();
  }
} 