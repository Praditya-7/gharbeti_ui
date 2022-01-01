import 'dart:convert';

class DataClass {
  static DataClass? _instance;

  DataClass._();

  static DataClass get getInstance => _instance ??= DataClass._();
  List<String> removeList = [];

  setData(List<String> list) {
    removeList = list;
  }

  List<String> getData() {
    return removeList;
  }
}
