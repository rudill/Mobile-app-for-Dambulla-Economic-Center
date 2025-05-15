import 'package:flutter/material.dart';

Future<String> getPickedTime(BuildContext context) async {
  final TimeOfDay? selectedTime = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );

  if (selectedTime != null) {
    final String formattedTime =
        selectedTime.hour.toString();
    return formattedTime;
  }
  return 'N/A';
}
