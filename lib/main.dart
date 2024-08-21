import 'package:attendance/lists.dart';
import 'package:attendance/startpage.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'AboutMe.dart';
import 'package:attendance/calculator.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();

  await Hive.openBox('mybox');
  await Hive.openBox('mybox2');

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List bpages = [Homepage(), Lists()];
  int selectedIndex = 0;
  void ontap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  // Name of the new item to be added

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255)),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Attendance"),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 22, 37, 50),
          toolbarHeight: 65,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          color: const Color.fromARGB(255, 255, 255, 255),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 5),
            child: GNav(
              selectedIndex: selectedIndex,
              iconSize: 30,
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              color: const Color.fromARGB(255, 0, 0, 0),
              activeColor: Colors.white,
              tabBackgroundColor: const Color.fromARGB(255, 1, 1, 1),
              gap: 40,
              onTabChange: ontap,
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: "Home",
                ),
                GButton(
                  icon: Icons.checklist_rounded,
                  text: "List",
                )
              ],
            ),
          ),
        ),
        body: bpages[selectedIndex],
        drawer: const NavigationDrawer(),
      ),
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildHeader(context),
            buildMenuItems(context),
          ],
        )),
      );
  Widget buildHeader(BuildContext context) => Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      );
  Widget buildMenuItems(BuildContext context) => Container(
        padding: const EdgeInsets.all(24),
        child: Wrap(
          children: [
            ListTile(
                leading: const Icon(Icons.home),
                title: const Text("Home"),
                onTap: () => Navigator.of(context).pushReplacement(
                      MaterialPageRoute<Widget>(
                        builder: (BuildContext context) => const MyApp(),
                      ),
                    )),
            const Divider(
              color: Colors.black,
              thickness: 0,
            ),
            ListTile(
                leading: const Icon(Icons.calculate_rounded),
                title: const Text("Calculator"),
                onTap: () => Navigator.of(context).pushReplacement(
                      MaterialPageRoute<Widget>(
                        builder: (BuildContext context) => Calculator(),
                      ),
                    )),
            const Divider(
              color: Colors.black,
              thickness: 0,
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text("About me"),
              onTap: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute<Widget>(
                  builder: (BuildContext context) => const About(),
                ),
              ),
            ),
          ],
        ),
      );
}
