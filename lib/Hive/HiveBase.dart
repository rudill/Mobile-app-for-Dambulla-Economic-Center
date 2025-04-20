import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';

class HiveArchive {
  HiveArchive({required this.timeSlot});

  final int timeSlot;
  final int index1 = 22;
  final int index2 = 2;
  final int index3 = 12;

  final String myName1 = 'Danu';
  final String myName2 = 'Dilo';
  final String myName3 = 'faruza';

  final box = Hive.box('myBox');

  addToHiveBox() {
    box.putAll({
      'index1': index1,
      'myName1': myName1,
      'index2': index2,
      'myName2': myName2,
      'index3': index3,
      'myName3': myName3,
    });
  }

  reservedName() {
    // Hive.openBox('myBox');
    // box.put('name', 'ruvinda');
    final name = box.get('myName2');
    // while (index1 == timeSlot){
    //   return name;
    //
    // }
    if (index2 != timeSlot) {
      return '';
    }
    return name;
  }

  List<Map<String, dynamic>> getReservedNameAndIndex() {
    final List<Map<String, dynamic>> reservedData = [];
    for (int i = 0; i < 38; i++) {
      final name = box.get('myName$i');
      final index = box.get('index$i');
      if (name != null && index != null && timeSlot == index) {
        reservedData.add({'index': index, 'name': name});
      }
    }
    return reservedData;
  }

  Color addColorToCells() {
    if (reservedName() != '') {
      return Colors.green;
    }
    return Colors.grey;
  }
}
