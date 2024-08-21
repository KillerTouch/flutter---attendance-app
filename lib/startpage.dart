import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Image.asset(
              "images/uni.png",
              scale: 4,
              height: 500,
            ),
          ),
          const Text(
            "برنامه ی حضور و غیاب",
            textScaleFactor: 2,
            style: TextStyle(fontFamily: 'chamran', height: -5),
          )
        ],
      ),
    );
  }
}
