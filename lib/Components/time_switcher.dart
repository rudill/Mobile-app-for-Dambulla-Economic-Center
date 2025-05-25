class TimeSwitcher {
  late int timeslot;

  int switchTimeToTimeSlot(String pickedTime) {
    switch (pickedTime) {
      case '4':
        timeslot = 0;
        return timeslot;
      case '5':
        timeslot = 2;
        return timeslot;
      case '6':
        timeslot = 4;
        return timeslot;
      case '7':
        timeslot = 6;
        return timeslot;
      case '8':
        timeslot = 8;
        return timeslot;
      case '9':
        timeslot = 10;
        return timeslot;
      case '10':
        timeslot = 12;
        return timeslot;
      case '11':
        timeslot = 14;
        return timeslot;
      case '12':
        timeslot = 16;
        return timeslot;
      case '13':
        timeslot = 18;
        return timeslot;
      case '14':
        timeslot = 20;
        return timeslot;
      case '15':
        timeslot = 22;
        return timeslot;
      case '16':
        timeslot = 24;
        return timeslot;
      case '17':
        timeslot = 26;
        return timeslot;
      case '18':
        timeslot = 28;
        return timeslot;
      case '19':
        timeslot = 30;
        return timeslot;
      case '20':
        timeslot = 32;
        return timeslot;
      case '21':
        timeslot = 34;
        return timeslot;
      case '22':
        timeslot = 36;
        return timeslot;
      default:
        throw Exception('Invalid time');
    }
  }
}
