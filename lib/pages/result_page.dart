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
		ValueNotifier<bool> showResult = ValueNotifier<bool>(true);

		return Scaffold(
			body: Center(
				child: Column(
					mainAxisAlignment: MainAxisAlignment.center,
					children: [
						SizedBox(height: 80),
		
						// TASK BAR
						ProgressStepBar(fromRight: true,),

						SizedBox(height: 50), // Space between progress bar and title
						
						// HEADING
						SizedBox(
							height: 90,
							child: Padding(
								padding: const EdgeInsets.symmetric(horizontal: 20.0),
								child: Text(
									'Edited Regions Detected!',
									style: TextStyle(
										fontSize: 27,
										fontWeight: FontWeight.bold,
									),
								),
							),
						),

						
						SizedBox(height: 8), // Space between title and subtitle
					
						// SUB HEADING
						SizedBox(
							height: 45,
							child: Padding(
								padding: const EdgeInsets.symmetric(horizontal: 20.0), // Add padding to both sides
								child: Text(
									'We identified areas that might have been edited in your photo. Review the highlighted regions for more details.',
									style: TextStyle(fontSize: 15),
									textAlign: TextAlign.start,
								),
							),
						),

					
					
						SizedBox(height: 25),

					
						// DISPLAY RESULT
						if (resultState.result != null) 
							Expanded(
								child: Align(
									alignment: Alignment.center,
									child: Column(children: [
										Image.asset(
											
											'assets/colormapbar.jpg',
											width: 320,
											height: 30,
											fit: BoxFit.cover,
										),

										SizedBox(height: 5),

										GestureDetector(
											onTapDown: (_) {
												// when user presses down, show original image
												showResult.value = false;
											},
											onTapUp: (_) {
												// when user releases, show result image
												showResult.value = true;
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
												
												// result box
												child: ValueListenableBuilder<bool>(
													valueListenable: showResult,
													builder: (context, value, child) {
														return value ? 
															ClipRRect(
																borderRadius: BorderRadius.circular(5.0),
																child: Image.file(resultState.result!, fit: BoxFit.cover)
															) :
															ClipRRect(
																borderRadius: BorderRadius.circular(5.0),
																child: Image.file(imageState.selectedImage!, fit: BoxFit.cover)
															);															
													},
												),
											),
										),

										SizedBox(height: 5,),

										Padding(
											padding: const EdgeInsets.symmetric(horizontal: 20.0), // Add padding to both sides
											child: ValueListenableBuilder<bool>(
												valueListenable: showResult,
												builder: (context, value, child) {
													return Text(
														value == true ?
														'*Hold the image to show the input image' :
														'*Release to show the result image',
														style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
														textAlign: TextAlign.center,
													);										
												},
											),											
										),
									],)
								),
							),

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
								style: ElevatedButton.styleFrom(
									backgroundColor: Color.fromRGBO(221, 102, 99, 1.0),
									foregroundColor: Colors.white,
								),
								child: Text('Done', style: TextStyle(fontSize: 18)),
							),
						),

						SizedBox(height: 20),
					],
				),
			),
		);
	}
}
