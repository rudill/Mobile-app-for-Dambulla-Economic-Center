import 'package:flutter/material.dart';

class FontSizeController {
  static final ValueNotifier<double> fontSize = ValueNotifier<double>(1.0);

  static void increaseFont() {
    if (fontSize.value < 1.5) {
      fontSize.value += 0.1;
    }
  }

  static void decreaseFont() {
    if (fontSize.value > 0.5) {
      fontSize.value -= 0.1;
    }
  }
}
