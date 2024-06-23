import 'package:flutter/material.dart';
import 'package:photoshoppedfacedetection_app/components/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import '../states/image_state.dart';
import '../states/result_state.dart';
import 'result_page.dart';
import '../components/progress_step_bar.dart';

class MyHomePage extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		final imageState = Provider.of<ImageState>(context);
		final resultState = Provider.of<ResultState>(context);

		return LoadingOverlay(
			isLoading: resultState.isLoading, 
			child: Scaffold(
				body: Center(
					child: Column(
						mainAxisAlignment: MainAxisAlignment.center,
						children: [
							SizedBox(height: 80),
							
							// TASK BAR
							ProgressStepBar(),

							SizedBox(height: 50),

							// HEADING
							Padding(
								padding: const EdgeInsets.symmetric(horizontal: 20.0),
								child: Text(
									'Upload an image to detect edited regions',
									style: TextStyle(
										fontSize: 30,
										fontWeight: FontWeight.bold,
									),
								),
							),

							SizedBox(height: 8),

							// SUB HEADING
							Padding(
								padding: const EdgeInsets.symmetric(horizontal: 20.0),
								child: Text(
									'Regulations require you to upload a facial photo. '
									'Don\'t worry, your data will be safe and private.',
									style: TextStyle(fontSize: 20),
								),
							),

							SizedBox(height: 20),

							Expanded(
								child: Align(
									alignment: Alignment.center,
									child: GestureDetector(
										onTap: () async {
											await imageState.pickImage();
										},
										child: Container(
											// border box
											width: 320,
											height: 320,
											decoration: BoxDecoration(
												border: Border.all(
													color: Color.fromRGBO(221, 102, 99, 1.0),
													width: 3,
												),
												borderRadius: BorderRadius.circular(8),
											),
											
											// picking icon
											child: imageState.selectedImage == null ?
												Icon(
													Icons.upload_file,
													size: 50,
													color: Color.fromRGBO(221, 102, 99, 1.0),
												)
												: 
												Image.file(imageState.selectedImage!, fit: BoxFit.cover, ),
										),
									),
								),
							),

							SizedBox(height: 20),

							// UPLOAD BUTTON
							Container(
								width: 320,
								height: 50,
								child: ElevatedButton(
									onPressed: imageState.selectedImage == null || resultState.isLoading ?
										null  // cannot press
										:
										() async {
											var result = await resultState.analyzeImage(
												imageState.selectedImage, context
											);
											print(result);
											if (result != null) {
												Navigator.push(
													context,
													MaterialPageRoute(builder: (context) => ResultPage()),
												);
											} else {
												// reset all state
												await Future.delayed(Duration(seconds: 3));
												resultState.resetState();
												imageState.resetState();
											}
										},
									style: ElevatedButton.styleFrom(
										backgroundColor: imageState.selectedImage == null ?
											Theme.of(context).colorScheme.primary :
											Color.fromRGBO(221, 102, 99, 1.0),
										foregroundColor: imageState.selectedImage == null ?
											Colors.black :
											Colors.white,
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
			)
		);
		
		
	}
}