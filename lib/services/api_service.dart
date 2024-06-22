import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiService {
  	static const String baseUrl = 'http://192.168.1.8:8000/api';

	Future<http.StreamedResponse?> analyzeImage(http.MultipartFile imageFile, BuildContext context) async {
		try {
			String url = '${baseUrl}/detect-regions/';

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
