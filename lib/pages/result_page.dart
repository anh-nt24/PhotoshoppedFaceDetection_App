import 'package:flutter/material.dart';
import '../components/progress_step_bar.dart';
import 'package:provider/provider.dart';
import '../states/result_state.dart';
import '../states/image_state.dart';

class ResultPage extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		final resultState = Provider.of<ResultState>(context);
		final imageState = Provider.of<ImageState>(context);

		bool showResult = true;

		return Scaffold(
			body: Padding(
				padding: const EdgeInsets.all(16.0),
				child: Column(
					mainAxisAlignment: MainAxisAlignment.center,
					children: [
						SizedBox(height: 50), // Space from top
						
						// TASK BAR
						ProgressStepBar(fromRight: true,),

						SizedBox(height: 50), // Space between progress bar and title
						
						// HEADING
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
					
						// SUB HEADING
						Padding(
							padding: const EdgeInsets.symmetric(horizontal: 20.0), // Add padding to both sides
							child: Text(
								'We identified areas that might have been edited in your photo. Review the highlighted regions for more details.',
								style: TextStyle(fontSize: 16),
								textAlign: TextAlign.center,
							),
						),
					
					
						SizedBox(height: 20),
					
						// DISPLAY RESULT
						if (resultState.result != null)
							Expanded(
								child: Align(
									alignment: Alignment.center,
									child: GestureDetector(
										onTapDown: (_) {
											// when user presses down, show original image
											showResult = false;
											imageState.notifyListeners();
										},
										onTapUp: (_) {
											// When user releases, show result image
											showResult = true;
											resultState.notifyListeners();
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
											child: showResult == true ?
												Image.file(resultState.result!, fit: BoxFit.cover)
												: 
												Image.file(imageState.selectedImage!, fit: BoxFit.cover, ),
										),
									),
								),
							),

							Padding(
								padding: const EdgeInsets.symmetric(horizontal: 20.0), // Add padding to both sides
								child: Text(
									showResult == true ?
									'*Hold on the image to show the input image' :
									'*Release to show the result image',
									style: TextStyle(fontSize: 10, fontStyle: FontStyle.italic),
									textAlign: TextAlign.center,
								),
							),
							// Container(
							// 	width: 320,
							// 	height: 320,
							// 	decoration: BoxDecoration(
							// 		border: Border.all(
							// 			color: Color.fromRGBO(221, 102, 99, 1.0),
							// 			width: 4, // Adjust this value for thicker border
							// 		),
							// 		borderRadius: BorderRadius.circular(8),
							// 	),
								
							// 	child: Image.file(resultState.result!, fit: BoxFit.cover),
							// ),
						// if (resultState.result != null)


						
						SizedBox(height: 20),
						
						Container(
							width: 320, // Ensure button expands horizontally to match screen width
							height: 50, // Button height
							child: ElevatedButton(
								onPressed: () {
									resultState.resetState();
									imageState.resetState();
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
