import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';

class HiveArchive {
  final int index1 = 1;
  final String myName1 = 'Danu';

  final int index2 = 2;
  final String myName2 = 'Dilo';

  final int index3 = 4;
  final String myName3 = 'Faruza';

  final int index4 = 6;
  final String myName4 = 'Ravi';

  final int index5 = 8;
  final String myName5 = 'Nilu';

  final int index6 = 10;
  final String myName6 = 'Sami';

  final int index7 = 11;
  final String myName7 = 'Tasha';

  final int index8 = 12;
  final String myName8 = 'Lahiru';

  final int index9 = 13;
  final String myName9 = 'Kavi';

  final int index10 = 14;
  final String myName10 = 'Mira';

  final int index11 = 15;
  final String myName11 = 'Jude';

  final int index12 = 16;
  final String myName12 = 'Anu';

  final int index13 = 18;
  final String myName13 = 'Rehan';

  final int index14 = 20;
  final String myName14 = 'Isha';

  final int index15 = 21;
  final String myName15 = 'Zane';

  final int index16 = 22;
  final String myName16 = 'Nora';

  final int index17 = 24;
  final String myName17 = 'Chathu';

  final int index18 = 26;
  final String myName18 = 'Pasan';

  final int index19 = 28;
  final String myName19 = 'Amira';

  final int index20 = 30;
  final String myName20 = 'Dev';

  final box = Hive.box('myBox');

  addToHiveBox() {
    box.putAll({
      'index1': index1,
      'myName1': myName1,
      'index2': index2,
      'myName2': myName2,
      'index3': index3,
      'myName3': myName3,
      'index4': index4,
      'myName4': myName4,
      'index5': index5,
      'myName5': myName5,
      'index6': index6,
      'myName6': myName6,
      'index7': index7,
      'myName7': myName7,
      'index8': index8,
      'myName8': myName8,
      'index9': index9,
      'myName9': myName9,
      'index10': index10,
      'myName10': myName10,
      'index11': index11,
      'myName11': myName11,
      'index12': index12,
      'myName12': myName12,
      'index13': index13,
      'myName13': myName13,
      'index14': index14,
      'myName14': myName14,
      'index15': index15,
      'myName15': myName15,
      'index16': index16,
      'myName16': myName16,
      'index17': index17,
      'myName17': myName17,
      'index18': index18,
      'myName18': myName18,
      'index19': index19,
      'myName19': myName19,
      'index20': index20,
      'myName20': myName20,
    });
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
    addToHiveBox();
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
