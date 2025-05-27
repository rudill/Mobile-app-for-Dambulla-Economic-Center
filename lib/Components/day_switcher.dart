import 'package:intl/intl.dart';

class DaySwitcher {
  String nameOfTheDay = DateFormat('EEEE').format(DateTime.now());

  String switchToDay() {
    switch (nameOfTheDay) {
      case 'Monday':
        return 'සඳුදා';
      case 'Tuesday':
        return 'අඟහරුවාදා';
      case 'Wednesday':
        return 'බදාදා';
      case 'Thursday':
        return 'බ්‍රහස්පතින්දා';
      case 'Friday':
        return 'සිකුරාදා';
      case 'Saturday':
        return 'සෙනසුරාදා';
      case 'Sunday':
        return 'ඉරිදා';
      default:
        return nameOfTheDay;
    }
  }
}
