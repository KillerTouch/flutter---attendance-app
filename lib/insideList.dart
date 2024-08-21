import 'package:attendance/data/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:hive_flutter/hive_flutter.dart';

class InsideList extends StatefulWidget {
  final String name;

  InsideList(this.name);

  @override
  State<InsideList> createState() => _InsideListState();
}

class _InsideListState extends State<InsideList> {
  final _myBox = Hive.box('mybox');

  ListDataBase db = ListDataBase();

  late TextEditingController _textController;
  List FilteredStudents = [];
  List<int> FilteredRadio = [];

  @override
  void initState() {
    if (_myBox.get("STUDENT") == null || _myBox.get("class") == null) {
      db.InitialData();
    } else {
      db.LoadData();
    }
    for (var i = 0; i < db.Students.length; i++) {
      if (db.ClassName[i] == widget.name) {
        FilteredStudents.add(db.Students[i]);
      }
    }
    for (var i = 0; i < db.SelectedRadio.length; i++) {
      if (db.ClassName[i] == widget.name) {
        FilteredRadio.add(db.SelectedRadio[i]);
      }
      //FilteredStudents.sort();
    }

    super.initState();
    _textController = TextEditingController();
  }

  void _selectRadio(int index, int? val) {
    setState(() {
      FilteredRadio[index] = val ?? 0;
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 22, 37, 50),
        toolbarHeight: 65,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: FilteredStudents.length > 0
          ? ListView.separated(
              itemCount: FilteredStudents.length,
              itemBuilder: (_, index) {
                return ListTile(
                  leading: const Icon(Icons.person),
                  trailing: FittedBox(
                    fit: BoxFit.fill,
                    child: Row(
                      children: [
                        Radio(
                            activeColor: Colors.green,
                            value: 0,
                            groupValue: FilteredRadio[index],
                            onChanged: (val) {
                              _selectRadio(index, val);
                              for (var i = 0;
                                  i < db.SelectedRadio.length;
                                  i++) {
                                if (db.Students[i] == FilteredStudents[index] &&
                                    db.ClassName[i] == widget.name) {
                                  db.SelectedRadio[i] = val ?? 0;
                                }
                              }
                              db.UpdateDataBase();
                            }),
                        Radio(
                            activeColor: Colors.red,
                            value: 1,
                            groupValue: FilteredRadio[index],
                            onChanged: (val) {
                              _selectRadio(index, val);
                              for (var i = 0;
                                  i < db.SelectedRadio.length;
                                  i++) {
                                if (db.Students[i] == FilteredStudents[index] &&
                                    db.ClassName[i] == widget.name) {
                                  db.SelectedRadio[i] = val ?? 0;
                                }
                              }
                              db.UpdateDataBase();
                            }),
                      ],
                    ),
                  ),
                  title: Center(
                    child: Text(FilteredStudents[index]),
                  ),
                  onLongPress: (() async {
                    await showDialog(
                      context: context,
                      builder: ((context) {
                        return AlertDialog(
                          title: const Text(
                            "Are you sure you want to delete this student?",
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
                                  for (var i = 0; i < db.Students.length; i++) {
                                    if (db.Students[i] ==
                                        FilteredStudents[index]) {
                                      db.Students.removeAt(i);
                                      db.ClassName.removeAt(i);
                                      db.SelectedRadio.removeAt(i);
                                    }
                                  }
                                  FilteredStudents.removeAt(index);
                                  db.UpdateDataBase();
                                  Navigator.pop(context);
                                });
                              },
                            ),
                          ],
                        );
                      }),
                    );
                  }),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                color: Colors.black,
              ),
            )
          : const Center(
              child: Text("You currently have no students. Add from below."),
            ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_arrow,
        spacing: 6,
        spaceBetweenChildren: 6,
        backgroundColor: const Color.fromARGB(255, 22, 37, 50),
        foregroundColor: const Color.fromARGB(255, 255, 255, 255),
        children: [
          SpeedDialChild(
            child: const Icon(Icons.group_add),
            label: "Add student",
            onTap: () async {
              final result = await showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Add a new student'),
                    content: TextField(
                      controller: _textController,
                      autofocus: true,
                      decoration: const InputDecoration(
                          hintText: "Enter the name of the student."),
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
                  db.Students.add(result);
                  db.ClassName.add(widget.name);
                  db.SelectedRadio.add(0);
                  FilteredStudents.add(result);
                  FilteredRadio.add(0);
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
