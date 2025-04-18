import 'package:hive_ce/hive.dart';

class HiveArchive {
  final box = Hive.box('names');

  void saveName() {
    box.put('names', 'ruvinda');
    final myName = box.get('names');
  }
}
