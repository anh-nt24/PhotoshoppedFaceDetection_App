import 'dart:io';
import 'package:flutter/material.dart';
import '../services/image_picker_service.dart';

class ImageState extends ChangeNotifier {
	final ImagePickerService _imagePickerService = ImagePickerService();
	File? _selectedImage;

	File? get selectedImage => _selectedImage;

	Future<void> pickImage() async {
		_selectedImage = await _imagePickerService.pickImage();
		notifyListeners();
	}

	void resetState() {
		_selectedImage = null; // Reset selected image
		notifyListeners();
    }
}
