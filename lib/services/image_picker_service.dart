import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
	Future<File?> pickImage() async {
		final picker = ImagePicker();
		final pickedFile = await picker.pickImage(source: ImageSource.gallery);

		if (pickedFile != null) {
			return File(pickedFile.path);
		} else {
			return null;
		}
	}
}