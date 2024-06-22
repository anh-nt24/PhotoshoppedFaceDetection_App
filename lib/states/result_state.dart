import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:motion_toast/motion_toast.dart';
import '../services/api_service.dart';

class ResultState extends ChangeNotifier {
	final ApiService _apiService = ApiService();
	File? _result;
	http.StreamedResponse? _response;
	bool _isLoading = false;

	bool get isLoading => _isLoading;
	File? get result => _result;

	void _setLoading(bool value) {
		_isLoading = value;
		notifyListeners();
	}

	void resetState() {
		_response = null;
		_result = null;
		notifyListeners();
    }

	Future<File?> analyzeImage(File? imageFile, BuildContext context) async {
		if (imageFile == null) return null;

		_setLoading(true);
		
		var multipart = await http.MultipartFile.fromPath('image', imageFile.path);
		_response = await _apiService.analyzeImage(multipart, context);
		var file = handleResult(context);

		_setLoading(false);
		notifyListeners();

		return file;
	}

	Future<File?> handleResult(BuildContext context) async {
		if (_response != null) {
			var status = _response!.statusCode;			
			if (status == 200) {
				Uint8List imageBytes = await _response!.stream.toBytes();
				final tempDir = await getTemporaryDirectory();
				final file = File('${tempDir.path}/result.png');
				await file.writeAsBytes(imageBytes);
				_result = file;
				return file;
			} else if (status == 400) {
				var data = await _response!.stream.bytesToString();
				MotionToast(
					icon: Icons.warning_amber_outlined,
					primaryColor:  Colors.amber[200]!,
					secondaryColor: Colors.amber,
					description:  Text(jsonDecode(data)['error']),
					position:  MotionToastPosition.center,
					animationType:  AnimationType.fromRight,
				).show(context);
			} else {
				// handle other status codes as needed
				MotionToast(
					icon: Icons.warning_amber_outlined,
					primaryColor:  Colors.amber[200]!,
					secondaryColor: Colors.amber,
					description:  Text("Unexpected error occured"),
					position:  MotionToastPosition.center,
					animationType:  AnimationType.fromRight,
				).show(context);
			}
		} else {
			// handle scenario where response is null (could not connect to server, etc.)
			MotionToast.error(
				description:  Text("Fail to connect to server")
			).show(context);
		}
		return null;
  	}
}
