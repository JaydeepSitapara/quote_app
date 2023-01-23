import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_detector/flutter_swipe_detector.dart';

class SecondPage extends StatelessWidget {
  SecondPage({Key? key}) : super(key: key);

  final minVelocity = 1.0;
  //final scale = 1.0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('two finger swipe demo'),
          centerTitle: true,
        ),
        body: Container(
          child: GestureDetector(
            onScaleEnd: (ScaleEndDetails details) {
              if (details.velocity.pixelsPerSecond.distance > minVelocity) {
                print("Two finger swipe detected!");
              }
            },
          ),
        )
      ),
    );
  }
}
