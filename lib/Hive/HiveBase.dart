import 'package:flutter/cupertino.dart';
import 'package:hive_ce/hive.dart';

class HiveArchive {
  HiveArchive({required this.timeSlot});

  final int timeSlot;
  late final int index = 4;
  final box = Hive.box('myBox');

  reservedName() {
    // Hive.openBox('myBox');
    // box.put('name', 'ruvinda');
    final name = box.get('name');
    if (index != timeSlot) {
      return 'na';
    }
    return name;
  }
}
