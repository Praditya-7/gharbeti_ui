import 'package:flutter/material.dart';

class CustomProgressIndicatorWidget extends StatelessWidget {
  const CustomProgressIndicatorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 100,
        constraints: const BoxConstraints.expand(),
        child: const FittedBox(
          fit: BoxFit.none,
          child: SizedBox(
            height: 100,
            width: 100,
            child: Padding(
              padding: EdgeInsets.all(25.0),
              child: CircularProgressIndicator(),
            ),
          ),
        ),
        decoration: const BoxDecoration(color: Colors.white),
      ),
    );
  }
}
