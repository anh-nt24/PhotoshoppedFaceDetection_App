import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/homepage.dart';
import 'states/image_state.dart';
import 'states/result_state.dart';

void main() async {
	await Future.delayed(Duration(milliseconds: 500));
  	runApp(MyApp());
}

class MyApp extends StatelessWidget {
	const MyApp({super.key});

	@override
	Widget build(BuildContext context) {
		return MultiProvider(
			providers: [
				ChangeNotifierProvider(create: (_) => ImageState()),
				ChangeNotifierProvider(create: (_) => ResultState()),
			],
			child: MaterialApp(
				debugShowCheckedModeBanner: false,
				title: 'PurePixel',
				theme: ThemeData(
					useMaterial3: true,
					colorScheme: ColorScheme.fromSeed(
						seedColor: Color.fromRGBO(221, 102, 99, 1.0),
					),
				),
				home: MyHomePage(),
			),
		);
	}
}
