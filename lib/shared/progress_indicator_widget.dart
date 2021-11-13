import 'package:flutter/material.dart';

class CustomProgressIndicatorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 100,
        constraints: BoxConstraints.expand(),
        child: FittedBox(
          fit: BoxFit.none,
          child: SizedBox(
            height: 100,
            width: 100,
            child: Card(
              child: const Padding(
                padding: EdgeInsets.all(25.0),
                child: CircularProgressIndicator(),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
            ),
          ),
        ),
        decoration: const BoxDecoration(color: Colors.white),
      ),
    );
  }
}