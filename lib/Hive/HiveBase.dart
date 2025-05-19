import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';


class HiveArchive {
  final box = Hive.box('myBox');
  final resBox = Hive.box('reservations');

  addToHiveBox(int index, String name) {
    box.put('index$index', index);
    box.put('myName$index', name);
  }

  clearHiveBox() {
    box.clear();
  }

  List<Map<String, dynamic>> getReservedNameAndIndex(int listIndex) {
    final List<Map<String, dynamic>> reservedData = [];
    for (int i = 0; i < 38; i++) {
      final name = box.get('myName$i');
      final index = box.get('index$i');
      if (name != null && index != null && index == listIndex) {
        reservedData.add({'index': index, 'name': name});
      }
    }
    return reservedData;
  }

  String returnName(int listIndex) {
    //addToHiveBox();
    for (int i = 0; i < 38; i++) {
      final index = box.get('index$i');
      if (listIndex == index) {
        return box.get('myName$i');
      }
    }
    return '';
  }

  Color addColorToCells(int listIndex) {
    if (getReservationDetails(listIndex) != null) {
      return Colors.green;
    }
    return Colors.grey;
  }

  Map<String, dynamic>? getReservationDetails(int listIndex) {
    final data = resBox.get(listIndex);
    if (data == null) return null;
    return Map<String, dynamic>.from(data);
  }
}
