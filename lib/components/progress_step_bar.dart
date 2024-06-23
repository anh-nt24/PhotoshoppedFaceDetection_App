import 'package:flutter/material.dart';

class ProgressStepBar extends StatelessWidget {
	final double value;
	final bool fromRight;
	final double height;
	final double width;
	final Color backgroundColor;
	final Color progressColor;

	const ProgressStepBar({
		Key? key,
		this.value = 0.6,
		this.fromRight = false,
		this.height = 6.0,
		this.width = 150.0,
		this.backgroundColor = Colors.grey,
		this.progressColor = const Color.fromRGBO(221, 102, 99, 1.0),
	}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		final Matrix4 transform = fromRight ? 
			(Matrix4.identity()..scale(-1.0, 1.0)) :
        	Matrix4.identity();

		return Container(
			height: height,
			width: width,
			decoration: BoxDecoration(
				color: backgroundColor,
				borderRadius: BorderRadius.circular(4),
			),
			child: ClipRRect(
				borderRadius: BorderRadius.circular(4),
				child: Transform(
					alignment: Alignment.center,
					transform: transform,
					child: LinearProgressIndicator(
						value: value,
						backgroundColor: Colors.transparent,
						valueColor: AlwaysStoppedAnimation<Color>(progressColor),
						semanticsLabel: 'Progress indicator',
						semanticsValue: '${(value * 100).toInt()}%',
						borderRadius: BorderRadius.circular(4),
					),
				),
			),
		);
	}
}