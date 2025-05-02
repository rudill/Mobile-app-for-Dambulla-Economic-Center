import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';

class HiveArchive {
  final box = Hive.box('myBox');

  // addToHiveBox() {
  //   box.putAll({
  //     'index1': index1,
  //     'myName1': myName1,
  //     'index2': index2,
  //     'myName2': myName2,
  //     'index3': index3,
  //     'myName3': myName3,
  //     'index4': index4,
  //     'myName4': myName4,
  //     'index5': index5,
  //     'myName5': myName5,
  //     'index6': index6,
  //     'myName6': myName6,
  //     'index7': index7,
  //     'myName7': myName7,
  //     'index8': index8,
  //     'myName8': myName8,
  //     'index9': index9,
  //     'myName9': myName9,
  //     'index10': index10,
  //     'myName10': myName10,
  //     'index11': index11,
  //     'myName11': myName11,
  //     'index12': index12,
  //     'myName12': myName12,
  //     'index13': index13,
  //     'myName13': myName13,
  //     'index14': index14,
  //     'myName14': myName14,
  //     'index15': index15,
  //     'myName15': myName15,
  //     'index16': index16,
  //     'myName16': myName16,
  //     'index17': index17,
  //     'myName17': myName17,
  //     'index18': index18,
  //     'myName18': myName18,
  //     'index19': index19,
  //     'myName19': myName19,
  //     'index20': index20,
  //     'myName20': myName20,
  //   });
  // }

  addToHiveBoxFromForm(int index, String name) {
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
    if (returnName(listIndex) != '') {
      return Colors.green;
    }
    return Colors.grey;
  }
}
