import 'package:attendance/data/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:attendance/insideList.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Lists extends StatefulWidget {
  const Lists({super.key});

  @override
  State<Lists> createState() => _ListsState();
}

class _ListsState extends State<Lists> {
  final _myBox = Hive.box('mybox');

  ListDataBase db = ListDataBase();

  late TextEditingController _textController;
  @override
  void initState() {
    if (_myBox.get("NAMES") == null ||
        _myBox.get("class") == null ||
        _myBox.get("STUDENT") == null) {
      db.InitialData();
    } else {
      db.LoadData();
    }
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    db.Items.sort();
    return Scaffold(
      body: db.Items.length > 0
          ? ListView.separated(
              itemCount: db.Items.length,
              itemBuilder: (_, index) {
                return ListTile(
                  leading: const Icon(Icons.school),
                  trailing: const Icon(Icons.arrow_forward),
                  title: Center(child: Text(db.Items[index])),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) =>
                                InsideList(db.Items[index]))));
                  },
                  onLongPress: (() async {
                    await showDialog(
                        context: context,
                        builder: ((context) {
                          return AlertDialog(
                            title: const Text(
                              "Are you sure you want to delete this class and it's students?",
                              style: TextStyle(fontSize: 20),
                            ),
                            actions: [
                              TextButton(
                                  child: Text("Cancel"),
                                  onPressed: (() {
                                    Navigator.pop(context);
                                  })),
                              TextButton(
                                child: Text('Delete'),
                                onPressed: () {
                                  setState(() {
                                    for (var i = db.Students.length - 1;
                                        i >= 0;
                                        i--) {
                                      if (db.ClassName[i] == db.Items[index]) {
                                        db.Students.removeAt(i);
                                        db.ClassName.removeAt(i);
                                        db.SelectedRadio.removeAt(i);
                                      }
                                    }
                                    db.Items.removeAt(index);
                                    db.UpdateDataBase();
                                    Navigator.pop(context);
                                  });
                                },
                              ),
                            ],
                          );
                        }));
                  }),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                color: Colors.black,
              ),
            )
          : const Center(
              child: Text("You currently have no classes. Add from below."),
            ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_arrow,
        spacing: 6,
        spaceBetweenChildren: 6,
        backgroundColor: const Color.fromARGB(255, 22, 37, 50),
        foregroundColor: const Color.fromARGB(255, 255, 255, 255),
        children: [
          SpeedDialChild(
            child: const Icon(Icons.school),
            label: "Add Class",
            onTap: () async {
              final result = await showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Add a new class'),
                    content: TextField(
                      controller: _textController,
                      autofocus: true,
                      decoration: const InputDecoration(
                          hintText: "Enter the name of the class."),
                    ),
                    actions: [
                      TextButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      TextButton(
                        child: Text('Add'),
                        onPressed: () {
                          Navigator.pop(context, _textController.text);
                          db.UpdateDataBase();
                          _textController.clear();
                        },
                      ),
                    ],
                  );
                },
              );
              if (result != null) {
                result as String;
                setState(() {
                  db.Items.add(result);
                });
              }
            },
          )
        ],
      ),
    );
  }
}
