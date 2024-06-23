import 'dart:io';
import 'package:flutter/foundation.dart';

class HoldingState extends ChangeNotifier {
	File? selectedImage; 
	File? resultImage;

	bool _showResult = false;
	bool get showResult => _showResult;

	void setSelectedImage(File newImage) {
		selectedImage = newImage;
		notifyListeners();
	}

	void setResultImage(File newImage) {
		resultImage = newImage;
		notifyListeners();
	}

	// toggle between showing selected image and result image
	void toggleShowResult(bool show) {
		_showResult = show;
		notifyListeners();
	}
}