import 'dart:ui';

import 'package:flutter/material.dart';

/**
 * Created by Amuser
 * Date:2020/1/7.
 * Desc:
 */
class CommonUtil{
  static Color getChaptersColor(int index) {
    switch (index) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.deepPurple;
      case 4:
        return Colors.green;
      case 5:
        return Colors.purple;
      default:
        return Colors.blue;

    }
  }
}