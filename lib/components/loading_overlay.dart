import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingOverlay extends StatelessWidget {
	final bool isLoading;
	final Widget child;

	const LoadingOverlay({
		Key? key,
		required this.isLoading,
		required this.child,
	}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return Stack(
			children: [
				child,
				if (isLoading)
					Container(
						color: Colors.black.withOpacity(0.4),
						child: Center(
							child: LoadingAnimationWidget.flickr(
								leftDotColor: Color.fromRGBO(221, 102, 99, 1.0), 
								rightDotColor: Color.fromRGBO(252, 242, 237, 1.0), 
								size: 50
							),
						),
					),
			],
		);
	}
}
