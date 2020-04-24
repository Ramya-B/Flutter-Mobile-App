import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[700],
      body: Center(
          child: Container(
              padding: EdgeInsets.all(10),
              width: 180,
              height: 180,
              child: Image.asset("assets/tl.png", fit: BoxFit.cover),
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.white))),
    );
  }
}
