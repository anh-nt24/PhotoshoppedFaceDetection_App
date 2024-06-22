import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

void main() {
	runApp(MyApp());
}

class MyApp extends StatelessWidget {
	const MyApp({super.key});

	@override
	Widget build(BuildContext context) {
		return ChangeNotifierProvider(
			create: (context) => MyAppState(),
			child: MaterialApp(
				debugShowCheckedModeBanner: false,
				title: 'PurePixel', // Tên ứng dụng
				theme: ThemeData(
					useMaterial3: true,
					colorScheme: ColorScheme.fromSeed(
							seedColor: Color.fromRGBO(221, 102, 99, 1.0)), // rgb(221,102,99)
				),
				home: MyHomePage(),
			),
		);
	}
}

class MyAppState extends ChangeNotifier {
	File? _selectedImage;
	String? _result;
	bool _isLoading = false;

	File? get selectedImage => _selectedImage;
	String? get result => _result;
	bool get isLoading => _isLoading;

	Future<void> pickImage() async {
		final picker = ImagePicker();
		final pickedFile =
		await picker.pickImage(source: ImageSource.gallery);

		if (pickedFile != null) {
			_selectedImage = File(pickedFile.path);
			notifyListeners();
		}
	}

	Future<void> analyzeImage(BuildContext context) async {
		if (_selectedImage == null) return;

		_isLoading = true;
		notifyListeners();

		final request = http.MultipartRequest(
			'POST',
			Uri.parse('YOUR_API_URL'),
		);
		request.files.add(
			await http.MultipartFile.fromPath('file', _selectedImage!.path),
		);

		final response = await request.send();

		if (response.statusCode == 200) {
			final responseBody = await response.stream.bytesToString();
			_result = responseBody; // Cập nhật dòng này dựa trên cấu trúc phản hồi từ API
		} else {
			_result = 'Error: ${response.statusCode}';
		}

		_isLoading = false;
		notifyListeners();

		Navigator.push(
			context,
			MaterialPageRoute(builder: (context) => ResultPage()),
		);
	}
}

class ResultPage  extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		final appState = Provider.of<MyAppState>(context);

		return Scaffold(
			body: Center(
				child: Column(
					mainAxisAlignment: MainAxisAlignment.center,
					children: [
						SizedBox(height: 80),
						Container(
							height: 6,
							width: 150,
							decoration: BoxDecoration(
								color: Colors.grey[300],
								borderRadius: BorderRadius.circular(4),
							),
							child: ClipRRect(
								borderRadius: BorderRadius.circular(4),
								child: LinearProgressIndicator(
									value: 0.65,
									backgroundColor: Colors.transparent,
									valueColor: AlwaysStoppedAnimation<Color>(Color.fromRGBO(221, 102, 99, 1.0)),
									semanticsLabel: 'Progress indicator',
									semanticsValue: '65%',
									borderRadius: BorderRadius.circular(4),
								),
							),
						),
						SizedBox(height: 50),
						Padding(
							padding: const EdgeInsets.symmetric(horizontal: 20.0),
							child: Text(
								'Upload an image to detect edited regions',
								style: TextStyle(
									fontSize: 40,
									fontWeight: FontWeight.bold,
								),
							),
						),
						SizedBox(height: 8),
						Padding(
							padding: const EdgeInsets.symmetric(horizontal: 20.0),
							child: Text(
								'Regulations require you to upload a face photo. Don\'t worry, your data will be safe and private.',
								style: TextStyle(fontSize: 20),
							),
						),
						SizedBox(height: 20),
						Expanded(
							child: Align(
								alignment: Alignment.center,
								child: GestureDetector(
									onTap: appState.pickImage,
									child: Container(
										width: 320,
										height: 320,
										decoration: BoxDecoration(
											border: Border.all(
												color: Color.fromRGBO(221, 102, 99, 1.0),
												width: 3,
											),
											borderRadius: BorderRadius.circular(8),
										),
										child: appState.selectedImage == null
												? Icon(
											Icons.upload_file,
											size: 50,
											color: Color.fromRGBO(221, 102, 99, 1.0),
										)
												: Image.file(
											appState.selectedImage!,
											fit: BoxFit.cover,
										),
									),
								),
							),
						),
						SizedBox(height: 20),
						Container(
							width: 320,
							height: 50,
							child: ElevatedButton(
								onPressed: appState.selectedImage == null || appState.isLoading
										? null
										: () {
									appState.analyzeImage(context);
								},
								style: ElevatedButton.styleFrom(
									backgroundColor: appState.selectedImage == null
											? Theme.of(context).colorScheme.primary
											: Color.fromRGBO(221, 102, 99, 1.0),
									foregroundColor: appState.selectedImage == null
											? Colors.black
											: Colors.white,
								),
								child: Text(
									'Continue',
									style: TextStyle(fontSize: 18),
								),
							),
						),
						SizedBox(height: 20),
					],
				),
			),
		);
	}
}

class MyHomePage extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		final appState = Provider.of<MyAppState>(context);

		return Scaffold(
			body: Center(
				child: Column(
					mainAxisAlignment: MainAxisAlignment.center,
					children: [
						SizedBox(height: 50), // Space from top
						Container(
							height: 4,
							width: 200,
							decoration: BoxDecoration(
								color: Colors.grey[300],
								borderRadius: BorderRadius.circular(4),
							),
							child: ClipRRect(
								borderRadius: BorderRadius.circular(4),
								child: LinearProgressIndicator(
									value: 1.0, // Full progress for the result page
									backgroundColor: Colors.transparent,
									valueColor: AlwaysStoppedAnimation<Color>(Color.fromRGBO(221, 102, 99, 1.0)),
								),
							),
						),
						SizedBox(height: 50), // Space between progress bar and title
						Padding(
							padding: const EdgeInsets.symmetric(horizontal: 20.0), // Add padding to both sides
							child: Text(
								'Edited Regions Detected!',
								style: TextStyle(
									fontSize: 30,
									fontWeight: FontWeight.bold,
								),
								textAlign: TextAlign.center,
							),
						),
						SizedBox(height: 8), // Space between title and subtitle
						Padding(
							padding: const EdgeInsets.symmetric(horizontal: 20.0), // Add padding to both sides
							child: Text(
								'We identified areas that might have been edited in your photo. Review the highlighted regions for more details.',
								style: TextStyle(fontSize: 16),
								textAlign: TextAlign.center,
							),
						),
						SizedBox(height: 20),
						if (appState.selectedImage != null)
							Container(
								width: 320,
								height: 320,
								decoration: BoxDecoration(
									border: Border.all(
										color: Color.fromRGBO(221, 102, 99, 1.0),
										width: 4, // Adjust this value for thicker border
									),
									borderRadius: BorderRadius.circular(8),
								),
								child: Image.file(appState.selectedImage!, fit: BoxFit.cover),
							),
						if (appState.result != null)
							Padding(
								padding: const EdgeInsets.all(8.0),
								child: Text(appState.result!),
							),
						SizedBox(height: 20),
						Container(
							width: 320, // Đảm bảo nút mở rộng theo chiều ngang của màn hình
							height: 50, // Chiều cao của nút
							child: ElevatedButton(
								onPressed: () {
									Navigator.pop(context);
								},
								child: Text('Done', style: TextStyle(fontSize: 18)),
							),
						),
					],
				),
			),
		);
	}
}
