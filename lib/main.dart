import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
				title: 'PurePixel', // app name
				theme: ThemeData(
					useMaterial3: true,
					colorScheme: ColorScheme.fromSeed(seedColor: Color.fromRGBO(221, 102, 99, 1.0)), // rgb(221,102,99)
				),
				home: MyHomePage(),
			),
		);
	}
}

class MyAppState extends ChangeNotifier {
}

class MyHomePage extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		

		return Scaffold(
			body: Center(
				child: Column(
					mainAxisAlignment: MainAxisAlignment.center,
					children: [
						Text("Hello world"),
					],
				),
			),
		);
	}
}