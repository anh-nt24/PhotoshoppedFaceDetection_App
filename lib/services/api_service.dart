import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';

class ApiService {

	Future<http.StreamedResponse?> analyzeImage(http.MultipartFile imageFile, BuildContext context) async {
		try {
			String url = '${Constants.baseUrl}/api/detect-regions/';

			var request = http.MultipartRequest('POST', Uri.parse(url));
			request.headers.addAll({
				"Content-Type": "multipart/form-data;"
			});
			
			request.files.add(imageFile);

			final response = await request.send();
			return response;
		} catch (e) {
			print('Internal error: ${e}');
			return null;
		}
	}
}
