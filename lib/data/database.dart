import 'package:hive_flutter/hive_flutter.dart';

class ListDataBase {
  List Items = [];
  List ClassName = [];
  List Students = [];
  List<int> SelectedRadio = [];

  final _mybox = Hive.box("mybox");

  void InitialData() {
    Items = ["Example"];
    Students = ["Example"];
    ClassName = ["Example"];
    SelectedRadio = [0];
  }

  void LoadData() {
    Items = _mybox.get("NAMES");
    Students = _mybox.get("STUDENT");
    ClassName = _mybox.get("class");
    SelectedRadio = _mybox.get("index");
  }

  void UpdateDataBase() {
    _mybox.put("NAMES", Items);
    _mybox.put("class", ClassName);
    _mybox.put("STUDENT", Students);
    _mybox.put("index", SelectedRadio);
  }
}
