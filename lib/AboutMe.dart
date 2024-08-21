import 'package:flutter/material.dart';
import 'main.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: const Text("About Me"),
            centerTitle: true,
            backgroundColor: const Color.fromARGB(255, 22, 37, 50),
            toolbarHeight: 65,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
          ),
          drawer: const NavigationDrawer(),
          body: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    "images/me.png",
                    scale: 2,
                    alignment: Alignment.topCenter,
                  ),
                ),
                const SizedBox(height: 10),
                const SizedBox(
                  height: 90,
                  width: 410,
                  child: Center(
                    child: Text("Project Created by: \n \n Shayan Rabiei",
                        style: TextStyle(fontFamily: 'english', fontSize: 28),
                        textAlign: TextAlign.center),
                  ),
                ),
                const SizedBox(height: 20),
                const SizedBox(
                  height: 100,
                  width: 410,
                  child: Text(
                    "Supervisor: \n professor Mohammadreza majma",
                    style: TextStyle(fontFamily: 'english', fontSize: 22),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 0),
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Image.asset(
                    "images/uni.png",
                    scale: 8,
                    alignment: Alignment.topCenter,
                  ),
                ),
                const SizedBox(height: 1),
                const SizedBox(
                  height: 100,
                  width: 410,
                  child: Text(
                    "َI.A.U Pardis branch",
                    style: TextStyle(fontFamily: 'english', fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          )),
    );
  }
}
